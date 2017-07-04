package com.vrv.service.impl;

import com.vrv.entity.CarryoutDept;
import com.vrv.mapper.CarryoutDeptMapper;
import com.vrv.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by LXX on 2017-05-12.
 */
@Service
public class CarryoutDeptService extends BaseService<CarryoutDept> {
    @Autowired
    CarryoutDeptMapper carryoutDeptMapper;

    public List<CarryoutDept> loadAll(Map<String, Object> maps){return carryoutDeptMapper.loadAll(maps);}

    public int countCarryoutDeptByName(String deptName){return carryoutDeptMapper.countCarryoutDeptByName(deptName);}

}
