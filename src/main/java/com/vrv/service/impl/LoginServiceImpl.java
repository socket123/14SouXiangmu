package com.vrv.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vrv.entity.Login;
import com.vrv.mapper.LoginDao;
import com.vrv.service.BaseService;


@Transactional
@Service("loginService")
public class LoginServiceImpl extends BaseService<Login>{

	@Autowired
	LoginDao loginDao;
	
	public Login findLogin(String username) {
		return loginDao.findLogin(username);
	}
	

	
	
}
