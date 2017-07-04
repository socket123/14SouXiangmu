package com.vrv.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.entity.AreaCode;
import com.vrv.mapper.AreaCodeMapper;
import com.vrv.service.BaseService;

@Service
public class AreaCodeService extends BaseService<AreaCode> {
    @Autowired
    AreaCodeMapper areaCodeMapper;

    public List<AreaCode> findAreaCodeByPage(AreaCode areaCode) {
        return areaCodeMapper.findAreaCodeByPage(areaCode);
    }

    public AreaCode findAreaCodeById(String areaCode) {
        return areaCodeMapper.findAreaCodeById(areaCode);
    }

    public List<AreaCode> selectAreaByTeamId(Integer teamId) {
        return areaCodeMapper.selectAreaByTeamId(teamId);
    }

    public List<AreaCode> findGroupCodeByTeam(Integer teamId) {
        return areaCodeMapper.findGroupCodeByTeam(teamId);
    }

    public Integer findAreaByCode(String code) {
        return areaCodeMapper.findAreaByCode(code);
    }

    public AreaCode selectIfAreaByTeamId(AreaCode areaCode) {
        return areaCodeMapper.selectIfAreaByTeamId(areaCode);
    }

    public List<AreaCode> selectAreaAll() {
        return areaCodeMapper.selectAreaAll();
    }
}
