package com.vrv.controller.backgroud;

import com.vrv.contans.MyConfig;
import com.vrv.entity.CarryOut;
import com.vrv.entity.CarryoutDept;
import com.vrv.service.impl.CarryOutService;
import com.vrv.service.impl.CarryoutDeptService;
import com.vrv.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LXX on 2017-05-12.
 */
@Controller
@RequestMapping(value = "admin/carryoutDept")
public class CarryoutDeptController {
    @Autowired
    CarryoutDeptService carryoutDeptService;

    @Autowired
    CarryOutService carryoutService;

    @RequestMapping(value = "")
    public String gotoCarryoutTypeList(ModelMap modelMap, Integer pageNumber, CarryoutDept carryoutDept) {
        Pager<CarryoutDept> page = carryoutDeptService.getPage(carryoutDept, pageNumber);
        modelMap.put("page", page);
        modelMap.put("carryoutDept", carryoutDept);
        return "backgroud/carryoutDept";
    }

    @RequestMapping(value = "gotoCarryoutDeptAdd")
    public ModelAndView gotoCarryoutDeptAdd(HttpServletRequest request) {
        return new ModelAndView("backgroud/addCarryoutDept");
    }

    @RequestMapping(value = "addCarryoutDept", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> addCarryoutDept(CarryoutDept record) {
        Map<String, Object> map = new HashMap<>();
        Integer ii = carryoutDeptService.countCarryoutDeptByName(record.getDeptName());
        if(ii>0){
            map.put("message", 0);
            map.put("mess", "部门名称不能重复");
            return map;
        }
        record.setCreateTime(new Date());
        Integer i = carryoutDeptService.insert(record);
        map.put("message", i);
        return map;
    }

    @RequestMapping(value = "gotoEdit")
    public ModelAndView gotoEdit(ModelMap map, Integer id) {
        CarryoutDept carryoutDept = carryoutDeptService.get(id);
        map.put("carryoutDept", carryoutDept);
        return new ModelAndView("backgroud/editCarryoutDept", map);
    }

    @RequestMapping(value = "editCarryoutDept")
    @ResponseBody
    public Map<String, Object> editCarryoutDept(CarryoutDept record) {
        Map<String, Object> map = new HashMap<>();
        Integer ii = carryoutDeptService.countCarryoutDeptByName(record.getDeptName());
        if(ii>0){
            map.put("message", 0);
            map.put("mess", "部门名称不能重复");
            return map;
        }
        Integer i = carryoutDeptService.saveOrUpdate(record, record.getId());
        map.put("message", i);
        return map;
    }

    @RequestMapping(value = "deleteCarryoutDept")
    @ResponseBody
    public Map<String, Object> deleteCarryoutDept(Integer id) {
        Map<String, Object> map = new HashMap<>();
        List<CarryOut> carryout = carryoutService.findCarryoutByCarryoutDeptid(id);
        if(null != carryout && carryout.size()>0){
            map.put("mess", "该部门已被使用");
            map.put("message", 0);
            return map;
        }
        Integer i = carryoutDeptService.delete(id);
        map.put("message", i);
        return map;
    }
}
