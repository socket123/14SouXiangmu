package com.vrv.mapper;

import java.util.List;

import com.vrv.entity.AreaCode;

public interface AreaCodeMapper extends BaseDao<AreaCode> {

    public List<AreaCode> findAreaCodeByPage(AreaCode areaCode);

    public AreaCode findAreaCodeById(String areaCode);

    public Integer findAreaByCode(String code);

    public List<AreaCode> selectAreaByTeamId(Integer teamId);

    public List<AreaCode> findGroupCodeByTeam(Integer teamId);

    public AreaCode selectIfAreaByTeamId(AreaCode areaCode);

    public List<AreaCode> selectAreaAll();
}
