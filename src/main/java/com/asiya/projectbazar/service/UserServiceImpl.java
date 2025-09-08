package com.asiya.projectbazar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import com.asiya.projectbazar.dao.UserDao;
import com.asiya.projectbazar.entity.User;
import com.asiya.projectbazar.entity.UserRole;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void saveUser(User user) {
        userDao.save(user);
    }

  

    @Override
    public User getUserByUsername(String username) {
       return userDao.findByUsername(username);
    }

    @Override
    public void deleteUser(User user) {
        userDao.delete(user);;
    }

    @Override
    public List<User> getAllUser() {
        return userDao.findAll();
    }


    @Override
    public void updateUser(User user) {
        userDao.save(user);
    }

	

	@Override
	public User getUserByEmail(String email) {
		// TODO Auto-generated method stub
		return userDao.findByEmail(email);
	}



	@Override
	public User getUserById(int id) {
		return userDao.findById(id);
	}



	@Override
	public User updateUserProfile(User user) {
		User userd= userDao.findById(user.getId());
//		
		if(!ObjectUtils.isEmpty(userd))
		{
			userd.setName(user.getName());
			userd.setAddress(user.getAddress());
			userd.setDob(user.getDob());
			userd.setPhone(user.getPhone());
			userd.setUsername(user.getUsername());
			userd.setEmail(user.getEmail());
			userd=userDao.save(userd);
		}
		return userd;		
	}



	@Override
	public void changePassword(String Username, String password, String NewPassoword)
	{ 
		// TODO Auto-generated method stub
		User user=userDao.findByUsername(Username);
		if(!passwordEncoder.matches(password,user.getPassword()));
		
		user.setPassword(passwordEncoder.encode(NewPassoword));
		
		
		userDao.save(user);
		
	}



	@Override
	public List<User> getByUserRole(String role) {
		// TODO Auto-generated method stub
		return userDao.findByUserRole_role(role);
	}




	



}
