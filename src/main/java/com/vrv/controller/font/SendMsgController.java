package com.vrv.controller.font;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.vrv.entity.*;
import com.vrv.service.impl.AreaCodeService;
import com.vrv.service.impl.CalendarService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.vrv.service.impl.UserService;
import com.vrv.service.platform.PlatFormService;
import com.vrv.utils.StringUtil;

@Controller
public class SendMsgController {

    @Autowired
    UserService userService;

    @Autowired
    CalendarService calendarService;

    @Autowired
    AreaCodeService areaService;

    public void sendMsg(HttpServletRequest request, Order order, TransportTeam team) {
        if (order.getStatus() == 1) {
            sendMsgtoTeam(request, order,0);
            PlatFormService.sendMessage("物流跟踪提醒", "您有新的订单:" + order.getWaybill_number()
                            + "正在等待配送；点击查看详情", getURL(request)
                            + "font/orderList/findOrderDetail?id=" + order.getId() + "&status=3&role=2",
                    userService.get(order.getRecip_user_id()).getDdId());
        } else if (order.getStatus() == 2) {
            PlatFormService.sendMessage("物流跟踪提醒", "您的订单:" + order.getWaybill_number()
                    + "正在配送；配送团队是：" + team.getTeamName() + "，点击查看详情", getURL(request)
                    + "font/orderList/findOrderDetail?id=" + order.getId() + "&status=2&role=1",
                    userService.get(order.getSend_user_id()).getDdId());
        } else if (order.getStatus() == 3) {
            PlatFormService.sendMessage("订单完成通知", "您的订单:" + order.getWaybill_number()
                    + "已确认收货，点击查看详情", getURL(request) + "font/orderList/findOrderDetail?id="
                    + order.getId() + "&status=2&role=1", userService.get(order.getSend_user_id())
                    .getDdId());
        } else if (order.getStatus() == 4) {
            sendMsgtoTeam(request, order,0);
            PlatFormService.sendMessage("取消订单", order.getSend_user() + "取消了订单，订单号："
                            + order.getWaybill_number() + "！点击查看详情", getURL(request)
                            + "font/orderList/findOrderDetail?id=" + order.getId()
                            + "&status=3&role=2", userService.get(order.getRecip_user_id()).getDdId());
            PlatFormService.sendMessage("取消订单", order.getSend_user() + "取消了订单，订单号："
                    + order.getWaybill_number() + "！点击查看详情", getURL(request)
                    + "font/orderList/findOrderDetail?id=" + order.getId()
                    + "&status=3&role=2", userService.get(order.getSend_user_id()).getDdId());
        } else if (order.getStatus() == 5) {
            PlatFormService.sendMessage("物流跟踪提醒", "您的订单:" + order.getWaybill_number()
                    + "已送达；配送团队是：" + team.getTeamName() + "，点击查看详情", getURL(request)
                    + "font/orderList/findOrderDetail?id=" + order.getId() + "&status=2&role=1",
                    userService.get(order.getSend_user_id()).getDdId());

            PlatFormService.sendMessage("物流跟踪提醒", "您有新的订单:" + order.getWaybill_number()
                    + "已送达，请及时确认收货；配送团队是：" + team.getTeamName() + "，点击查看详情", getURL(request)
                    + "font/orderList/findOrderDetail?id=" + order.getId() + "&status=2&role=2",
                    userService.get(order.getRecip_user_id()).getDdId());
        } else if (order.getStatus() == 6 || order.getStatus() == 8) {
            sendMsgtoTeam(request, order,0);
        }
    }

    public void sendMsgtoTeam(HttpServletRequest request, Order order,Integer falg) {
        //查出符合条件的团队
        Integer status = order.getStatus();
        List<SSUser> userList = new ArrayList<SSUser>();
        List<Calendar> calendarL = calendarService.selectByTimeNow();
        String areaTrunk="";
        String userIdString = ",";
        if(falg==1){
            PlatFormService.sendMessage("取消订单", "管理员取消了订单，订单号："
                    + order.getWaybill_number() + "！点击查看详情", getURL(request)
                    + "font/orderList/findOrderDetail?id=" + order.getId()
                    + "&status=3&role=2", userService.get(order.getRecip_user_id()).getDdId());
        }
        if(calendarL!=null&&!calendarL.isEmpty()){
            Calendar calendar = calendarL.get(0);
            if (calendar.getType().equals("1")) {//加班时间
                userList = userService.findTeamUserNew("",
                        "", "");
            } else{
                if(status==1 || status==4){
                    userList = userService.findTeamUserNew(order.getSend_position(),
                            "", order.getIs_big() + "");
                } else if(status==6){
                    AreaCode areaCode = areaService.findAreaCodeById(order.getSend_position());
                    AreaCode areaCode1 = areaService.findAreaCodeById(order.getRecip_position());
                    areaTrunk = areaCode.getAreaTrunk();
                    List<SSUser> userList1 = new ArrayList<SSUser>();
                    if(areaCode!=null){
                        userList = userService.findTeamUser(areaTrunk,
                                order.getRecip_position(), order.getIs_big() + "");
                    }
                    if(areaCode1!=null){
                        userList1 = userService.findTeamUser(areaTrunk,
                        areaCode1.getAreaTrunk(), order.getIs_big() + "");
                    }
                    if (null == userList) {
                        userList = userList1;
                    } else {
                        userList.addAll(userList1);
                    }
                } else if(status==8){
                    AreaCode areaCode1 = areaService.findAreaCodeById(order.getRecip_position());
                    areaTrunk = areaCode1.getAreaTrunk();
                    if(areaCode1!=null){
                        userList = userService.findTeamUser(areaTrunk,
                                order.getRecip_position(), order.getIs_big() + "");
                    }
                }
            }
        }
        if (!StringUtil.isEmpty(userList)) {
            for (SSUser user : userList) {
                if (!StringUtils.isEmpty(user.getDdId())) {
                    if(userIdString.indexOf(","+user.getDdId()+",")>-1){

                    } else{
                        userIdString+=user.getDdId()+",";
                        if(falg==1){
                            PlatFormService.sendMessage("取消订单", "管理员取消了订单，订单号："
                                    + order.getWaybill_number() + "！点击查看详情", getURL(request)
                                    + "font/orderList/findOrderDetail?id=" + order.getId()
                                    + "&status=3&role=3", user.getDdId());
                        } else{
                            if (status == 1) {
                                //发送消息
                                PlatFormService.sendMessage(
                                        "新订单",
                                        order.getSend_user() + "下了新的订单，订单号：" + order.getWaybill_number()
                                                + "，从" + order.getSend_position() + "发往"
                                                + order.getRecip_position() + ";赶快接货吧！点击查看详情",
                                        getURL(request) + "font/orderList/findOrderDetail?id="
                                                + order.getId() + "&status=3&role=3", user.getDdId());
                            } else if (status == 4) {
                                PlatFormService.sendMessage("取消订单", order.getSend_user() + "取消了订单，订单号："
                                        + order.getWaybill_number() + "！点击查看详情", getURL(request)
                                        + "font/orderList/findOrderDetail?id=" + order.getId()
                                        + "&status=3&role=3", user.getDdId());
                            } else if (status == 6 || status == 8) {
                                //发送消息
                                PlatFormService.sendMessage(
                                        "中转订单",
                                        "订单号：" + order.getWaybill_number()
                                                + "，从" + order.getSend_position() + "发往"
                                                + order.getRecip_position() + ";已抵达中转点" + areaTrunk + "，赶快接货吧！点击查看详情",
                                        getURL(request) + "font/orderList/findOrderDetail?id="
                                                + order.getId() + "&status=3&role=3", user.getDdId());
                            }
                        }
                    }
                }
            }
        }
    }

    private static String getURL(HttpServletRequest request) {
        return "http://" + request.getServerName() //服务器地址  
                + ":" + request.getServerPort() //端口号  
                + request.getContextPath() + "/"; //项目名称  
    }
}
