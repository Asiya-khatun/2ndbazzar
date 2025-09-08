package com.asiya.projectbazar.algorithms;

import com.asiya.projectbazar.entity.Product;

public class FeaturesExtraction {

    // Safe string helper
    private String safe(String s) {
        return (s == null) ? "" : s.trim().toLowerCase();
    }

    public double[] extract(Product product, OrderHistory history) {
        double bias = 1.0;

        // Category match (Enums can be compared with ==)
        double categoryMatch = (product.getCategory() == history.getCategory()) ? 1.0 : 0.0;

        // Product name exact match
        double productNameMatch = safe(product.getName()).equals(safe(history.getproductName())) ? 1.0 : 0.0;

        // Same seller match
        double sameSeller = (product.getUser() != null && history.getOwner() != null &&
                             product.getUser().getId() == history.getOwner().getId()) ? 1.0 : 0.0;

        // Text overlap match (checks name and description)
        String combinedText = safe(product.getName()) + " " + safe(product.getDescription());
        double textOverlap = combinedText.contains(safe(history.getDescription())) ? 1.0 : 0.0;

        // Return features for the ML models
        return new double[] { bias, categoryMatch, productNameMatch, sameSeller, textOverlap };
    }


	private double jaccardTokenOverlap(String a, String b) {
		String[] at = a.split("\\W+");
		String[] bt = b.split("\\W+");
		java.util.Set<String> A = new java.util.HashSet<>();
		java.util.Set<String> B = new java.util.HashSet<>();
		for (String t : at) if (!t.isBlank()) A.add(t);
		for (String t : bt) if (!t.isBlank()) B.add(t);
		if (A.isEmpty() && B.isEmpty()) return 0.0;
		java.util.Set<String> inter = new java.util.HashSet<>(A);
		inter.retainAll(B);
		java.util.Set<String> union = new java.util.HashSet<>(A);
		union.addAll(B);
		return union.isEmpty() ? 0.0 : (double) inter.size() / (double) union.size();
	}
}