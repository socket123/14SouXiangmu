package com.vrv.service.impl;

import java.util.*;

import com.vrv.contans.MyConfig;
import com.vrv.entity.*;
import com.vrv.entity.Calendar;
import com.vrv.utils.AdminUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.mapper.OrderMapper;
import com.vrv.service.BaseService;
import com.vrv.utils.DateUtil;
import com.vrv.utils.StringUtil;

@Service
public class OrderServiceImpl extends BaseService<Order> {

    @Autowired
    UserService userService;

    @Autowired
    OrderMapper orderMapper;

    @Autowired
    AreaCodeService areaService;

    @Autowired
    CalendarService calendarService;


    @Autowired
    TeamRelationService teamRelationService;



    public List<Order> findOrderByPage(Order order) {
        return orderMapper.findOrderByPage(order);
    }

    public List<Order> findOrderBypage(Order order) {
        return orderMapper.findOrderBypage(order);
    }

    public Integer addOrder(Order order) {
        return orderMapper.addOrder(order);
    }

    /**
     * Description: <br>
     * 查询完成订单
     * 
     * @param statusRemark (`status` = 3 OR `status` = 5) position
     * @param position
     * @return <br>
     */
    public List<Order> findMapOrders(String statusRemark, String position) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("statusRemark", statusRemark);
        map.put("position", position);
        return orderMapper.findMapOrders(map);
    }

    public List<AreaCode> findUnfinishOrders(Integer teamId, String isBig) {
        List<Calendar> calendarL = calendarService.selectByTimeNow();
        List<AreaCode> list = new ArrayList<AreaCode>();
        if (calendarL != null && !calendarL.isEmpty()&&calendarL.get(0).getType().equals("1")) {
            list = areaService.selectAreaAll();
        } else{
            list = areaService.selectAreaByTeamId(teamId);
        }
        if (!StringUtil.isEmpty(list)) {
            //查询出所有未完成订单
            List<Order> orderList = this.findMapOrders("(`status` not in (3,4,5))", null);

            for (AreaCode code : list) {
                int inCount = 0;//待送达
                int outCount = 0;//待揽件
                if (!StringUtil.isEmpty(orderList)) {
                    //对比订单数
                    for (Order order : orderList) {
                        boolean flag = false;
                        boolean flagca = false;
                        if(calendarL != null && !calendarL.isEmpty()&&calendarL.get(0).getType().equals("1")){
                            flag = true;
                            flagca = true;
                        } else{
                            if (isBig.indexOf(order.getIs_big() + "") > -1) {
                                flag = true;
                            }
                        }
                        if (order.getStatus() == 6) {//待接单
                            //当前团队未接订单
                            //AreaCode acode = areaService.findAreaCodeById(order.getSend_position());
                            if (flag) {
                                AreaCode acode = areaService.findAreaCodeById(order.getSend_position());
                                if (null != acode && acode.getAreaTrunk().equals(code.getAreaCode())) {
                                    if(flagca){
                                        outCount++;
                                    } else{
                                        AreaCode areacode1 = new AreaCode();
                                        areacode1.setTeamId(teamId);
                                        areacode1.setAreaCode(order.getRecip_position());
                                        AreaCode areaCode = areaService.selectIfAreaByTeamId(areacode1);
                                        if (null == areaCode) {//收货地址不在当前团队的配送范围
                                            AreaCode acode1 = areaService.findAreaCodeById(order.getRecip_position());
                                            areacode1.setAreaCode(acode1.getAreaTrunk());
                                            areaCode = areaService.selectIfAreaByTeamId(areacode1);
                                            if (null != areaCode) {//收货地址的中转点在当前团队的配送范围
                                                outCount++;
                                            }
                                        } else {
                                            outCount++;
                                        }
                                    }
                                }
                            }
                        } else if (order.getStatus() == 7) {//已接单
                            //当前团队已接订单
                            if (teamId == order.getTeam_id()) {
                                AreaCode acode = areaService.findAreaCodeById(order.getRecip_position());
                                if (acode.getAreaTrunk().equals(code.getAreaCode())
                                        && flag) {
                                    //有范围并且运输能力足够
                                    inCount++;
                                }
                            }
                        } else if (order.getStatus() == 1) {//第一次支线待接单
                            //当前团队未接订单
                            if (order.getSend_position().equals(code.getAreaCode())
                                    && flag) {
                                //有范围并且运输能力足够
                                outCount++;
                            }
                        } else if (order.getStatus() == 2) {//第一次支线已接单
                            if (teamId == order.getTeam_id()) {
                                //当前团队已接订单
                                AreaCode acode = areaService.findAreaCodeById(order.getSend_position());
                                if (acode.getAreaTrunk().equals(code.getAreaCode())
                                        && flag) {
                                    //有范围并且运输能力足够
                                    inCount++;
                                }
                            }
                        } else if (order.getStatus() == 8) {//第二次支线待接单
                            //当前团队未接订单
                            if (flag) {
                                //有范围并且运输能力足够
                                AreaCode acode = areaService.findAreaCodeById(order.getRecip_position());
                                if (null != acode && acode.getAreaTrunk().equals(code.getAreaCode())) {
                                    if(flagca){
                                        outCount++;
                                    } else{
                                        AreaCode areacode1 = new AreaCode();
                                        areacode1.setTeamId(teamId);
                                        areacode1.setAreaCode(order.getRecip_position());
                                        AreaCode areaCode = areaService.selectIfAreaByTeamId(areacode1);
                                        if (null != areaCode) {//收货地址在当前团队的配送范围
                                            outCount++;
                                        }
                                    }
                                }
                            }
                        } else if (order.getStatus() == 9) {//第二次支线已接单
                            if (teamId == order.getTeam_id()) {
                                //当前团队已接订单
                                if (order.getRecip_position().equals(code.getAreaCode())
                                        && flag) {
                                    //有范围并且运输能力足够
                                    inCount++;
                                }
                            }
                        }

                    }
                }

                code.setInCount(inCount);
                code.setOutCount(outCount);
            }

            Iterator<AreaCode> codeI = list.iterator();
            while (codeI.hasNext()) {
                //移除未使用配载点
                AreaCode code = codeI.next();
                if (code.getInCount() == 0 && code.getOutCount() == 0) {
                    codeI.remove();
                }
            }
        }
        return list;
    }

    /**
     * Description: <br>
     * 修改订单状态
     * 
     * @param status 状态
     * @param id 订单id
     * @param userId 操作人，接单时为运输团队
     * @return <br>
     */
    public Integer updateStatus(Integer status, Integer id, Integer userId, Integer uId,Integer overtime) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);

        int count = 0;
        Order order = get(id);
        if (null != order) {
            if(null == overtime){
                List<Calendar> calendarL = calendarService.selectByTimeNow();
                Calendar calendar = new Calendar();
                if(null != calendarL && calendarL.size() > 0){
                   calendar = calendarL.get(0);
                    if(calendar.getType().equals("1")) {//加班时间
                        overtime = 1;
                    }else{
                        overtime = 0;
                    }
                }else {
                    return null ;
                }
            }
            String Recip_position = order.getRecip_position();
            String send_position = order.getSend_position();
            if (status == 2 && (order.getStatus() == 1 || overtime==1)) {
                //接单
                //获取 民工 id
                Map<String,String> maps = teamRelationService.worker_list_save(user);// 获取 民工 id
                if(maps.get("id") != null ){
                    order.setBranchsend_worker_count(maps.get("count"));//送货的支线团队工作量统计
                    order.setBranchsend_worker_id(maps.get("id"));//送货的支线团队民工id
                }
                order.setDelivery_time(DateUtil.getNowDate(""));
                order.setTeam_id(userId);
                order.setSend_courier(uId);
                order.setBranchsend_id(userId);
                AreaCode areacode1 = new AreaCode();
                areacode1.setTeamId(userId);
                areacode1.setAreaCode(Recip_position);
                AreaCode areaCode = areaService.selectIfAreaByTeamId(areacode1);
                if(null != areaCode || overtime==1){//收货地址在本团队配送范围内

                    order.setStatus(9);
                    order.setBranchrecip_id(userId);
                    order.setBranchdelivery_time(DateUtil.getNowDate(""));
                } else{//到达中转点
                    order.setStatus(2);
                }
                count = update(order);
            }
            if (status == 3 && order.getStatus() == 5) {
                //完成
                order.setStatus(3);
                order.setRecip_time(DateUtil.getNowDate(""));
                count = update(order);
            }
            if (status == 4 && order.getStatus() == 1) {
                //取消
                order.setStatus(4);
                count = update(order);
            }
            if (status == 5 && order.getStatus() == 9) {
                //卸货
                order.setStatus(5);
                order.setUnloading_time(DateUtil.getNowDate(""));
                order.setRecip_courier(uId);
                count = update(order);
            }
            if (status == 6 && order.getStatus() == 2) {
                //第一次达到分拨点
                order.setStatus(6);
                order.setFirstpoint_time(DateUtil.getNowDate(""));
                count = update(order);
            }
            if (status == 7 && order.getStatus() == 6) {
                //干线接货时间
                //获取 民工 id
                Map<String,String> maps = teamRelationService.worker_list_save(user);// 获取 民工 id
                if(maps.get("id") != null ){
                    order.setTrunk_worker_id(maps.get("id"));//接货的支县团队民工id
                    order.setTrunk_worker_count(maps.get("count"));//接货的支县团队民工工作量统计
                }
                AreaCode areacode1 = new AreaCode();
                areacode1.setTeamId(userId);
                areacode1.setAreaCode(Recip_position);
                AreaCode areaCode = areaService.selectIfAreaByTeamId(areacode1);
                if(null != areaCode){//收货地址在本团队配送范围内
                    order.setStatus(9);
                    order.setTeam_id(userId);
                    order.setBranchrecip_id(userId);
                    order.setBranchdelivery_time(DateUtil.getNowDate(""));
                } else {//到达中转点
                    order.setStatus(7);
                    order.setTeam_id(userId);
                    order.setTrunk_id(String.valueOf(userId)+",");
                    order.setTrunk_courier(uId);
                    order.setTrunkdelivery_time(DateUtil.getNowDate("")+",");
                }
                count = update(order);
            }
            if (status == 8 && order.getStatus() == 7) {
                //第二次达到分拨点
                order.setStatus(8);
                order.setBranchpoint_time(DateUtil.getNowDate("")+",");
                count = update(order);
            }
            if (status == 9 && (order.getStatus() == 8 || overtime==1)) {
                //支线接货时间
                //获取 民工 id
                Map<String,String> maps = teamRelationService.worker_list_save(user);// 获取 民工 id
                if(maps.get("id") != null ){
                    order.setBranchrecip_worker_id(maps.get("id"));//接货的支县团队民工id
                    order.setBranchrecip_worker_count(maps.get("count"));//接货的支县团队民工工作量统计
                }
                order.setStatus(9);
                order.setTeam_id(userId);
                order.setBranchrecip_id(userId);
                order.setBranchdelivery_time(DateUtil.getNowDate(""));
                count = update(order);
            }
        }
        return count;
    }

    public Integer removeRequestOrder(Order order) {
        return orderMapper.removeRequestOrder(order);
    }

    public List<Order> findOrdersByuIdAndStatus(Order order) {
        return orderMapper.findOrdersByuIdAndStatus(order);
    }

    public List<Order> findOrdersByuIdAndSStatus(Order order) {
        return orderMapper.findOrdersByuIdAndSStatus(order);
    }

    public Order selectBySerialNo(String waybill_number) {
        return orderMapper.selectBySerialNo(waybill_number);
    }

    public Order getByPrimaryKey(Integer id) {
        return orderMapper.getByPrimaryKey(id);
    }

}
