package com.vrv.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.entity.SSCatagory;
import com.vrv.mapper.SSCatagoryMapper;
import com.vrv.service.BaseService;

@Service
public class SSCatagoryService extends BaseService<SSCatagory> {
	@Autowired
	SSCatagoryMapper ssCatagoryMapper;

	public List<SSCatagory> findCatagoryList(Integer type) {
		return ssCatagoryMapper.findCatagoryList(type);
	}

	public List<SSCatagory> findTeamList(Integer type) {
		return ssCatagoryMapper.findTeamList(type);
	}

}
