package com.vrv.controller.backgroud;

import com.vrv.contans.MyConfig;
import com.vrv.entity.CarryOut;
import com.vrv.entity.CarryoutState;
import com.vrv.service.impl.CarryOutService;
import com.vrv.service.impl.CarryoutStateService;
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
@RequestMapping(value = "admin/carryoutState")
public class CarryoutStateController {
    @Autowired
    CarryoutStateService carryoutStateService;

    @Autowired
    CarryOutService carryoutService;

    @RequestMapping(value = "")
    public String gotoCarryoutTypeList(ModelMap modelMap, Integer pageNumber, CarryoutState carryoutState) {
        Pager<CarryoutState> page = carryoutStateService.getPage(carryoutState, pageNumber);
        modelMap.put("page", page);
        modelMap.put("carryoutState", carryoutState);
        return "backgroud/carryoutState";
    }

    @RequestMapping(value = "gotoCarryoutStateAdd")
    public ModelAndView gotoCarryoutStateAdd(HttpServletRequest request) {
        return new ModelAndView("backgroud/addCarryoutState");
    }

    @RequestMapping(value = "addCarryoutState", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> addCarryoutState(CarryoutState record) {
        Map<String, Object> map = new HashMap<>();
        Integer ii = carryoutStateService.countCarryoutStateByName(record.getName());
        if(ii>0){
            map.put("message", 0);
            map.put("mess", "状态名称不能重复");
            return map;
        }
        record.setCreateTime(new Date());
        Integer i = carryoutStateService.insert(record);
        map.put("message", i);
        return map;
    }

    @RequestMapping(value = "gotoEdit")
    public ModelAndView gotoEdit(ModelMap map, Integer id) {
        CarryoutState carryoutState = carryoutStateService.get(id);
        map.put("carryoutState", carryoutState);
        return new ModelAndView("backgroud/editCarryoutState", map);
    }

    @RequestMapping(value = "editCarryoutState")
    @ResponseBody
    public Map<String, Object> editCarryoutState(CarryoutState record) {
        Map<String, Object> map = new HashMap<>();
        Integer ii = carryoutStateService.countCarryoutStateByName(record.getName());
        if(ii>0){
            map.put("message", 0);
            map.put("mess", "状态名称不能重复");
            return map;
        }
        Integer i = carryoutStateService.saveOrUpdate(record, record.getId());
        map.put("message", i);
        return map;
    }

    @RequestMapping(value = "deleteCarryoutState")
    @ResponseBody
    public Map<String, Object> deleteCarryoutState(Integer id) {
        Map<String, Object> map = new HashMap<>();
        List<CarryOut> carryout = carryoutService.findCarryoutByCarryoutStateid(id);
        if(null != carryout && carryout.size()>0){
            map.put("mess", "该状态已被使用");
            map.put("message", 0);
            return map;
        }
        Integer i = carryoutStateService.delete(id);
        map.put("message", i);
        return map;
    }
}
