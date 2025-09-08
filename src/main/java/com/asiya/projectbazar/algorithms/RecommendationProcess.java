// Java
package com.asiya.projectbazar.algorithms;

import java.util.*;
import java.util.stream.Collectors;

import com.asiya.projectbazar.dto.RecommendedProductDTO;
import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.enums.CategoryEnum;

public class RecommendationProcess {

    public enum ModelType { LOGISTIC_REGRESSION, NAIVE_BAYES }

    private final FeaturesExtraction featureExtractor = new FeaturesExtraction();

    // Tunables
    private double descriptionSimilarityThreshold = 0.10;
    private int negativesPerPositive = 3;
    private boolean evaluationLogging = false;

    public RecommendationProcess withDescriptionSimilarityThreshold(double t) {
        this.descriptionSimilarityThreshold = t;
        return this;
    }

    public RecommendationProcess withNegativesPerPositive(int k) {
        this.negativesPerPositive = Math.max(0, k);
        return this;
    }

    public RecommendationProcess withEvaluationLogging(boolean enabled) {
        this.evaluationLogging = enabled;
        return this;
    }

    // Single-model: products
    public List<Product> recommendProducts(
            List<OrderHistory> userOrders,
            List<Product> allProducts,
            ModelType modelType,
            int topN) {

        List<Scored<Product>> scored = scoreCandidatesSingle(userOrders, allProducts, modelType);
        scored.sort((a, b) -> {
            int cmp = Double.compare(b.score, a.score);
            return (cmp != 0) ? cmp : Integer.compare(a.item.getId(), b.item.getId());
        });
        return scored.stream().map(s -> s.item).limit(topN).collect(Collectors.toList());
    }

    // Single-model: DTOs
    public List<RecommendedProductDTO> recommendProductsWithScores(
            List<OrderHistory> userOrders,
            List<Product> allProducts,
            ModelType modelType,
            int topN) {

        List<Scored<Product>> scored = scoreCandidatesSingle(userOrders, allProducts, modelType);
        scored.sort((a, b) -> {
            int cmp = Double.compare(b.score, a.score);
            return (cmp != 0) ? cmp : Integer.compare(a.item.getId(), b.item.getId());
        });

        return scored.stream()
                .map(s -> RecommendedProductDTO.fromProduct(s.item, s.score))
                .limit(topN)
                .collect(Collectors.toList());
    }

    // NEW: one-pass scoring for both models (returns both DTO lists)
    public BothModelResult recommendBothWithScores(
            List<OrderHistory> userOrders,
            List<Product> allProducts,
            int topN) {

        if (userOrders == null || userOrders.isEmpty()) {
            return new BothModelResult(Collections.emptyList(), Collections.emptyList());
        }

        // Exclude buyer's own products and already purchased products
        Set<Integer> buyerIds = userOrders.stream()
                .map(h -> h.getOwner() != null ? h.getOwner().getId() : null)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Set<Integer> purchasedIds = userOrders.stream()
                .map(OrderHistory::getProductId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        // Train once
        List<TrainingExample> training = buildTrainingData(userOrders, allProducts);
        if (training.isEmpty()) {
            return new BothModelResult(Collections.emptyList(), Collections.emptyList());
        }

        RecommenderModel nb = Recommenders.naiveBayesDefault();
        RecommenderModel lr = Recommenders.logisticRegressionDefault();
        nb.train(training);
        lr.train(training);

        if (evaluationLogging) {
            int n = training.size();
            int[] actual = new int[n];
            int[] nbPred = new int[n];
            int[] lrPred = new int[n];
            for (int i = 0; i < n; i++) {
                TrainingExample ex = training.get(i);
                actual[i] = ex.y;
                nbPred[i] = nb.score(ex.x) >= 0.5 ? 1 : 0;
                lrPred[i] = lr.score(ex.x) >= 0.5 ? 1 : 0;
            }
            NaiveBayesModel.evaluateModel(actual, nbPred);
            LogisticRegressionModel.evaluateModel(actual, lrPred);
        }

        Map<Product, List<Double>> nbScores = new HashMap<>();
        Map<Product, List<Double>> lrScores = new HashMap<>();

        for (OrderHistory context : userOrders) {
            for (Product p : prioritizedCandidates(allProducts, context, buyerIds, purchasedIds)) {
                double[] x = featureExtractor.extract(p, context);
                nbScores.computeIfAbsent(p, k -> new ArrayList<>()).add(nb.score(x));
                lrScores.computeIfAbsent(p, k -> new ArrayList<>()).add(lr.score(x));
            }
        }

        List<Scored<Product>> nbAgg = aggregateScores(nbScores);
        List<Scored<Product>> lrAgg = aggregateScores(lrScores);

        nbAgg.sort((a, b) -> {
            int cmp = Double.compare(b.score, a.score);
            return (cmp != 0) ? cmp : Integer.compare(a.item.getId(), b.item.getId());
        });
        lrAgg.sort((a, b) -> {
            int cmp = Double.compare(b.score, a.score);
            return (cmp != 0) ? cmp : Integer.compare(a.item.getId(), b.item.getId());
        });

        List<RecommendedProductDTO> nbDto = nbAgg.stream()
                .map(s -> RecommendedProductDTO.fromProduct(s.item, s.score))
                .limit(topN)
                .collect(Collectors.toList());
        List<RecommendedProductDTO> lrDto = lrAgg.stream()
                .map(s -> RecommendedProductDTO.fromProduct(s.item, s.score))
                .limit(topN)
                .collect(Collectors.toList());

        return new BothModelResult(nbDto, lrDto);
    }

    // Single-model internal scoring (kept for backward compatibility)
    private List<Scored<Product>> scoreCandidatesSingle(
            List<OrderHistory> userOrders,
            List<Product> allProducts,
            ModelType modelType) {

        if (userOrders == null || userOrders.isEmpty()) return Collections.emptyList();

        Set<Integer> buyerIds = userOrders.stream()
                .map(h -> h.getOwner() != null ? h.getOwner().getId() : null)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Set<Integer> purchasedIds = userOrders.stream()
                .map(OrderHistory::getProductId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        List<TrainingExample> training = buildTrainingData(userOrders, allProducts);
        if (training.isEmpty()) return Collections.emptyList();

        RecommenderModel model = switch (modelType) {
            case LOGISTIC_REGRESSION -> Recommenders.logisticRegressionDefault();
            case NAIVE_BAYES -> Recommenders.naiveBayesDefault();
        };
        model.train(training);

        if (evaluationLogging) {
            int[] actual = new int[training.size()];
            int[] pred = new int[training.size()];
            for (int i = 0; i < training.size(); i++) {
                TrainingExample ex = training.get(i);
                actual[i] = ex.y;
                pred[i] = model.score(ex.x) >= 0.5 ? 1 : 0;
            }
            if (model instanceof NaiveBayesModel) NaiveBayesModel.evaluateModel(actual, pred);
            if (model instanceof LogisticRegressionModel) LogisticRegressionModel.evaluateModel(actual, pred);
        }

        Map<Product, List<Double>> productScores = new HashMap<>();
        for (OrderHistory context : userOrders) {
            for (Product p : prioritizedCandidates(allProducts, context, buyerIds, purchasedIds)) {
                double[] x = featureExtractor.extract(p, context);
                productScores.computeIfAbsent(p, k -> new ArrayList<>()).add(model.score(x));
            }
        }
        return aggregateScores(productScores);
    }

    // Candidate prioritization (excludes buyer's products and repeats)
    private List<Product> prioritizedCandidates(List<Product> allProducts,
                                                OrderHistory context,
                                                Set<Integer> buyerIds,
                                                Set<Integer> purchasedIds) {
        List<Product> exactCategoryNameMatches = new ArrayList<>();
        List<Product> categoryDescriptionMatches = new ArrayList<>();
        List<Product> sameCategoryMatches = new ArrayList<>();
        List<Product> sameSellerMatches = new ArrayList<>();

        for (Product p : allProducts) {
            if (p == null || p.getUser() == null) continue;
            if (buyerIds.contains(p.getUser().getId())) continue;
            if (purchasedIds.contains(p.getId())) continue;

            if (p.getCategory() != null && p.getCategory().equals(context.getCategory())) {
                if (safe(p.getName()).equals(safe(context.getproductName()))) {
                    exactCategoryNameMatches.add(p);
                    continue;
                } else {
                    double overlap = jaccard(safe(context.getDescription()), safe(p.getDescription()));
                    if (overlap >= descriptionSimilarityThreshold) {
                        categoryDescriptionMatches.add(p);
                        continue;
                    }
                }
                sameCategoryMatches.add(p);
            }
            if (context.getSellerId() != null && p.getUser().getId() == context.getSellerId()) {
                sameSellerMatches.add(p);
            }
        }

        List<Product> candidates = new ArrayList<>();
        if (!exactCategoryNameMatches.isEmpty()) candidates.addAll(exactCategoryNameMatches);
        else if (!categoryDescriptionMatches.isEmpty()) candidates.addAll(categoryDescriptionMatches);
        else if (!sameCategoryMatches.isEmpty()) candidates.addAll(sameCategoryMatches);
        else candidates.addAll(sameSellerMatches);

        return candidates;
    }

    private List<Scored<Product>> aggregateScores(Map<Product, List<Double>> scores) {
        return scores.entrySet().stream()
                .map(e -> new Scored<>(e.getKey(), e.getValue().stream().mapToDouble(d -> d).average().orElse(0.0)))
                .collect(Collectors.toList());
    }

    private String safe(String s) { return s == null ? "" : s.toLowerCase(); }

    private double jaccard(String a, String b) {
        Set<String> A = new HashSet<>(Arrays.asList(a.toLowerCase().split("\\W+")));
        Set<String> B = new HashSet<>(Arrays.asList(b.toLowerCase().split("\\W+")));
        Set<String> inter = new HashSet<>(A); inter.retainAll(B);
        Set<String> union = new HashSet<>(A); union.addAll(B);
        return union.isEmpty() ? 0.0 : (double) inter.size() / union.size();
    }

    private List<TrainingExample> buildTrainingData(List<OrderHistory> userOrders, List<Product> allProducts) {
        List<TrainingExample> data = new ArrayList<>();
        Map<CategoryEnum, List<Product>> byCategory = allProducts.stream()
                .filter(p -> p != null && p.getCategory() != null)
                .collect(Collectors.groupingBy(Product::getCategory));

        Random rng = new Random(42);

        for (OrderHistory h : userOrders) {
            // positives: same category
            List<Product> sameCat = byCategory.getOrDefault(h.getCategory(), Collections.emptyList());
            for (Product p : sameCat) {
                if (p.getUser() == null) continue;
                if (h.getOwner() != null && p.getUser().getId() == h.getOwner().getId()) continue;
                double[] x = featureExtractor.extract(p, h);
                data.add(new TrainingExample(x, 1));
            }

            // negatives: other categories
            List<Product> otherCats = allProducts.stream()
                    .filter(p -> p != null && p.getCategory() != h.getCategory())
                    .collect(Collectors.toList());
            Collections.shuffle(otherCats, rng);
            int take = Math.min(negativesPerPositive, otherCats.size());
            for (int i = 0; i < take; i++) {
                Product neg = otherCats.get(i);
                if (neg.getUser() == null) continue;
                if (h.getOwner() != null && neg.getUser().getId() == h.getOwner().getId()) continue;
                double[] x = featureExtractor.extract(neg, h);
                data.add(new TrainingExample(x, 0));
            }
        }
        return data;
    }

    // Helpers
    private static class Scored<T> { final T item; final double score; Scored(T item, double score) { this.item = item; this.score = score; } }
    public static class TrainingExample { public final double[] x; public final int y; public TrainingExample(double[] x, int y) { this.x = x; this.y = y; } }

    // NEW: result holder type for one-pass API
    public static class BothModelResult {
        private final List<RecommendedProductDTO> naive;
        private final List<RecommendedProductDTO> logistic;

        public BothModelResult(List<RecommendedProductDTO> naive, List<RecommendedProductDTO> logistic) {
            this.naive = naive;
            this.logistic = logistic;
        }
        public List<RecommendedProductDTO> getNaive() { return naive; }
        public List<RecommendedProductDTO> getLogistic() { return logistic; }
    }
}








//package com.asiya.projectbazar.algorithms;
//
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.Objects;
//import java.util.Random;
//import java.util.Set;
//import java.util.stream.Collectors;
//
//import com.asiya.projectbazar.dto.RecommendedProductDTO;
//import com.asiya.projectbazar.entity.Product;
//import com.asiya.projectbazar.enums.CategoryEnum;
//
//public class RecommendationProcess {
//
//    public enum ModelType { LOGISTIC_REGRESSION, NAIVE_BAYES }
//
//    private final FeaturesExtraction featureExtractor = new FeaturesExtraction();
//
//    public List<Product> recommendProducts(
//            List<OrderHistory> userOrders,
//            List<Product> allProducts,
//            ModelType modelType,
//            int topN) {
//
//        List<Scored<Product>> agg = scoreCandidates(userOrders, allProducts, modelType, topN);
//        return agg.stream().map(s -> s.item).collect(Collectors.toList());
//    }
//
//    public List<RecommendedProductDTO> recommendProductsWithScores(
//            List<OrderHistory> userOrders,
//            List<Product> allProducts,
//            ModelType modelType,
//            int topN) {
//
//        List<Scored<Product>> agg = scoreCandidates(userOrders, allProducts, modelType, topN);
//        List<RecommendedProductDTO> out = new ArrayList<>(agg.size());
//        for (Scored<Product> s : agg) out.add(RecommendedProductDTO.fromProduct(s.item, s.score));
//        return out;
//    }
//
//    private List<Scored<Product>> scoreCandidates(
//            List<OrderHistory> userOrders,
//            List<Product> allProducts,
//            ModelType modelType,
//            int topN) {
//
//        if (userOrders == null || userOrders.isEmpty()) return Collections.emptyList();
//
//        List<TrainingExample> training = buildTrainingData(userOrders, allProducts);
//        if (training.isEmpty()) return Collections.emptyList();
//
//        RecommenderModel model = switch (modelType) {
//            case LOGISTIC_REGRESSION -> Recommenders.logisticRegressionDefault();
//            case NAIVE_BAYES -> Recommenders.naiveBayesDefault();
//        };
//        model.train(training);
//     //   for the analysis
//      int[] actualLabels = new int[training.size()];
//      int[] predictedLabels = new int[training.size()];
//
//      for (int i = 0; i < training.size(); i++) {
//          TrainingExample ex = training.get(i);
//          actualLabels[i] = ex.y;
//          predictedLabels[i] = model.score(ex.x) >= 0.5 ? 1 : 0;
//      }
//
//      // Print evaluation metrics
//      if (model instanceof NaiveBayesModel) NaiveBayesModel.evaluateModel(actualLabels, predictedLabels);
//      if (model instanceof LogisticRegressionModel) LogisticRegressionModel.evaluateModel(actualLabels, predictedLabels);
//      
//        // Exclude buyer’s own products
//        Set<Integer> buyerIds = userOrders.stream()
//                .map(h -> h.getOwner() != null ? h.getOwner().getId() : null)
//                .filter(Objects::nonNull)
//                .collect(Collectors.toSet());
//
//        // Seen categories
//        Set<CategoryEnum> seenCategories = userOrders.stream()
//                .map(OrderHistory::getCategory)
//                .filter(Objects::nonNull)
//                .collect(Collectors.toSet());
//
//        // Priority 1a: exact category + exact name matches
//        List<Product> exactCategoryNameMatches = new ArrayList<>();
//        for (Product p : allProducts) {
//            if (p == null || p.getUser() == null || buyerIds.contains(p.getUser().getId())) continue;
//            for (OrderHistory h : userOrders) {
//                if (p.getCategory() != null && p.getCategory().equals(h.getCategory())
//                        && safe(p.getName()).equals(safe(h.getDescription()))) {
//                    exactCategoryNameMatches.add(p);
//                    break;
//                }
//            }
//        }
//
//        // Priority 1b: same category, excluding exact name matches
//        List<Product> sameCategoryMatches = new ArrayList<>();
//        for (Product p : allProducts) {
//            if (p == null || p.getUser() == null || buyerIds.contains(p.getUser().getId())
//                    || exactCategoryNameMatches.contains(p)) continue;
//            if (p.getCategory() != null && seenCategories.contains(p.getCategory())) {
//                sameCategoryMatches.add(p);
//            }
//        }
//
//        List<Product> candidates = new ArrayList<>();
//        candidates.addAll(exactCategoryNameMatches);
//        candidates.addAll(sameCategoryMatches);
//
//        // Priority 2: category + description similarity (fallback if no Priority 1 matches)
//        if (candidates.isEmpty()) {
//            double descThreshold = 0.10;
//            for (Product p : allProducts) {
//                if (p == null || p.getUser() == null || buyerIds.contains(p.getUser().getId())) continue;
//                for (OrderHistory h : userOrders) {
//                    if (p.getCategory() != null && p.getCategory().equals(h.getCategory())) {
//                        double overlap = jaccard(safe(h.getDescription()), safe(p.getDescription()));
//                        if (overlap >= descThreshold) {
//                            candidates.add(p);
//                            break;
//                        }
//                    }
//                }
//            }
//        }
//
//        if (candidates.isEmpty()) return Collections.emptyList();
//
//        // Score candidates using ML model
//        List<Scored<Product>> scored = new ArrayList<>();
//        for (OrderHistory context : userOrders) {
//            for (Product candidate : candidates) {
//                double[] x = featureExtractor.extract(candidate, context);
//                double s = model.score(x);
//                scored.add(new Scored<>(candidate, s));
//            }
//        }
//
//        // Aggregate scores per product
//        Map<Product, List<Double>> grouped = new HashMap<>();
//        for (Scored<Product> s : scored) {
//            grouped.computeIfAbsent(s.item, k -> new ArrayList<>()).add(s.score);
//        }
//
//        return grouped.entrySet().stream()
//                .map(e -> new Scored<>(e.getKey(), e.getValue().stream().mapToDouble(d -> d).average().orElse(0.0)))
//                .sorted((a, b) -> Double.compare(b.score, a.score))
//                .limit(topN)
//                .collect(Collectors.toList());
//    }
//
//    private String safe(String s) { return s == null ? "" : s.toLowerCase(); }
//
//    private double jaccard(String a, String b) {
//        String[] at = a.split("\\W+");
//        String[] bt = b.split("\\W+");
//        Set<String> A = new java.util.HashSet<>();
//        Set<String> B = new java.util.HashSet<>();
//        for (String t : at) if (!t.isBlank()) A.add(t);
//        for (String t : bt) if (!t.isBlank()) B.add(t);
//        if (A.isEmpty() && B.isEmpty()) return 0.0;
//        Set<String> inter = new java.util.HashSet<>(A);
//        inter.retainAll(B);
//        Set<String> union = new java.util.HashSet<>(A);
//        union.addAll(B);
//        return union.isEmpty() ? 0.0 : (double) inter.size() / (double) union.size();
//    }
//
//    private List<TrainingExample> buildTrainingData(List<OrderHistory> userOrders, List<Product> allProducts) {
//        List<TrainingExample> data = new ArrayList<>();
//        Map<CategoryEnum, List<Product>> byCategory = allProducts.stream()
//                .filter(p -> p != null && p.getCategory() != null)
//                .collect(Collectors.groupingBy(Product::getCategory));
//
//        Random rng = new Random(42);
//        int negativesPerPositive = 3;
//
//        for (OrderHistory h : userOrders) {
//            // Positives: same category
//            List<Product> sameCat = byCategory.getOrDefault(h.getCategory(), Collections.emptyList());
//            for (Product p : sameCat) {
//                if (p.getUser() == null) continue;
//                if (h.getOwner() != null && p.getUser().getId() == h.getOwner().getId()) continue;
//                double[] x = featureExtractor.extract(p, h);
//                data.add(new TrainingExample(x, 1));
//            }
//
//            // Negatives: other categories
//            List<Product> otherCats = allProducts.stream()
//                    .filter(p -> p != null && p.getCategory() != h.getCategory())
//                    .collect(Collectors.toList());
//            Collections.shuffle(otherCats, rng);
//            int take = Math.min(negativesPerPositive, otherCats.size());
//            for (int i = 0; i < take; i++) {
//                Product neg = otherCats.get(i);
//                if (neg.getUser() == null) continue;
//                if (h.getOwner() != null && neg.getUser().getId() == h.getOwner().getId()) continue;
//                double[] x = featureExtractor.extract(neg, h);
//                data.add(new TrainingExample(x, 0));
//            }
//        }
//        return data;
//    }
//
//    private static class Scored<T> {
//        final T item;
//        final double score;
//        Scored(T item, double score) { this.item = item; this.score = score; }
//    }
//
//    public static class TrainingExample {
//        public final double[] x;
//        public final int y;
//        public TrainingExample(double[] x, int y) { this.x = x; this.y = y; }
//    }
//}
//
//
//
