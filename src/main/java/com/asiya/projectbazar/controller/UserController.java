package com.asiya.projectbazar.controller;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asiya.projectbazar.algorithms.RecommendationService;
import com.asiya.projectbazar.dto.RecommendedProductDTO;
import com.asiya.projectbazar.entity.Product;
import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.entity.UserRole;
import com.asiya.projectbazar.service.ProductService;
import com.asiya.projectbazar.service.UserService;
import com.asiya.projectbazar.validation.UserValidator;

@Controller
public class UserController {
    @Autowired private UserService userService;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private ProductService productService;
    @Autowired private UserValidator userValidator;
    @Autowired private RecommendationService recommendationService;

    @GetMapping("/login")
    public String showLogin() {
        return "user/userlogin";
    }

    @GetMapping("/register")
    public String register(Model m) {
        m.addAttribute("user", new User());
        return "user/register";
    }

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.addValidators(userValidator);
    }

    @PostMapping("/register")
    public ModelAndView registerUser(@ModelAttribute User user, BindingResult result, Model m, Principal p) {
        if (result.hasErrors()) {
            ModelAndView modelAndView = new ModelAndView("user/register");
            modelAndView.addObject("valid_errors", result.getAllErrors());
            return modelAndView;
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        UserRole userRole = new UserRole();
        userRole.setRole("ROLE_USER");
        user.setEnable("1");
        userRole.setUser(user);
        user.setUserRole(userRole);
        userService.saveUser(user);
        return new ModelAndView("redirect:/login");
    }

    // Unified: render recommendations from both models
    @GetMapping("/user/home")
    public String userHome(Model m, Principal p) {
        if (p == null) {
            return "redirect:/login";
        }
        String username = p.getName();

        // Add logged-in user to model (used by JSP)
        User user = userService.getUserByUsername(username);
        m.addAttribute("user", user);

        // Load candidate products
        
        List<Product> allProducts = productService.getAllProducts()
                .stream()
                .filter(prod -> prod.getQuantity() > 0) // filter out out-of-stock items
                .collect(Collectors.toList()); 
        int topN = 10;
        
        m.addAttribute("product",allProducts);

        if (recommendationService.hasOrders(username)) {
            // Naive Bayes
            List<RecommendedProductDTO> naive =
                recommendationService.recommendForUserDetailed(username, allProducts, topN, false);
            // Logistic Regression
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

        return "user/home";
    }

    @GetMapping("/welcome")
    public String welcome(Principal p, Model model) {
        if (p == null) {
            return "redirect:/login";
        }
        User user = userService.getUserByUsername(p.getName());
        if (user == null) {
            return "error";
        }
        if (user.getUserRole().getRole().contains("ROLE_ADMIN")) {
            return "redirect:/admin/home";
        } else if (user.getUserRole().getRole().contains("ROLE_USER")) {
            return "redirect:/user/home";
        }
        return "dashboard";
    }

    @GetMapping("user/edit")
    public String editProfile(Principal p, Model model) {
        User user = userService.getUserByUsername(p.getName());
        model.addAttribute("user", user);
        model.addAttribute("edit", true);
        return "user/profile";
    }

    @PostMapping("user/edit")
    public String saveupdateProfile(@ModelAttribute User user) {
        User uu = userService.getUserById(user.getId());
        userService.updateUserProfile(user);
        return "redirect:/user/edit";
    }

    @GetMapping("/updatePassoword")
    public String changePassword() {
        return "user/profile";
    }

    @PostMapping("/updatePassword/{id}")
    public String passowordChange(@RequestParam String password,
                                  @RequestParam String NewPassword,
                                  @RequestParam String ConfirmPassword,
                                  Principal p, Model m, RedirectAttributes redirectAttributes) {
        if (NewPassword == (password)) {
            m.addAttribute("error", "New password cannot be same as old");
            return " redirect:/user/edit";
        }
        if (!NewPassword.equals(ConfirmPassword)) {
            m.addAttribute("error", "New passoword doesnot match the new password");
            return " redirect:/user/edit";
        }
        userService.changePassword(p.getName(), password, NewPassword);
        m.addAttribute("message", "Password Updated Successfully");
        return "redirect:/user/home";
    }

    @PostMapping("/delete/{id}")
    public String deleteuser(@PathVariable int id, Principal p, Model m) {
        User user = userService.getUserById(id);
        if (user != null) {
            userService.deleteUser(user);
        }
        return "redirect:/login";
    }
}