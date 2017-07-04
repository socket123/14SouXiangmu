package com.vrv.mapper;

import com.vrv.entity.CarryoutState;

import java.util.List;
import java.util.Map;

public interface CarryoutStateMapper  extends BaseDao<CarryoutState>  {
    public List<CarryoutState> loadAll(Map<String, Object> maps);

    public int countCarryoutStateByName(String name);





}