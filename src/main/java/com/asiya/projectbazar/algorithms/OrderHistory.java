package com.asiya.projectbazar.algorithms;

import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.enums.CategoryEnum;

public class OrderHistory {
	private final CategoryEnum category; // category of the ordered product
	private final String description; // description/name text of the ordered product
	private final User owner; // buyer (logged-in user)
	private final Integer sellerId; // seller (owner of the ordered product)
	private final String imageString;
	private final int label;;// optional training label
	private final String productName;
	private final Integer productId;

	public OrderHistory(CategoryEnum category, String description, User owner, Integer sellerId, int label,
			String imageString, String productName, Integer productId) {
		this.category = category;
		this.description = description;
		this.owner = owner;
		this.sellerId = sellerId;
		this.label = label;
		this.imageString = imageString;
		this.productName = productName;
		this.productId = productId;
	}

	public CategoryEnum getCategory() {
		return category;
	}

	public String getDescription() {
		return description;
	}

	public User getOwner() {
		return owner;
	}

	public Integer getSellerId() {
		return sellerId;
	}

	public int getLabel() {
		return label;
	}

	public String getimageString() {
		return imageString;
	}

	public String getproductName() {
		return productName;
	}

	public Integer getProductId() {
		return productId;
	}
}
