package com.asiya.projectbazar.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.entity.UserRole;

import java.util.List;


@Repository
public interface UserDao  extends JpaRepository<User,Integer>{
	public User findByUsername(String username);
	public User findByEmail(String email);
	public User findById(int id);
	public List<User> findByUserRole_role(String Role);


}
