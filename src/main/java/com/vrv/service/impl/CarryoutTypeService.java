package com.vrv.service.impl;

import com.vrv.entity.CarryoutType;
import com.vrv.mapper.CarryoutTypeMapper;
import com.vrv.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by LXX on 2017-05-02.
 */
@Service
public class CarryoutTypeService extends BaseService<CarryoutType> {

    @Autowired
    CarryoutTypeMapper carryoutTpyeMapper;

    public List<CarryoutType> loadAll(Map<String, Object> maps){return carryoutTpyeMapper.loadAll(maps);}

    public List<CarryoutType> findCarryoutTypeByPid(Integer pid){return carryoutTpyeMapper.findCarryoutTypeByPid(pid);}

    public int countCarryoutTypeByName(String name){return carryoutTpyeMapper.countCarryoutTypeByName(name);}

}
