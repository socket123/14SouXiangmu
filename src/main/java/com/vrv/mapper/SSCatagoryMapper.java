package com.vrv.mapper;

import java.util.List;

import com.vrv.entity.SSCatagory;

public interface SSCatagoryMapper extends BaseDao<SSCatagory> {
	public List<SSCatagory> findCatagoryList(Integer type);

	public List<SSCatagory> findTeamList(Integer type);

}