package com.vrv.mapper;

import com.vrv.entity.Login;

public interface LoginDao extends BaseDao<Login>{

	 public Login findLogin(String usename);
}
