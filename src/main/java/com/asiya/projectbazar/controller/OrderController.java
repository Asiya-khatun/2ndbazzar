package com.asiya.projectbazar.controller;

// FIX: use the standard security principal (remove the wrong actuate import)
// import org.springframework.boot.actuate.web.exchanges.HttpExchange.Principal;
import java.security.Principal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asiya.projectbazar.algorithms.OrderHistoryService; // NEW: import the algorithms history service
import com.asiya.projectbazar.algorithms.RecommendationService;
import com.asiya.projectbazar.dto.RecommendedProductDTO;
import com.asiya.projectbazar.entity.Cart;
import com.asiya.projectbazar.entity.OrderProduct;
import com.asiya.projectbazar.entity.OrderedProducts;
import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.service.CartService;
import com.asiya.projectbazar.service.MailService;
import com.asiya.projectbazar.service.OrderService;
import com.asiya.projectbazar.service.ProductService;
import com.asiya.projectbazar.service.UserService;

@Controller
public class OrderController {
	@Autowired
	private UserService userService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private CartService cartService;

	@Autowired
	private ProductService productService;

	@Autowired
	private MailService mailService;
	

	@Autowired
	private OrderHistoryService orderHistoryService;
	
	@Autowired
	private RecommendationService recommendationService;

	@GetMapping("/user/payment/success/{agent}")
	public String order(@PathVariable String agent, Principal p, Model m, RedirectAttributes redirectAttributes) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication == null || !authentication.isAuthenticated()) {
			return "redirect:/login";
		}

		User user = userService.getUserByUsername(authentication.getName());
		if (user == null) {
			return "redirect:/login";
		}

		System.out.println("Agent: " + agent);
		List<Cart> carts = cartService.getCartByUser(user);
		if (carts == null || carts.isEmpty()) {
			System.out.println("Empty cart");
			return "redirect:/user/cart/show" + user.getId();
		}

		OrderProduct order = new OrderProduct();
		order.setUser(user);
		List<OrderedProducts> orderList = new ArrayList<>();
		double totalAmount = 0;

		for (Cart cart : carts) {
			Product product = cart.getProduct();
			totalAmount += product.getPrice() * cart.getQuantity();

			OrderedProducts orp = new OrderedProducts();
			orp.setProduct(product);
			orp.setQuantity(cart.getQuantity());
			orp.setOrderProduct(order);

			// Update product quantity
			int updatedQuantity = product.getQuantity() - cart.getQuantity();
			product.setQuantity(updatedQuantity);
			productService.updateProduct(product);

			// Notify seller if product goes out of stock
			if (updatedQuantity <= 0) {
				User owner = product.getUser();
				if (owner != null && owner.getEmail() != null) {
					String subject = "Product Out of Stock Notification";
					String message = "Hello " + owner.getName() + ",\n\n" + "Your product \"" + product.getName()
							+ "\" is now out of stock.\n"
							+ "Please update the stock if you'd like to keep selling it.\n" + "Regards,\nAgrobid Team";
					try {
						mailService.sendMail(owner.getEmail(), subject, message);
					} catch (Exception e) {
						System.out.println("Failed to send out-of-stock email: " + e.getMessage());
					}
				}
			}

			orderList.add(orp);
			cartService.deleteCart(cart); // remove from cart after ordering
		}

		order.setOrderedProducts(orderList);
		order.setTotal_amount(totalAmount - 100);
		order.setDiscount(100);
		order.setOrder_date(LocalDate.now());
		order.setDelivery_date(LocalDate.now().plusDays(7));
		order.setPayment_method(agent);
		order.setStatus("Pending");

		OrderProduct orpr = orderService.saveOrder(order);

		if (orpr != null) {
			try {
				for (OrderedProducts op : orpr.getOrderedProducts()) {
					Product product = op.getProduct();
					User owner = product.getUser(); // product owner

					// NEW: Record this purchase in the recommender history
					// This enables category/description and same-seller based recommendations.
					orderHistoryService.recordOrder(user, product);

					if (owner != null && owner.getEmail() != null) {
						String subject = "Your product has been ordered!";
						String message = "Hello " + owner.getName() + ",\n\n"
								+ "One of your products has been ordered:\n" + "Product Name: " + product.getName()
								+ "\n" + "Quantity Ordered: " + op.getQuantity() + "\n" + "Buyer: " + user.getName()
								+ "\n" + "Buyer: " + user.getEmail() + "\n\n"
								+ "Please prepare the product for delivery.\n\n" + "Regards,\nAgrobid Team";

						mailService.sendMail(owner.getEmail(), subject, message);
					}
				}

				redirectAttributes.addFlashAttribute("orderSuccess",
						"Product Ordered Successfully. Notification sent to sellers.");
			} catch (Exception e) {
				System.out.println("Error sending email to seller: " + e.getMessage());
				redirectAttributes.addFlashAttribute("orderSuccess", "Product Ordered, but failed to notify sellers.");
			}

			return "redirect:/myorders";

		} else {
			System.out.println("Error while ordering the products");
			return "redirect:/user/cart/show" + user.getId();
		}
	}

	// show the product which the logged in user has ordered
//	@GetMapping("/myorders")
//	public String myorders(java.security.Principal p, Model m) {
//		User user = userService.getUserByUsername(p.getName());
//		m.addAttribute("user", user);
//
//		List<OrderProduct> ordersList = orderService.getOrderbyUser(user);
//		m.addAttribute("orders", ordersList);
//
//		return "user/MyOrders";
//	}
	@GetMapping("/myorders")
	public String myorders(Principal p, Model m) {
	    if (p == null) {
	        return "redirect:/login";
	    }
	    String username = p.getName();

	    User user = userService.getUserByUsername(username);
	    m.addAttribute("user", user);

	    List<OrderProduct> ordersList = orderService.getOrderbyUser(user);
	    m.addAttribute("orders", ordersList);

	    // Build recommendations similar to userHome
	    List<Product> allProducts = productService.getAllProducts()
	            .stream()
	            .filter(prod -> prod.getQuantity() > 0)
	            .collect(Collectors.toList());
	    int topN = 10;

	    if (recommendationService.hasOrders(username)) {
	        List<RecommendedProductDTO> naive =
	                recommendationService.recommendForUserDetailed(username, allProducts, topN, false);
	        List<RecommendedProductDTO> logistic =
	                recommendationService.recommendForUserDetailed(username, allProducts, topN, true);

	        m.addAttribute("naive", naive);
	        m.addAttribute("logistic", logistic);

	        if ((naive == null || naive.isEmpty()) && (logistic == null || logistic.isEmpty())) {
	            m.addAttribute("noOrdersMessage", "No matching recommendations found yet.");
	        }
	    } else {
	        m.addAttribute("noOrdersMessage", "No recommendations yet. Place some orders to get personalized suggestions.");
	    }

	    return "user/MyOrders";
	}

	
	
	
	
	
	@GetMapping("/otherOrders")
	public String getOrdersByOwner(java.security.Principal p, Model model, RedirectAttributes redirectAttributes) {
		User user = userService.getUserByUsername(p.getName());
		List<OrderedProducts> orders = orderService.getMyOrdersByUser(user);
		model.addAttribute("user", user);
		model.addAttribute("orders", orders);
		redirectAttributes.addFlashAttribute("newOrder", "New order has been placed");
		return "user/OtherOrders";
	}
	
//	@PostMapping("/deleteOrder/{id}")
//	public String deleteOrder(@PathVariable("id") int orderId, Principal p) {
//	    User user = userService.getUserByUsername(p.getName());
//	    OrderProduct order = orderService.getOrderById(orderId);
//
//	    if (order == null) {
//	        return "redirect:/user/cart/show/" + user.getId();
//	    }
//
//	    if (order.getUser().getId() == user.getId()) {
//	        for (OrderedProducts orderedProduct : order.getOrderedProducts()) {
//	            Product product = orderedProduct.getProduct();
//	            User productOwner = product.getUser();
//
//	            String subject = "Order Cancellation Notification";
//	            String message = String.format(
//	                "Dear %s,\n\nThe order for your product '%s' placed by %s has been cancelled."
//	                + "\n\nRegards,\nSecond Hand Bazar Team",
//	                productOwner.getName(),
//	                product.getName(),
//	                user.getName()
//	            );
//
//	            mailService.sendMail(productOwner.getEmail(), subject, message);
//	        }
//	        orderService.deleteOrder(order);
//	    }
//
//	    return "redirect:/user/cart/show/" + user.getId();
//	}


	
}
