// Java
package com.asiya.projectbazar.algorithms;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.enums.CategoryEnum;

@Service
public class OrderHistoryService {

    private final List<OrderHistory> orderHistories = new ArrayList<>();

    public void recordOrder(User buyer, Product product) {
        if (buyer == null || product == null) return;
        CategoryEnum category = product.getCategory();
        String description = product.getDescription();
        String productName = product.getName();
        String imageString = product.getImageName();
        Integer sellerId = (product.getUser() != null ? product.getUser().getId() : null);

        orderHistories.add(new OrderHistory(
                category,
                description,
                buyer,
                sellerId,
                1, // label
                imageString,
                productName,
                product.getId() // NEW: store purchased product id
        ));
    }

    public List<OrderHistory> getOrdersByUser(String ownerUsername) {
        List<OrderHistory> userOrder = new ArrayList<>();
        if (ownerUsername == null) return userOrder;

        for (OrderHistory history : orderHistories) {
            if (history == null || history.getOwner() == null) continue;
            String u1 = history.getOwner().getUsername();
            String u2 = history.getOwner().getName();
            if ((u1 != null && u1.equalsIgnoreCase(ownerUsername))
                    || (u2 != null && u2.equalsIgnoreCase(ownerUsername))) {
                userOrder.add(history);
            }
        }
        return userOrder;
    }

    public int size() {
        return orderHistories.size();
    }
}