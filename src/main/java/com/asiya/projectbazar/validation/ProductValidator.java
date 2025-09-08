package com.asiya.projectbazar.validation;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.asiya.projectbazar.entity.Product;

@Component
public class ProductValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return Product.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Product product = (Product) target;

        // Product Name Validation
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            errors.rejectValue("name", "product.empty", "Product name should not be empty");
        } else {
            String name = product.getName().trim();
            if (name.length() < 4 || name.length() > 50) {
                errors.rejectValue("name", "name.length", "Product name length must be between 4 and 50 characters.");
            }
                }

        // Product Description Validation
        if (product.getDescription() == null || product.getDescription().trim().isEmpty()) {
            errors.rejectValue("description", "description.empty", "Product description should not be empty.");
        } else {
            String desc = product.getDescription().trim();
            if (desc.length() < 4 || desc.length() > 50) {
                errors.rejectValue("description", "description.length",
                        "Product description should be between 4 and 50 characters.");
            }
        }

        // Price Validation
        if (product.getPrice() < 0) {
            errors.rejectValue("price", "price.negative", "Price cannot be negative.");
        } else if (product.getPrice() < 100 || product.getPrice() > 100000) {
            errors.rejectValue("price", "price.range", "Price must be between 100 and 100000.");
        }

        // Quantity Validation
        if (product.getQuantity() < 0) {
            errors.rejectValue("quantity", "quantity.negative", "Quantity cannot be negative.");
        } else if (product.getQuantity() < 2 || product.getQuantity() > 999) {
            errors.rejectValue("quantity", "quantity.range", "Quantity must be between 5 and 999.");
        }

        // Image Validation
        if (product.getImageFile() == null || product.getImageFile().isEmpty()) {
            errors.rejectValue("imageFile", "imageFile.empty", "Please upload a product image.");
        } else {
            String contentType = product.getImageFile().getContentType();
            long sizeInMB = product.getImageFile().getSize() / (1024 * 1024);

            if (!(contentType.equals("image/jpeg") || contentType.equals("image/png") || contentType.equals("image/webp"))) {
                errors.rejectValue("imageFile", "imageFile.invalidType", "Only JPG or PNG images are allowed.");
            }

            if (sizeInMB > 2) {
                errors.rejectValue("imageFile", "imageFile.sizeExceeded", "Image size must be less than 2MB.");
            }
        }
    }
}
