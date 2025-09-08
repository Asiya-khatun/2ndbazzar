package com.asiya.projectbazar.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.entity.UserRole;

public interface UserService {
	public void saveUser(User user);
	public User getUserById(int id);
	public User getUserByUsername(String username);
	public User getUserByEmail(String email);
	public void updateUser(User user);
    public User updateUserProfile(User user);
	public void deleteUser(User user);
	List<User> getAllUser();
	public void changePassword(String Username, String password, String NewPassoword);
	public List<User> getByUserRole(String role);


}
