package com.vrv.controller.backgroud;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vrv.contans.MyConfig;
import com.vrv.entity.SysConfig;
import com.vrv.service.impl.SystemConfigServiceImpl;
import com.vrv.service.log.MyLog;
import com.vrv.utils.DateUtil;

@Controller
@RequestMapping("/admin/sysset")
public class SysConfigController {

    @Autowired
    SystemConfigServiceImpl sysConfigService;

    @RequestMapping("/toEdit")
    public String toEdit(ModelMap model) {
        model.put("obj", sysConfigService.findSystemConfig());
        return "/backgroud/system_set";
    }

    @MyLog(module = "sysset", content = "修改系统设置", type = "edit")
    @RequestMapping(value = "/edit", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> edit(SysConfig obj) {
        int count = 0;
        Map<String, Object> map = new HashMap<String, Object>();
        obj.setUpdateTime(DateUtil.getNowDate(""));
        if (null == obj.getId()) {
            count = sysConfigService.insert(obj);
        } else {
            count = sysConfigService.update(obj);
        }
        map.put("code", count);
        return map;
    }
}
