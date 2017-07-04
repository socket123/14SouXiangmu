package com.vrv.service.impl;

import com.vrv.entity.CarryOut;
import com.vrv.mapper.CarryOutMapper;
import com.vrv.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * Created by LXX on 2017-04-27.
 */
@Service
public class CarryOutService extends BaseService<CarryOut> {

    @Autowired
    CarryOutMapper carryOutMapper;

    public CarryOut findByCarryoutCode(String carryOut){return carryOutMapper.findByCarryoutCode(carryOut);}

    public Integer updateBycode(CarryOut CarryOut){return carryOutMapper.updateBycode(CarryOut);}

    public List<CarryOut> findCarryoutByCarryoutTypeid(Integer carryoutTypeid){return carryOutMapper.findCarryoutByCarryoutTypeid(carryoutTypeid);}

    public List<CarryOut> findCarryoutByCarryoutDeptid(Integer carryoutDeptid){return carryOutMapper.findCarryoutByCarryoutDeptid(carryoutDeptid);}

    public List<CarryOut> findCarryoutByCarryoutStateid(Integer carryoutStateid){return carryOutMapper.findCarryoutByCarryoutStateid(carryoutStateid);}

    public List<CarryOut> findCarryoutList(CarryOut CarryOut){return carryOutMapper.findCarryoutList(CarryOut);}
}
