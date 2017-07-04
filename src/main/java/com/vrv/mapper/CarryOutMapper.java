package com.vrv.mapper;

import com.vrv.entity.CarryOut;
import java.util.List;

public interface CarryOutMapper  extends BaseDao<CarryOut>  {
    public CarryOut findByCarryoutCode(String carryOut);

    public Integer updateBycode(CarryOut CarryOut);

    public List<CarryOut> findCarryoutByCarryoutTypeid(Integer carryoutTypeid);

    public List<CarryOut> findCarryoutByCarryoutDeptid(Integer carryoutDeptid);

    public List<CarryOut> findCarryoutByCarryoutStateid(Integer carryoutStateid);

    public List<CarryOut> findCarryoutList(CarryOut CarryOut);
}