package com.asiya.projectbazar.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.web.SecurityFilterChain;

import com.asiya.projectbazar.dao.UserDao;

@Configuration

public class WebSecuriyConfig {
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private UserDao userDao;
	
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
		http
//        .authorizeHttpRequests(authorize -> authorize
//                .requestMatchers("/", "/login", "/oauth2/**", "/css/**", "/js/**").permitAll()
//                .requestMatchers("/admin/**").hasRole("ADMIN")
//                .requestMatchers("/user/**").hasRole("USER")
//                .anyRequest().authenticated()
//            )
//		
//		
//        .oauth2Login(oauth2 -> oauth2
//        		.loginPage("/login")
//        		.defaultSuccessUrl("/welcome", true)
//        		)
        
		.authorizeHttpRequests(authorize->authorize
				.requestMatchers("/admin/**").hasRole("ADMIN")
				.requestMatchers("/user/**").hasRole("USER"))
		.authorizeHttpRequests(authorize->authorize
				.requestMatchers("/**")
				.permitAll()
				.anyRequest()
				.authenticated())
        
		.formLogin(login->login
				.loginPage("/login")
				.loginProcessingUrl("/login")
				.usernameParameter("username")
				.passwordParameter("password")
				.defaultSuccessUrl("/welcome",true)
			    .failureUrl("/login?error=true")
				.permitAll())
		
		.logout(logout->logout
				.logoutUrl("/logout")
				.logoutSuccessUrl("/login")
				.permitAll()
				.invalidateHttpSession(true));
		http.csrf().disable();
		return http.build();
		
		}
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{
		auth.jdbcAuthentication()
		.passwordEncoder(passwordEncoder)
		.dataSource(dataSource)
		 .usersByUsernameQuery("SELECT username, password, enable FROM user WHERE username = ?")
	        .authoritiesByUsernameQuery(
	            "SELECT u.username, r.role " +
	            "FROM user AS u " +
	            "JOIN user_role AS r ON u.user_id = r.user_id " +
	            "WHERE u.username = ?"
	        );

	}
	
	//for the oauthservice
//	@Override
//	public class CustomOAuth2UserService extends DefaultOAuth2UserService{
//		
//	}

}
