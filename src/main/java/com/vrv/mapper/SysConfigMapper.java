package com.vrv.mapper;

import com.vrv.entity.SysConfig;

public interface SysConfigMapper extends BaseDao<SysConfig> {

    public SysConfig findSystemConfig();
}
