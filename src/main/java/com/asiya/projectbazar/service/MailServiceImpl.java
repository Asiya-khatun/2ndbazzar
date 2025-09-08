package com.asiya.projectbazar.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService{

	@Autowired
	private JavaMailSender javaMailSender;
	
	@Override
	public void sendMail(String To, String Subject, String message) {
		SimpleMailMessage smm=new SimpleMailMessage();
		smm.setTo(To);
		smm.setSubject(Subject);
		smm.setText(message);
		javaMailSender.send(smm);
	}

}
