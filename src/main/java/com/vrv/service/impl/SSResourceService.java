package com.vrv.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.entity.SSResource;
import com.vrv.mapper.SSResourceMapper;
import com.vrv.service.BaseService;

@Service
public class SSResourceService extends BaseService<SSResource> {
    @Autowired
    SSResourceMapper ssResourceMapper;

    public List<SSResource> findResourceList(Integer id) {
        return ssResourceMapper.findResourceList(id);
    }

    public List<SSResource> getListByTeamId(Integer teamId) {
        return ssResourceMapper.getListByTeamId(teamId);
    }
}
