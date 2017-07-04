package com.vrv.mapper;

import com.vrv.entity.CarryoutDept;

import java.util.List;
import java.util.Map;

public interface CarryoutDeptMapper extends BaseDao<CarryoutDept>  {
    public List<CarryoutDept> loadAll(Map<String, Object> maps);

    public int countCarryoutDeptByName(String deptName);

}