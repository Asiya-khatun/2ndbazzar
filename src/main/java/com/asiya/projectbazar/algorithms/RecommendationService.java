// Java
package com.asiya.projectbazar.algorithms;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.asiya.projectbazar.dto.RecommendedProductDTO;
import com.asiya.projectbazar.entity.OrderProduct;
import com.asiya.projectbazar.entity.OrderedProducts;
import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.service.OrderService;
import com.asiya.projectbazar.service.UserService;
import com.asiya.projectbazar.algorithms.RecommendationProcess.ModelType;

@Service
public class RecommendationService {

    private final OrderService orderService;
    private final UserService userService;

    // Configure once; tunables can be overridden via setters if needed
    private final RecommendationProcess recommendationProcess =
            new RecommendationProcess()
                    .withDescriptionSimilarityThreshold(0.10)
                    .withNegativesPerPositive(3)
                    .withEvaluationLogging(false);

    public RecommendationService(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    private List<OrderHistory> getUserOrderHistories(String username) {
        User user = userService.getUserByUsername(username);
        if (user == null) return new ArrayList<>();

        List<OrderProduct> orders = orderService.getOrderedProduct(user);
        List<OrderHistory> userOrders = new ArrayList<>();

        for (OrderProduct order : orders) {
            for (OrderedProducts op : order.getOrderedProducts()) {
                Product product = op.getProduct();
                if (product != null) {
                    userOrders.add(new OrderHistory(
                            product.getCategory(),
                            product.getDescription(),
                            user,
                            product.getUser() != null ? product.getUser().getId() : null,
                            1,
                            product.getImageName(),
                            product.getName(),
                            product.getId() // ensure productId is set
                    ));
                }
            }
        }
        return userOrders;
    }

    public List<Product> recommendForUser(String username, List<Product> allProducts, int topN, boolean useLogReg){
        List<OrderHistory> userOrders = getUserOrderHistories(username);
        ModelType modelType = useLogReg ? ModelType.LOGISTIC_REGRESSION : ModelType.NAIVE_BAYES;
        return recommendationProcess.recommendProducts(userOrders, allProducts, modelType, topN);
    }

    public boolean hasOrders(String username) {
        return !getUserOrderHistories(username).isEmpty();
    }

    public List<RecommendedProductDTO> recommendForUserDetailed(String username, List<Product> allProducts, int topN, boolean useLogReg) {
        List<OrderHistory> userOrders = getUserOrderHistories(username);
        ModelType modelType = useLogReg ? ModelType.LOGISTIC_REGRESSION : ModelType.NAIVE_BAYES;
        return recommendationProcess.recommendProductsWithScores(userOrders, allProducts, modelType, topN);
    }

    // NEW: one-pass method that returns both lists
    public RecommendationProcess.BothModelResult recommendBothForUserDetailed(String username, List<Product> allProducts, int topN) {
        List<OrderHistory> userOrders = getUserOrderHistories(username);
        return recommendationProcess.recommendBothWithScores(userOrders, allProducts, topN);
    }
}