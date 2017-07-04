package com.vrv.service.impl;

import com.vrv.entity.CarryoutState;
import com.vrv.mapper.CarryoutStateMapper;
import com.vrv.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by LXX on 2017-05-12.
 */
@Service
public class CarryoutStateService extends BaseService<CarryoutState> {
    @Autowired
    CarryoutStateMapper carryoutStateMapper;

    public List<CarryoutState> loadAll(Map<String, Object> maps){return carryoutStateMapper.loadAll(maps);}

    public int countCarryoutStateByName(String name){return carryoutStateMapper.countCarryoutStateByName(name);}

}
