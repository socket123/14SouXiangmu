package com.vrv.controller.backgroud;

import com.vrv.contans.MyConfig;
import com.vrv.entity.*;
import com.vrv.service.impl.CarryOutService;
import com.vrv.service.impl.CarryoutTypeService;
import com.vrv.utils.JSONutils;
import com.vrv.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by LXX on 2017-05-02.
 */
@Controller
@RequestMapping(value = "admin/carryoutType")
public class CarryoutTypeController {

    @Autowired
    CarryoutTypeService carryoutTypeService;

    @Autowired
    CarryOutService carryoutService;

    @RequestMapping(value = "")
    public String gotoCarryoutTypeList(ModelMap modelMap, Integer pageNumber, CarryoutType carryoutType) {
        Pager<CarryoutType> page = carryoutTypeService.getPage(carryoutType, pageNumber);
        modelMap.put("page", page);
        modelMap.put("carryoutType", carryoutType);
        return "backgroud/carryoutType";
    }

    @RequestMapping(value = "gotoCarryoutTypeAdd")
    public ModelAndView gotoCarryoutTypeAdd(HttpServletRequest request) {
        return new ModelAndView("backgroud/addCarryoutType");
    }

    @RequestMapping(value = "addCarryoutType", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> addCarryoutType(CarryoutType record) {
        Map<String, Object> map = new HashMap<>();
        Integer ii = carryoutTypeService.countCarryoutTypeByName(record.getName());
        if(ii>0){
            map.put("message", 0);
            map.put("mess", "分类名称不能重复");
            return map;
        }
        record.setCreatTime(new Date());
        Integer i = carryoutTypeService.insert(record);
        map.put("message", i);
        return map;
    }

    @RequestMapping(value = "gotoEdit")
    public ModelAndView gotoEdit(ModelMap map, Integer id) {
        CarryoutType carryoutType = carryoutTypeService.get(id);
        map.put("carryoutType", carryoutType);
        return new ModelAndView("backgroud/editCarryoutType", map);
    }

    @RequestMapping(value = "editCarryoutType")
    @ResponseBody
    public Map<String, Object> editCarryoutType(CarryoutType record) {
        Map<String, Object> map = new HashMap<>();
        Integer ii = carryoutTypeService.countCarryoutTypeByName(record.getName());
        if(ii>0){
            map.put("message", 0);
            map.put("mess", "分类名称不能重复");
            return map;
        }
        Integer i = carryoutTypeService.saveOrUpdate(record, record.getId());
        map.put("message", i);
        return map;
    }

    @RequestMapping(value = "deleteCarryoutType")
    @ResponseBody
    public Map<String, Object> deleteCarryoutType(Integer id) {
        Map<String, Object> map = new HashMap<>();
        String message="";
        List<CarryoutType> carryoutType = carryoutTypeService.findCarryoutTypeByPid(id);
        if(null != carryoutType && carryoutType.size()>0){
            message="该类别下有子类，请先删除子类";
            map.put("mess", message);
            map.put("message", 0);
            return map;
        }
        List<CarryOut> carryout = carryoutService.findCarryoutByCarryoutTypeid(id);
        if(null != carryout && carryout.size()>0){
            message="该类别已被使用";
            map.put("mess", message);
            map.put("message", 0);
            return map;
        }
        Integer i = carryoutTypeService.delete(id);
        map.put("message", i);
        return map;
    }

    /**
     * Ztree树形菜单
     */
    @ResponseBody
    @RequestMapping(value = "ztree", produces = "text/plain;charset=utf-8")
    public String ztreeList(HttpServletRequest request, ModelMap map, Integer pid) {
        // 增加查询条件
        Map<String, Object> maps = new HashMap<String, Object>();
        // 获取ztree树形结构
        List<ZtreeEntity> ztreeList = new ArrayList<ZtreeEntity>();
        List<CarryoutType> menus = carryoutTypeService.loadAll(maps);
        // 组装ztree格式数据

        //添加根节点
        ZtreeEntity z1 = new ZtreeEntity();
        z1.setpId(new Long(-1));
        z1.setPidL("");
        z1.setpNameL("");
        z1.setId(new Long(0));
        z1.setName("根");
        if(pid==null || pid.equals("")){
            z1.setChecked("true");
        }
        ztreeList.add(z1);
        for (CarryoutType m : menus) {
            ZtreeEntity z = new ZtreeEntity();
            Long pidl = new Long(m.getPid());
            z.setpId(pidl);
            String re = getAllPid(pidl.intValue());
            if(!re.equals("")){
                z.setPidL(re.split("@")[0]);
                z.setpNameL(re.split("@")[1]);
            } else{
                z.setPidL("");
                z.setpNameL("");
            }
            z.setId(new Long(m.getId()));
            z.setName(m.getName());
            if (pid != null&&pid.equals(m.getId())) {
                z.setChecked("true");
            }
            ztreeList.add(z);
        }
        return JSONutils.listToJson(ztreeList);
    }

    public String getAllPid(Integer pid){
        String pidL="";
        String pName="";
        String result = "";
        if(pid != 0){
            CarryoutType carryoutType = carryoutTypeService.get(pid);
            if(null != carryoutType){
                Integer pidP=carryoutType.getPid();
                pidL=carryoutType.getId()+",";
                pName= carryoutType.getName()+",";
                String re = getAllPid(pidP);
                if(!re.equals("")){
                    pidL+=re.split("@")[0];
                    pName+=re.split("@")[1];
                }
            }
            result = pidL +"@"+ pName;
        }
        return result;
    }


}
