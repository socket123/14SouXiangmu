package com.vrv.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.entity.SysConfig;
import com.vrv.mapper.SysConfigMapper;
import com.vrv.service.BaseService;

@Service
public class SystemConfigServiceImpl extends BaseService<SysConfig> {

    @Autowired
    SysConfigMapper systemConfigMapper;

    public SysConfig findSystemConfig() {
        return systemConfigMapper.findSystemConfig();
    }
}
