package com.vrv.controller.font;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.vrv.entity.*;
import com.vrv.service.impl.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.vrv.contans.MyConfig;
import com.vrv.utils.AdminUtil;
import com.vrv.utils.StringUtil;

@Controller
@RequestMapping("font/orders")
public class OrdersController {
    @Autowired
    OrderServiceImpl OrderServiceImpl;

    @Autowired
    UserService userService;



    @Autowired
    AreaCodeService areaService;

    @Autowired
    TransportTeamService teamService;

    @Autowired
    TeamRelationService teamRelationService;

    @RequestMapping(value = "")
    public String index(HttpServletRequest request) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        Order order = new Order();
        order.setRecip_user_id(user.getId());
        order.setStatus(2);
        request.setAttribute("newOrderCount", OrderServiceImpl.findOrdersByuIdAndSStatus(order)
                .isEmpty() ? 0 : OrderServiceImpl.findOrdersByuIdAndSStatus(order).size());
        request.setAttribute("user", user);
        return "font_page/myOrders";
    }

    @RequestMapping(value = "myOrders")
    public String indexOrders(HttpServletRequest request) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        request.setAttribute("user", user);
        return "font_page/orders";
    }

    @RequestMapping(value = "myReceiveOrders")
    public String myReceiveOrders(HttpServletRequest request) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        request.setAttribute("user", user);
        return "font_page/receiveOrderList";
    }

    @RequestMapping(value = "roleSelection", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> roleSelection(String param) {
        String msg = "success";
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        if (user != null) {
            TransportTeam ttObj = teamService.selectTeamByUserId(user.getId());
            if (null != ttObj) {
                if (ttObj.getIsEnable() == 1 && !StringUtils.isEmpty(ttObj.getAbility())) {
                    AdminUtil.getInstance().setValue(MyConfig.TEAM_USER, ttObj);
                } else {
                    msg = "您的团队尚未启用或者没有运输能力";
                }
            } else {
                msg = "您还不是团队负责人";
            }
        } else {
            msg = "相应超时，请退出重试";
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("msg", msg);
        return map;
    }

    /**
     * 进入 订单列表
     * @param request
     * @return
     */
    @RequestMapping(value = "indexAcceptOrders")
    public String indexAcceptOrders(HttpServletRequest request) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        if (user != null) {
            TransportTeam ttObj = teamService.selectTeamByUserId(user.getId());
            if (null != ttObj) {
                if (ttObj.getIsEnable() == 1 && !StringUtils.isEmpty(ttObj.getAbility())) {
                    AdminUtil.getInstance().setValue(MyConfig.TEAM_USER, ttObj);
                }
            }
        }
//        List<TeamRelation> teamRelationList = new ArrayList<TeamRelation>();
        List<TeamRelation> teamRelationList = teamRelationService.teamRelationList(user);
        request.setAttribute("teamRelationList", teamRelationList);
        List<SSUser> ssUserList = userService.selectWorker();
        request.setAttribute("ssUserList", ssUserList);
        return "font_page/distribution";
    }


    /**
     * 保存 民工与团队绑定
     * @return
     */
    @RequestMapping(value = "saveTeamRelation", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> saveTeamRelation(String otherIds) {
        Map<String, Object> map = new HashMap<String, Object>();
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
            if(null != user.getId()){
               TransportTeam transportTeam = teamService.selectTeamByUserId(user.getId());
        try {

            if (null == transportTeam && null == transportTeam.getId()) {
                    map.put("msg", "查询不到团队");
                    return map;
                }
            List<String> strings = new ArrayList<String>();
            if(!StringUtil.isEmpty(otherIds)){
                strings =StringUtil.string_split(otherIds);
            }
            // 重置
            List<TeamRelation> teamRelationList = teamRelationService.teamRelationList(user);
            if(null != teamRelationList && teamRelationList.size()> 0){
                teamRelationService.deleteByTeam(teamRelationList.get(0).getTeamId(),teamRelationList.get(0).getType());
                for (TeamRelation teamRelation : teamRelationList){
                    SSUser ssUser = new SSUser();
                    ssUser.setId(teamRelation.getIds());
                    ssUser.setWorker_status(2);//民工状态 1工作 2空闲 3休息
                    userService.updateByPrimaryKeySelective(ssUser);
                }
            }

            if(null != strings && strings.size() > 0){


                // 保存
                for (String maps : strings){
                        TeamRelation teamRelation = new TeamRelation();
                        teamRelation.setOtherId(Integer.parseInt(maps));
                        teamRelation.setTeamId(transportTeam.getId());
                        teamRelation.setType(4);//1范围，2资源，3负责人、4承运小队
                        teamRelation.setSsOrder(0);// 排序
                        SSUser ssUser = new SSUser();
                        ssUser.setId(Integer.parseInt(maps));
                        ssUser.setWorker_status(1);//民工状态 1工作 2空闲 3休息
                        userService.updateByPrimaryKeySelective(ssUser);
                        if(teamRelationService.insertSelective(teamRelation)>0){
                        }else {
                            map.put("msg", "保存失败");
                            return map;
                        }
                    }
            }
            map.put("msg", "success");
//            map.put("obj", transportTeam);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "请识别正确的二维码");
        }
            }
        return map;
    }




    @RequestMapping(value = "smAccept", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> indexAcceptOrders(String param) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isEmpty(param)) {
            map.put("msg", "请识别正确的二维码");
            return map;
        }
        try {
            Gson gson = new Gson();
            QRJson qrStr = gson.fromJson(param, QRJson.class);
            System.out.println(qrStr.toString());

            Order order = new Order();
            order.setWaybill_number(qrStr.getSerialNo());
            order.setCreate_time(qrStr.getDate());
            order.setSend_user(qrStr.getSendPerson());
            order.setSend_position(qrStr.getSendLocation());
            if (StringUtil.isEmpty(qrStr.getSendPerson())) {
                SSUser sendUser = userService.findByUser(order.getSend_user());
                if (null != sendUser) {
                    order.setSend_phone(sendUser.getTelephone());
                    order.setSend_user_id(sendUser.getId());
                }
            }
            if (StringUtil.isEmpty(qrStr.getReceivePerson())) {
                SSUser reciveUser = userService.findByUser(qrStr.getReceivePerson());
                if (null != reciveUser) {
                    order.setRecip_phone(reciveUser.getTelephone());
                    order.setRecip_user_id(reciveUser.getId());
                }
            }
            order.setRecip_user(qrStr.getReceivePerson());
            order.setRecip_position(qrStr.getReceiveLocation());
            order.setSource(qrStr.getSystem());
            order.setIs_urgent(StringUtil.toInt(qrStr.getEmergency()));
            order.setIs_big(StringUtil.toInt(qrStr.getSize()));
            map.put("msg", "success");
            map.put("obj", gson.toJson(order));
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "请识别正确的二维码");
        }
        return map;
    }

    @RequestMapping(value = "toAddOrder")
    public String indexOrders(ModelMap model, Integer is_edit, String param) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        Gson gson = new Gson();
        Order order = gson.fromJson(param, Order.class);
        model.put("user", user);
        model.put("is_edit", is_edit);
        model.put("order", order);
        return "font_page/orders";
    }
}
