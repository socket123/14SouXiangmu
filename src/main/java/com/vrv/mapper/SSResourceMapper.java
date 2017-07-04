package com.vrv.mapper;

import java.util.List;

import com.vrv.entity.SSResource;

public interface SSResourceMapper extends BaseDao<SSResource> {
    public List<SSResource> findResourceList(Integer id);

    List<SSResource> getListByTeamId(Integer teamId);
}