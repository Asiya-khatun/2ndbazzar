package com.asiya.projectbazar.service;

import java.security.Identity;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asiya.projectbazar.algorithms.OrderHistory;
import com.asiya.projectbazar.dao.OrderDao;
import com.asiya.projectbazar.dao.OrderedProductDao;
import com.asiya.projectbazar.dao.ProductDao;
import com.asiya.projectbazar.entity.OrderProduct;
import com.asiya.projectbazar.entity.OrderedProducts;
import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.entity.User;
import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private ProductService productService;
	@Autowired
	private OrderedProductDao orderedProductDao;
	

	@Override
	public OrderProduct saveOrder(OrderProduct orderProduct) {
		// TODO Auto-generated method stub
		OrderProduct op=orderDao.save(orderProduct);
		return op;
	}

	@Override
	public List<OrderProduct> getAllOrders() {
		// TODO Auto-generated method stub
		return orderDao.findAll();
	}

	@Override
	public OrderProduct getOrderById(int id) {
		// TODO Auto-generated method stub
		return orderDao.findById(id).get(id);
	}

	@Override
	public List<OrderProduct> getOrderbyUser(User user) {
		// TODO Auto-generated method stub
		return orderDao.findByUser(user);
	}

	@Override
	public void updateOrder(OrderProduct orderProduct) {
		// TODO Auto-generated method stub
		orderDao.save(orderProduct);
	}

	@Override
	public void deleteOrder(OrderProduct orderProduct) {
		// TODO Auto-generated method stub
		orderDao.delete(orderProduct);
	}



	@Override
	public List<OrderProduct> getOrderedProduct(User user) {
		
	     return orderDao.findByUser(user);
	}

	@Override
	public List<OrderedProducts> getMyOrdersByUser(User productOwner) {
		// TODO Auto-generated method stub
		return orderedProductDao.findOrdersByProductOwner(productOwner);
	}

	@Override
	public List<OrderHistory> getUserOrderProducts(User user) {
	    // Fetch all orders for the given user
	    List<OrderProduct> orders = orderDao.findByUser(user);

	 // Java
	 // Convert each OrderedProduct into an OrderHistory
	 List<OrderHistory> userOrders = new ArrayList<>();
	 for (OrderProduct order : orders) {
	     if (order.getOrderedProducts() == null) continue;
	     for (OrderedProducts op : order.getOrderedProducts()) {
	         Product product = op.getProduct();
	         if (product != null) {
	             userOrders.add(new OrderHistory(
	                 product.getCategory(),
	                 product.getDescription(),
	                 user, // buyer
	                 product.getUser() != null ? product.getUser().getId() : null, // seller
	                 1, // label for training
	                 product.getImageName(),
	                 product.getName(),
	                 product.getId() // NEW: ensure purchased product id is recorded
	             ));
	         }
	     }
	 }

	    return userOrders;
	}

	

	
	

	


}
