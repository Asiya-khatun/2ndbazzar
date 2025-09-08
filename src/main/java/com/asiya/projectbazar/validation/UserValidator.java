package com.asiya.projectbazar.validation;


import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.asiya.projectbazar.entity.User;


@Component
public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
User user=(User)target;	

if(user.getUsername()!=null && user.getUsername().trim().isEmpty()) {
	errors.rejectValue("username", "username.empty","Username must not be empty");
}else {
	String username=user.getUsername();
	if(username.length()<4 || username.length()>15) {
		errors.rejectValue("username", "username.length","Username must be between 4 to 15 characters long");
	}
	if(username.contains("")) {
		errors.rejectValue("username", "username.noSpaces","Username cannot be empty");
	}
	if(username.matches(".\\d.*")) {
		errors.rejectValue("username", "username.noIntegers","Username shouldnot contain numbers");
	}

}
if(user.getPhone()!=null || !user.getPhone().matches("[0-9]{10}")) {
	errors.rejectValue("phone","phone.invalid","Phone no should be valid and upto 10 digits");
}

//for the name validation
if(user.getName()!=null && user.getName().trim().isEmpty()) {
	errors.rejectValue("name", "name.empty","Username must not be empty");
}else {
	String name=user.getName();
	if(name.length()<4 || name.length()>15) {
		errors.rejectValue("name", "name.length","name must be between 4 to 15 characters long");
	}
	if(name.contains("")) {
		errors.rejectValue("name", "name.noSpaces","name cannot be empty");
	}
	if(name.matches(".\\d.*")) {
		errors.rejectValue("name", "name.noIntegers","name shouldnot contain numbers");
	}

}
//validation for address
if(user.getAddress()!=null) {
	errors.rejectValue("address", "address.empty","Adress should not be empty");
}

//user validation
//Validation for date of birth (assuming user.getDob() returns LocalDate)
LocalDate dob = user.getDob();
LocalDate today = LocalDate.now();

if (dob == null) {
 errors.rejectValue("dob", "dob.null", "Date of birth is required");
} else if (!dob.isBefore(today)) {
 // DOB is today or in the future
 errors.rejectValue("dob", "dob.future", "Date of birth cannot be today or in the future");
} else if (!dob.isBefore(today.minusYears(18))) {
 // Age <= 18
 errors.rejectValue("dob", "dob.age", "Age must be more than 18");
}


//Validation for email
if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
    errors.rejectValue("email", "email.empty", "Email is required");
} else {
    String email = user.getEmail();
    // Basic email format check
    if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
        errors.rejectValue("email", "email.invalid", "Enter a valid email address");
    }
}

//Validation for password
if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
    errors.rejectValue("password", "password.empty", "Password is required");
} else {
    String password = user.getPassword();

    if (password.length() < 8) {
        errors.rejectValue("password", "password.length", "Password must be at least 8 characters long");
    }

    if (!password.matches(".*[A-Z].*")) {
        errors.rejectValue("password", "password.uppercase", "Password must contain at least one uppercase letter");
    }

    if (!password.matches(".*[a-z].*")) {
        errors.rejectValue("password", "password.lowercase", "Password must contain at least one lowercase letter");
    }

    if (!password.matches(".*\\d.*")) {
        errors.rejectValue("password", "password.digit", "Password must contain at least one digit");
    }

    if (!password.matches(".*[!@#$%^&*()-+=].*")) {
        errors.rejectValue("password", "password.special", "Password must contain at least one special character");
    }
}

	}
}
