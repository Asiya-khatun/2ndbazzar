package com.asiya.projectbazar.dto;

import com.asiya.projectbazar.entity.Product;

public class RecommendedProductDTO {
    private final Integer productId;
    private final String productName;
    private final String ownerName;
    private final String category;
    private final String description;
    private final double score;
    private String imageName;

    public RecommendedProductDTO(Integer productId, String ownerName, String category, String description, double score,String imageName,String productName) {
        this.productId = productId;
        this.ownerName = ownerName;
        this.category = category;
        this.description = description;
        this.score = score;
        this.imageName=imageName;
        this.productName=productName;
    }

    public Integer getProductId() { return productId; }
    public String getOwnerName() { return ownerName; }
    public String getCategory() { return category; }
    public String getDescription() { return description; }
    public String getimageName() {return imageName;}
    public double getScore() { return score; }
    public String getproductName() { return productName; }


    public static RecommendedProductDTO fromProduct(Product p, double score) {
        Integer id = p.getId();
        String productName=p.getName();
        String owner = (p.getUser() != null) ? p.getUser().getName() : "";
        String cat = (p.getCategory() != null) ? p.getCategory().name() : "";
        String desc = p.getDescription();
        String img = (p.getImageName() != null) ? p.getImageName() : "placeholder.png";  // fallback image
        return new RecommendedProductDTO(id, owner, cat, desc, score,img,productName);
        }
}
