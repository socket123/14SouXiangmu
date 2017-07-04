package com.vrv.mapper;

import com.vrv.entity.CarryoutType;

import java.util.List;
import java.util.Map;

public interface CarryoutTypeMapper extends BaseDao<CarryoutType> {
    public List<CarryoutType> loadAll(Map<String, Object> maps);

    public List<CarryoutType> findCarryoutTypeByPid(Integer pid);

    public int countCarryoutTypeByName(String name);
}