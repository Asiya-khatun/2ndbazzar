package com.asiya.projectbazar.controller;


import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.web.exchanges.HttpExchange.Principal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.enums.CategoryEnum;
import com.asiya.projectbazar.service.ProductService;
import com.asiya.projectbazar.service.UserService;

@Controller
public class AdminController {
	@Autowired
	private final UserService userService;
	
	@Autowired
	private ProductService productService;
	
	public AdminController (UserService userService) {
		this.userService=userService;
	}
	
	@GetMapping("/admin/home")
	public String adminHome(Principal p, Model model) {
		model.addAttribute("user",p.getName());
		return"admin/index";
	}
	
	@GetMapping("/admin/user/show")
	public String user(Principal principal, Model model) {
		
	    List<User> users=userService.getByUserRole("ROLE_USER");

	    model.addAttribute("user_list", users);
	    return "admin/approval";
	}


	@GetMapping("admin/editProfile")
	public String adminProfile(Principal p, Model model) {
		User user=userService.getUserByUsername(p.getName());
		model.addAttribute("user",user);
		model.addAttribute("edit",true);
	    return "admin/profile";
	}
	

	@PostMapping("admin/editProfile")
	public String admin(@ModelAttribute User user) {
User uu=userService.getUserById(user.getId());
		
		userService.updateUserProfile(user);
		return"redirect:/admin/profile";
	}
	@PostMapping("/admin/updatePassword/{id}")
	public String passowordChange(@RequestParam String password,
									@RequestParam String NewPassword,
									@RequestParam String ConfirmPassword, 
									Principal p, Model m, RedirectAttributes redirectAttributes) {
		
		if(NewPassword==(password)) {
			m.addAttribute("error","New password cannot be same as old");
			return" redirect:/user/edit";
		}
		
		if(!NewPassword.equals(ConfirmPassword)) {
			m.addAttribute("error","New passoword doesnot match the new password");
			return" redirect:/user/edit";
		}
		userService.changePassword(p.getName(),password,NewPassword);
		m.addAttribute("message", "Password Updated Successfully");
        return "redirect:/user/home";	
		
	}
	
	@GetMapping("admin/allProducts")
	public String AllUserProducts(Model m) {
		List<Product> products=productService.getAllProducts();
		m.addAttribute("product",products);
		return"admin/products";
	}
	
//	@GetMapping("/admin/category-pie")
//	public String getByCategory(Model m) {
//	    List<Product> products = productService.getAllProducts();
//	    Map<CategoryEnum, Long> categoryCount = products.stream()
//	    	    .filter(p -> p.getCategory() != null && !p.getCategory().isEmpty())
//	    	    .collect(Collectors.groupingBy(
//	    	        Product::getCategory, // already a String, no getDisplayName()
//	    	        Collectors.counting()
//	    	    ));
//
//	   
//
//	    m.addAttribute("categoryCounts", categoryCount);
//	    return "admin/index";
//	}



}
