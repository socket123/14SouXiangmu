package com.vrv.controller.font;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vrv.entity.*;
import com.vrv.entity.Calendar;
import com.vrv.service.impl.*;
import com.vrv.utils.DateUtil;
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
@RequestMapping("font/orderList")
public class DistributionController {

    @Autowired
    OrderServiceImpl orderService;

    @Autowired
    SendMsgController sendMsgController;

    @Autowired
    AreaCodeService areaService;

    @Autowired
    TransportTeamService transportTeamService;

    @Autowired
    UserService userService;

    @Autowired
    CarryOutService carryoutService;

    @Autowired
    EvaluateService evaluateService;

    @Autowired
    CalendarService calendarService;


    @Autowired
    TeamRelationService teamRelationService;




    @RequestMapping(value = "/index")
    public String index() {
        return "font_page/orderList";
    }

    @RequestMapping(value = "findOrderDetail")
    public String findOrderDetail(ModelMap model, Integer id, Integer status, Integer role) {
        Order order = null;
        if (status != 1 && status != 4) {
            order = orderService.getByPrimaryKey(id);
        } else {
            order = orderService.get(id);
        }
        Integer teamId = null;
        TransportTeam team = getTeam();
        if (null != team) {
            teamId = team.getId();
        }
        Date nowtime = DateUtil.string2Date(DateUtil.getNowDate(""),"");
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);

        Integer uid = user.getId();
        status = order.getStatus();
        if(status>1){//订单已被揽件，判断发货方是否评价
            if(order.getIf_evalute_send()==null || order.getIf_evalute_send()!=1){//发货方未评价
                String delivery_time = order.getDelivery_time();
                int betseconds = DateUtil.getBetweenMinuts(nowtime,DateUtil.string2Date(delivery_time,""));
                if((betseconds/60)>24){//添加默认评价
                    Evaluate evaluate = new Evaluate();
                    evaluate.setCreateTime(nowtime);
                    evaluate.setOrderId(order.getId());
                    evaluate.setSendorreci("s");
                    evaluate.setEvaluateUserid(uid);
                    evaluate.setEvaluateCourier(order.getSend_courier());
                    evaluate.setServiceAttitude(4);
                    evaluate.setTimeliness(4);
                    evaluate.setServiceQuality(4);
                    evaluate.setIfDefault(1);
                    evaluate.setTeamId(teamId);
                    evaluateService.insert(evaluate);
                    order.setIf_evalute_send(1);
                    orderService.update(order);
                } else{
                    if(uid.equals(order.getSend_user_id())){//当前用户是发货人
                        order.setIf_evalute_send(0);
                    }
                }
            }
        }
        if(status == 3){//订单已完成，判断接收方是否评价
            if(order.getIf_evalute_recip() == null || order.getIf_evalute_recip()!=1){//收货方未评价
                String recip_time = order.getRecip_time();
                int betseconds = DateUtil.getBetweenMinuts(nowtime,DateUtil.string2Date(recip_time,""));
                if((betseconds/60)>24){//添加默认评价
                    Evaluate evaluate = new Evaluate();
                    evaluate.setCreateTime(nowtime);
                    evaluate.setOrderId(order.getId());
                    evaluate.setSendorreci("r");
                    evaluate.setEvaluateUserid(uid);
                    evaluate.setEvaluateCourier(order.getRecip_courier());
                    evaluate.setServiceAttitude(4);
                    evaluate.setTimeliness(4);
                    evaluate.setServiceQuality(4);
                    evaluate.setIfDefault(1);
                    evaluate.setTeamId(teamId);
                    evaluateService.insert(evaluate);
                    order.setIf_evalute_recip(1);
                    orderService.update(order);
                } else{
                    if(uid.equals(order.getRecip_user_id())){//当前用户是收货人
                        order.setIf_evalute_recip(0);
                    }
                }
            }
        }
        model.put("order", order);
        model.put("role", role);
        return "font_page/details";
    }

    @RequestMapping(value = "findOrderDetailByJsonStr")
    @ResponseBody
    public Map<String, Object> findOrderDetailByJsonStr(HttpServletRequest request, String jsonStr,
            String position) {
        Map<String, Object> map = new HashMap<String, Object>();

        if (StringUtils.isEmpty(position) || StringUtils.isEmpty(jsonStr)) {
            map.put("msg", "请识别正确的二维码！");
            return map;
        }
        try {
            Gson gson = new Gson();
            QRJson qrStr = gson.fromJson(jsonStr, QRJson.class);
            String waybill_number = qrStr.getSerialNo();
            Order order = orderService.selectBySerialNo(waybill_number);
            if (null == order) {
                map.put("msg", "订单不存在！");
                return map;
            }
            TransportTeam team = getTeam();
            if (null == team) {
                map.put("msg", "您还不是运输团队负责人！");
                return map;
            }
            List<Calendar> calendarL = calendarService.selectByTimeNow();
            if(calendarL==null||calendarL.isEmpty()){
                map.put("msg", "当前是休息时间！");
                return map;
            } else{
                int status = 0;
                int overtime = 0;
                Calendar calendar = calendarL.get(0);
                if(calendar.getType().equals("1")){//加班时间
                    overtime = 1;
                    if (order.getStatus() == 1) {//第一次接货
                        if (!position.equals(order.getSend_position())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 9;
                    } else if (order.getStatus() == 9) {//最后卸货
                        if (!position.equals(order.getRecip_position())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 5;
                        if (order.getTeam_id() != getTeam().getId()) {
                            map.put("msg", "您不能扫描不是自己的单据！");
                            return map;
                        }
                    } else if (order.getStatus() == 2) {//第一次到达中转点
                        AreaCode areaCode = areaService.findAreaCodeById(order.getSend_position());
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 5;
                        if (order.getTeam_id() != getTeam().getId()) {
                            map.put("msg", "您不能扫描不是自己的单据！");
                            return map;
                        }
                    } else if (order.getStatus() == 6) {//第一次从中转点接货
                        AreaCode areaCode = areaService.findAreaCodeById(order.getSend_position());
                        AreaCode areaCode1 = areaService.findAreaCodeById(order.getRecip_position());
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 9;
                    } else if (order.getStatus() == 7) {//第二次到达中转点
                        AreaCode areaCode = areaService.findAreaCodeById(order.getRecip_position());
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 5;
                        if (order.getTeam_id() != getTeam().getId()) {
                            map.put("msg", "您不能扫描不是自己的单据！");
                            return map;
                        }
                    } else if (order.getStatus() == 8) {//第二次从中转点接货
                        AreaCode areaCode = areaService.findAreaCodeById(order.getRecip_position());
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 9;
                    }
                } else{
                    overtime = 0;
                    List<AreaCode> areaCodes = areaService.selectAreaByTeamId(team.getId());
                    if (StringUtil.isEmpty(areaCodes)) {
                        map.put("msg", "您的运输团队没有覆盖该范围！");
                        return map;
                    }
                    List<String> cdstr = new ArrayList<String>();
                    for (AreaCode code : areaCodes) {
                        cdstr.add(code.getAreaCode());
                    }
                    if (order.getStatus() == 1) {//第一次接货
                        if (!cdstr.contains(order.getSend_position())) {
                            map.put("msg", "您的运输团队没有覆盖该范围！");
                            return map;
                        }
                        if (!position.equals(order.getSend_position())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        if (team.getAbility().indexOf(order.getIs_big() + "") < 0) {
                            map.put("msg", "您的团队没有能力接收该货物！");
                            return map;
                        }
                        status = 2;
                    } else if (order.getStatus() == 9) {//最后卸货
                        if (!cdstr.contains(order.getRecip_position())) {
                            map.put("msg", "您的运输团队没有覆盖该范围！");
                            return map;
                        }
                        if (!position.equals(order.getRecip_position())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 5;
                        if (order.getTeam_id() != getTeam().getId()) {
                            map.put("msg", "您不能扫描不是自己的单据！");
                            return map;
                        }
                    } else if (order.getStatus() == 2) {//第一次到达中转点
                        AreaCode areaCode = areaService.findAreaCodeById(order.getSend_position());
                        if(!cdstr.contains(areaCode.getAreaTrunk())){
                            map.put("msg", "您的运输团队没有覆盖该范围！");
                            return map;
                        }
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 6;
                        if (order.getTeam_id() != getTeam().getId()) {
                            map.put("msg", "您不能扫描不是自己的单据！");
                            return map;
                        }
                    } else if (order.getStatus() == 6) {//第一次从中转点接货
                        AreaCode areaCode = areaService.findAreaCodeById(order.getSend_position());
                        AreaCode areaCode1 = areaService.findAreaCodeById(order.getRecip_position());
                        if(!cdstr.contains(areaCode.getAreaTrunk()) ||
                                (   !cdstr.contains(areaCode1.getAreaTrunk()) &&
                                        !cdstr.contains(order.getRecip_position()) )
                                ){
                            map.put("msg", "您的运输团队没有覆盖该范围！");
                            return map;
                        }
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 7;
                        if (team.getAbility().indexOf(order.getIs_big() + "") < 0) {
                            map.put("msg", "您的团队没有能力接收该货物！");
                            return map;
                        }
                    } else if (order.getStatus() == 7) {//第二次到达中转点
                        AreaCode areaCode = areaService.findAreaCodeById(order.getRecip_position());
                        if(!cdstr.contains(areaCode.getAreaTrunk())){
                            map.put("msg", "您的运输团队没有覆盖该范围！");
                            return map;
                        }
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 8;
                        if (order.getTeam_id() != getTeam().getId()) {
                            map.put("msg", "您不能扫描不是自己的单据！");
                            return map;
                        }
                    } else if (order.getStatus() == 8) {//第二次从中转点接货
                        AreaCode areaCode = areaService.findAreaCodeById(order.getRecip_position());
                        if(!cdstr.contains(areaCode.getAreaTrunk())
                                || !cdstr.contains(order.getRecip_position())){
                            map.put("msg", "您的运输团队没有覆盖该范围！");
                            return map;
                        }
                        if (!position.equals(areaCode.getAreaTrunk())) {
                            map.put("msg", "该货物对应的配载点位置不正确！");
                            return map;
                        }
                        status = 9;
                        if (team.getAbility().indexOf(order.getIs_big() + "") < 0) {
                            map.put("msg", "您的团队没有能力接收该货物！");
                            return map;
                        }
                    }
                }
                if (status > 0) {

                    map = updateStatus(request, order.getId(), status, overtime);
                    if (StringUtil.toInt(map.get("message")) <= 0) {
                        map.put("msg", map.get("message"));
                        return map;
                    }
                }
                map.put("msg", "success");
                map.put("order", order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "请识别正确的二维码！");
        }
        return map;
    }

    @RequestMapping(value = "showPostionOrders")
    public String showPostionOrders(HttpServletRequest request, ModelMap model, String send_position, Integer inCount,
            Integer outCount, Integer status) {
        TransportTeam team = (TransportTeam) AdminUtil.getInstance().getValue(MyConfig.TEAM_USER);
        String topage = "";
        List<Order> orders = null;
        List<Order> orders1 = null;
        List<Order> orders2 = null;
        List<Order> oList = new ArrayList<Order>();
        List<Order> oList2 = new ArrayList<Order>();
        List<Calendar> calendarL = calendarService.selectByTimeNow();
        if (status == 1) {//我的任务
            orders = orderService.findMapOrders("(`status` = 6 OR `status` = 7)",
                    "(send_position in (select area_code from area_code where area_trunk = " + send_position + " ) or recip_position in (select area_code from area_code where area_trunk = " + send_position
                            + " )) ");
            orders1 = orderService.findMapOrders("(`status` = 1 OR `status` = 9)",
                    "(send_position  = " + send_position + "  or recip_position  = " + send_position
                            + " ) ");
            orders2 = orderService.findMapOrders("(`status` = 2 OR `status` = 8)",
                    "(send_position in (select area_code from area_code where area_trunk = " + send_position + " ) or recip_position in (select area_code from area_code where area_trunk = " + send_position
                            + " )) ");
            if (null == orders) {
                orders = orders1;
            } else {
                orders.addAll(orders1);
            }
            if (null == orders) {
                orders = orders2;
            } else {
                orders.addAll(orders2);
            }
            for (int i = 0; null != orders && i < orders.size(); i++) {
                Order order2 = orders.get(i);
                boolean flag = false;
                boolean flagca = false;
                if(calendarL!=null&&!calendarL.isEmpty()&&calendarL.get(0).getType().equals("1")){//加班时间
                    flag = true;
                    flagca = true;
                } else{
                    if (team.getAbility().indexOf(order2.getIs_big() + "") > -1) {
                        flag = true;
                    }
                }
                if (order2.getStatus() == 1
                        && order2.getSend_position().equals(send_position)
                        && flag) {
                    oList.add(order2);
                } else if (order2.getStatus() == 2
                        && team.getId() == order2.getTeam_id()
                        && flag) {
                    AreaCode acode = areaService.findAreaCodeById(order2.getSend_position());
                    if (null != acode && acode.getAreaTrunk().equals(send_position)) {
                        oList2.add(order2);
                    }
                } else if (order2.getStatus() == 8
                        && flag) {
                    AreaCode acode = areaService.findAreaCodeById(order2.getRecip_position());
                    if (null != acode && acode.getAreaTrunk().equals(send_position)) {
                        if(flagca){
                            oList.add(order2);
                        } else{
                            AreaCode areacode1 = new AreaCode();
                            areacode1.setTeamId(team.getId());
                            areacode1.setAreaCode(order2.getRecip_position());
                            AreaCode areaCode = areaService.selectIfAreaByTeamId(areacode1);
                            if (null != areaCode) {//收货地址在当前团队的配送范围
                                oList.add(order2);
                            }
                        }
                    }
                } else if (order2.getStatus() == 9
                        && order2.getRecip_position().equals(send_position)
                        && team.getId() == order2.getTeam_id()
                        && flag) {
                    oList2.add(order2);
                } else if (order2.getStatus() == 6
                        && flag) {
                    AreaCode acode = areaService.findAreaCodeById(order2.getSend_position());
                    if (null != acode && acode.getAreaTrunk().equals(send_position)) {
                        if(flagca){
                            oList.add(order2);
                        } else{
                            AreaCode areacode1 = new AreaCode();
                            areacode1.setTeamId(team.getId());
                            areacode1.setAreaCode(order2.getRecip_position());
                            AreaCode areaCode = areaService.selectIfAreaByTeamId(areacode1);
                            if (null == areaCode) {//收货地址不在当前团队的配送范围
                                AreaCode acode1 = areaService.findAreaCodeById(order2.getRecip_position());
                                areacode1.setAreaCode(acode1.getAreaTrunk());
                                areaCode = areaService.selectIfAreaByTeamId(areacode1);
                                if (null != areaCode) {//收货地址的中转点在当前团队的配送范围
                                    oList.add(order2);
                                }
                            } else {
                                oList.add(order2);
                            }
                        }
                    }
                } else if (order2.getStatus() == 7
                        && team.getId() == order2.getTeam_id()
                        && flag) {
                    AreaCode acode = areaService.findAreaCodeById(order2.getRecip_position());
                    if (null != acode && acode.getAreaTrunk().equals(send_position)) {
                        oList2.add(order2);
                    }
                }
            }
            model.put("orders", oList);//待揽件
            model.put("orders2", oList2);//待送达
            topage = "font_page/distributionDetails";
        }


        model.put("send_position", send_position);
        model.put("inCount", inCount);
        model.put("outCount", outCount);
        return topage;
    }

    /**
     * Description: <br>
     * 未完成配载点汇总
     * 
     * @return <br>
     */
    @RequestMapping(value = "unfinishOrders", produces = MyConfig.PRODUCES)
    public @ResponseBody List<AreaCode> findPostionAndNewOrderCount(HttpServletRequest request,
            HttpServletResponse response) {
        List<AreaCode> areaCodeList = null;
        try {
            SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
            if (user != null) {
                TransportTeam ttObj = transportTeamService.selectTeamByUserId(user.getId());
                areaCodeList = orderService.findUnfinishOrders(ttObj.getId(), ttObj.getAbility());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return areaCodeList;
    }

    /**
     * Description: <br>
     * 团队已完成订单展示
     * 
     * @return <br>
     */
    @RequestMapping(value = "finishOrders")
    public String findfinishOrders(HttpServletRequest request, ModelMap model) {
        List<Order> orderList = null;
        try {
            //查询出所有已完成（包含卸货和确认收货）订单
            orderList = orderService.findMapOrders("((`status` = 3 OR `status` = 5) and branchrecip_id = "
                    + getTeam().getId()+") OR ((`status` >= 6) and branchsend_id = "
                    + getTeam().getId()+") OR ((`status` = 8) and trunk_id = "
                    + getTeam().getId()+") ", null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("orderList", orderList);
        return "/font_page/orderlist_finish";
    }

    @RequestMapping(value = "updateStatus", produces = MyConfig.PRODUCES)
    public @ResponseBody Map<String, Object> updateStatus(HttpServletRequest request, Integer id,
            Integer status,Integer overtime) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", "0");
        try {
            Integer teamId = null;
            TransportTeam team = getTeam();
            if (null != team) {
                teamId = team.getId();
            }
            SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
            Integer result = orderService.updateStatus(status, id, teamId,user.getId(), overtime);
            map.put("message", result);
            if (result > 0) {
                Order order = orderService.get(id);
                //发消息
                sendMsgController.sendMsg(request, order, team);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "selectTransportTeamByUserId", produces = MyConfig.PRODUCES)
    public @ResponseBody TransportTeam selectTransportTeamByUserId(HttpServletRequest request,
            HttpServletResponse response) {
        return getTeam();
    }

    public TransportTeam getTeam() {
        TransportTeam team = null;
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        if (user != null) {
            team = transportTeamService.selectTeamByUserId(user.getId());
        }
        return team;
    }

    @RequestMapping(value = "checkWaybillNumberIsExist", produces = MyConfig.PRODUCES)
    public @ResponseBody Map<String, Object> checkWaybillNumberIsExist(HttpServletRequest request,
            HttpServletResponse response, String waybill_number) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", "0");
        try {
            map.put("message", orderService.selectBySerialNo(waybill_number) == null ? 0 : 1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "updateCarryOut", produces = MyConfig.PRODUCES)
    public @ResponseBody Map<String, Object> updateCarryOut(HttpServletRequest request, Integer id, String carryoutCode, Integer status,String position) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", "0");
        map.put("messageForCarry", "0");
        try {
            Integer teamId = null;
            Integer result = 1;
            Integer result1 = null;
            TransportTeam team = getTeam();
            if (null != team) {
                teamId = team.getId();
            }
            if(result>0){
                //修改载具的使用状态
                CarryOut carryout = carryoutService.findByCarryoutCode(carryoutCode.toString());
                if (null == carryout) {
                    result1  = 0;
                } else{
                    if(carryout.getStatus().equals(1)){//当前载具是使用中
                        carryout.setStatus(0);
                    } else{
                        carryout.setStatus(1);
                    }
                    carryout.setTeamId(teamId);
                    carryout.setPosition(position);
                    carryout.setLastTime(new Date());
                    result = carryoutService.update(carryout);
                    result1  = 1;
                }
            }
            map.put("messageForCarry", result1);
            map.put("message", result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Description: <br>
     * 用户评价
     *
     * @return <br>
     */
    @RequestMapping(value = "gotoEvaluateOrder")
    public String gotoEvaluateOrder(HttpServletRequest request, ModelMap model,Integer orderId) {
        Order order = null;
        try {
            //查询出所有已完成（包含卸货和确认收货）订单
            order = orderService.get(orderId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("order", order);
        return "/font_page/evaluate";
    }

    /**
     * Description: <br>
     * 添加用户评价
     *
     * @return <br>
     */
    @RequestMapping(value = "addEvaluateOrder")
    public @ResponseBody Map<String, Object> addEvaluateOrder(HttpServletRequest request,Integer orderId,Integer service_attitude,Integer timeliness,Integer service_quality,String remark) {
        Order order = null;
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", 0);
        try {
            Integer teamId = null;
            TransportTeam team = getTeam();
            if (null != team) {
                teamId = team.getId();
            }
            Date nowtime = DateUtil.string2Date(DateUtil.getNowDate(""),"");
            SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
            Integer uid = user.getId();
            //查询出所有已完成（包含卸货和确认收货）订单
            order = orderService.get(orderId);
            Evaluate evaluate = new Evaluate();
            if(uid.equals(order.getSend_user_id())){//当前用户是发货人
                evaluate.setSendorreci("s");
                evaluate.setEvaluateCourier(order.getSend_courier());
                evaluate.setTeamId(order.getBranchsend_id());
                order.setIf_evalute_send(1);
                orderService.update(order);
            } else if(uid.equals(order.getRecip_user_id())){//当前用户是收货人
                evaluate.setSendorreci("r");
                evaluate.setEvaluateCourier(order.getRecip_courier());
                evaluate.setTeamId(order.getBranchrecip_id());
                order.setIf_evalute_recip(1);
                orderService.update(order);
            }
            evaluate.setCreateTime(nowtime);
            evaluate.setOrderId(order.getId());
            evaluate.setEvaluateUserid(uid);
            evaluate.setServiceAttitude(service_attitude);
            evaluate.setTimeliness(timeliness);
            evaluate.setServiceQuality(service_quality);
            evaluate.setRemark(remark);
            evaluate.setIfDefault(0);
            evaluate.setTeamId(teamId);
            try {
                Integer re = evaluateService.insert(evaluate);
                map.put("message", re);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}



