package com.asiya.projectbazar.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.web.exchanges.HttpExchange.Principal;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asiya.projectbazar.entity.Cart;
import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.enums.CategoryEnum;
import com.asiya.projectbazar.service.CartService;
import com.asiya.projectbazar.service.FUploadService;
import com.asiya.projectbazar.service.OrderService;
import com.asiya.projectbazar.service.ProductService;
import com.asiya.projectbazar.service.UserService;
import com.asiya.projectbazar.validation.ProductValidator;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/user/product")
public class ProductController {
	

	@Autowired
	private FUploadService fuploadService;

	@Autowired
	private ProductService productService;

	@Autowired
	private UserService userService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private CartService cartService;
@Autowired
private ProductValidator productValidator;

	@GetMapping("/add")
	public String showAddProductPage(Principal principal, Model model) {
		// Ensure the user is authenticated
		String username = principal.getName(); //
		model.addAttribute("cat_list", CategoryEnum.values());
		model.addAttribute("user", username);
		model.addAttribute("product", new Product()); //
		return "product/AddProduct"; //
	}
	
@InitBinder("product")
protected void initBinder(WebDataBinder binder) {
	binder.addValidators(productValidator);
}
	
@PreAuthorize("hasRole('ROLE_USER')")
@PostMapping("/add")
public ModelAndView saveProduct(@Valid @ModelAttribute Product product,
                                BindingResult result,
                                RedirectAttributes redirectAttributes) {

    if (result.hasErrors()) {
        ModelAndView mav = new ModelAndView("product/AddProduct");
        mav.addObject("valid_errors", result.getAllErrors());
        return mav;
    }

    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    String username = authentication.getName();
    User user = userService.getUserByUsername(username);

    if (user == null) {
        return new ModelAndView("redirect:/user/product/add");
    }

    product.setUser(user);

    if (product.getImageFile() != null && !product.getImageFile().isEmpty()) {
        boolean isImageUploaded = fuploadService.uploadProductImage(product.getImageFile());
        if (isImageUploaded) {
            product.setImageName(product.getImageFile().getOriginalFilename());
        } else {
            System.out.println("Error uploading product image for: " + product);
        }
    }

    product.setAddedDate(LocalDate.now());
    productService.addProduct(product);
    redirectAttributes.addFlashAttribute("success", "Product Added");

    return new ModelAndView("redirect:/user/product/view/" + user.getId());
}


	
//for the product editing
	@GetMapping("/edit/{product_id}")
	public String editProduct( @PathVariable("product_id") int id, Model model, Principal p) {
		User user = userService.getUserByEmail(p.getName());
		model.addAttribute("user", user);
		Product product = productService.getProductById(id);
		model.addAttribute("edit", true);
//	model.addAttribute("product",product);
		model.addAttribute("product_list", productService.getAllProducts());
		model.addAttribute("edit_product", productService.getProductById(id));
		model.addAttribute("cat_list", CategoryEnum.values());
		return "product/AddProduct";
	}
	
	//updating the product
	@PostMapping("/update/{id}")
	public String updateProduct(
	        @PathVariable("id") int id,
	        @ModelAttribute Product product,
	        @RequestParam(value = "prevImage", required = false) String prevImage,
	        @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
	        Principal principal,
	        Model model) {

	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || !authentication.isAuthenticated()) {
	        return "redirect:/login";
	    }

	    String username = authentication.getName();
	    User user = userService.getUserByUsername(username);

	    Product existingProduct = productService.getProductById(id);
	    if (existingProduct == null || !existingProduct.getUser().equals(user)) {
	        model.addAttribute("error", "You are not authorized to update this product.");
	        return "error/403";
	    }
	    existingProduct.setName(product.getName());
	    existingProduct.setDescription(product.getDescription());
	    existingProduct.setPrice(product.getPrice());
	    existingProduct.setQuantity(product.getQuantity());
	    existingProduct.setCategory(product.getCategory());
	    existingProduct.setAddedDate((LocalDate.now()));   
	    if (imageFile != null && !imageFile.isEmpty()) {
	        String imageName =  imageFile.getOriginalFilename();
	        boolean uploaded = fuploadService.uploadProductImage(imageFile);
	        if (uploaded) {
	            existingProduct.setImageName(imageName);
	        } else {
	            model.addAttribute("error", "Image upload failed.");
	            return "user/update_form"; 
	        }
	    } else {
	        existingProduct.setImageName(prevImage);
	    }

	    productService.updateProduct(existingProduct);

	    return "redirect:/user/product/view/" + user.getId();
	}

	

//listing the logged in user products or owner products
	@GetMapping("/view/{id}")
	public String showProduct(@PathVariable int id, Model m, Principal principal) {
User user = userService.getUserById(id);
 
		m.addAttribute("user", user);
		
		List<Product> products = productService.getProductByUserId(user.getId());
		m.addAttribute("products", products);
		 boolean noProduct = products.isEmpty();
		    m.addAttribute("noProduct", noProduct);
		return "product/MyProducts";
		
	}

	@PostMapping("/delete/{id}")
	public String deleteProduct(@PathVariable int id, RedirectAttributes redirectAttributes) {
	    System.out.println("Delete request received for product id: " + id);
	    Product pro = productService.getProductById(id);
	    if (pro != null) {
	        productService.deleteProduct(pro);
	        redirectAttributes.addFlashAttribute("deleteSuccess", "Deleted Successfully");
	        return "redirect:/user/product/view/" + pro.getUser().getId();
	    } else {
	        redirectAttributes.addFlashAttribute("errordelete", "Error deleting products");
	        return "redirect:/user/product/view";
	    }
	}

	//listing the other users products
	@GetMapping("/allproducts/{id}")
	public String getProducts(@PathVariable int id, Model m, Principal p) {
	    User user = userService.getUserById(id);
	    m.addAttribute("user", user);
	    System.out.println(user.getId() + " , " + user.getName());

	    List<Product> products = productService.getAllProductExceptLoggedInUser(id);
	    List<Cart> cartItems = cartService.getCartByUser(user);

	    for (Product product : products) {
	        int totalCartQuantity = 0;

	        for (Cart cart : cartItems) {
	            if (cart.getProduct().getId() == product.getId()) {
	                totalCartQuantity += cart.getQuantity();
	            }
	        }
	        if (product.getQuantity() <= totalCartQuantity) {
	            product.setQuantity(0); // Set quantity to 0 (out of stock)
	            System.out.println("Product with ID " + product.getId() + " is now out of stock.");
	        } else {
	            product.setQuantity(product.getQuantity() - totalCartQuantity);
	        }
	    }
	    
	    m.addAttribute("categories", CategoryEnum.values()); 

	    m.addAttribute("products", products);
	    m.addAttribute("cartItems", cartItems);

	    return "user/AllProducts"; 
	}
	
	
	  @GetMapping("/filters/{id}")
	  public String getAllProducts(Model model,@PathVariable int id) {
	      User user = userService.getUserById(id); 
	      model.addAttribute("user", user);        

		    model.addAttribute("categories", CategoryEnum.values());  
		    return "user/AllProducts";
		}

	  @PostMapping("/filter/{id}")
	  public String filterByCategory(@RequestParam("categoryEnum") Optional<CategoryEnum> categoryEnum,
	                                 Model model,
	                                 Principal p,
	                                 @PathVariable int id) {

	      User user = userService.getUserById(id); 
	      model.addAttribute("user", user);        

	      model.addAttribute("categories", CategoryEnum.values());

	      List<Product> products;

	      if (categoryEnum.isPresent()) {
	          products = productService.getByCategories(categoryEnum.get(), id);
	      } else {
	          products = productService.getAllProductExceptLoggedInUser(id);
	      }

	      model.addAttribute("products", products);

	      if (products.isEmpty()) {
	          model.addAttribute("message", "No products found for selected category.");
	      }

	      return "user/AllProducts";
	  }

@GetMapping("/details/{id}")
public String productDetails(@PathVariable int id,Model m) {
	Product product=productService.getProductById(id);
	m.addAttribute("product",product);
	return"product/productDetails";
}

}
