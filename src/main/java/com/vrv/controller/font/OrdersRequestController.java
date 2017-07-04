package com.vrv.controller.font;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vrv.contans.MyConfig;
import com.vrv.entity.AreaCode;
import com.vrv.entity.Order;
import com.vrv.entity.SSUser;
import com.vrv.entity.SysConfig;
import com.vrv.service.impl.AreaCodeService;
import com.vrv.service.impl.OrderServiceImpl;
import com.vrv.service.impl.SystemConfigServiceImpl;
import com.vrv.service.impl.UserService;
import com.vrv.utils.AdminUtil;
import com.vrv.utils.DateUtil;
import common.CommonMethod;

@Controller
@RequestMapping("font/orderRequest")
public class OrdersRequestController {

    @Autowired
    OrderServiceImpl orderService;

    @Autowired
    SendMsgController sendMsgController;

    @Autowired
    UserService userService;

    @Autowired
    AreaCodeService areaCodeService;

    @Autowired
    SystemConfigServiceImpl systemConfigService;

    @RequestMapping(value = "/toAdd")
    public String indexOrders(HttpServletRequest request, HttpServletResponse response,
            Integer is_edit, Integer id, Integer flag) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        Order order = null;
        if (is_edit == 1) {
            order = orderService.get(id);
        }
        request.setAttribute("user", user);
        request.setAttribute("is_edit", is_edit);
        request.setAttribute("order", order);
        request.setAttribute("flag", flag);
        return "font_page/orders";
    }

    @RequestMapping(value = "addOrder", produces = "application/json;charset=UTF-8")
    public @ResponseBody Map<String, Object> addOrder(HttpServletRequest request, Order order) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", "0");
        try {
            Integer i = 0;
            SSUser sendUser = userService.findByUser(order.getSend_user());
            if (null == sendUser) {
                map.put("msg", "发货人工号尚未导入");
                return map;
            }
            order.setSend_user_id(sendUser.getId());
            SSUser reciveUser = userService.findByUser(order.getRecip_user());
            if (null == reciveUser) {
                map.put("msg", "接收人工号尚未导入");
                return map;
            }
            order.setRecip_user_id(reciveUser.getId());
            AreaCode sendArea = areaCodeService.findAreaCodeById(order.getSend_position());
            if (null == sendArea) {
                map.put("msg", "发货地址编码尚未导入");
                return map;
            }
            if (sendArea.getAreaOut().indexOf("1") < 0) {
                map.put("msg", "发货地址不符合出入库标准");
                return map;
            }
            if (sendArea.getIsEnable() == 0) {
                map.put("msg", "发货地址未启用");
                return map;
            }
            AreaCode reciveArea = areaCodeService.findAreaCodeById(order.getRecip_position());
            if (null == reciveArea) {
                map.put("msg", "收货地址编码尚未导入");
                return map;
            }
            if (reciveArea.getAreaOut().indexOf("2") < 0) {
                map.put("msg", "收货地址不符合出入库标准");
                return map;
            }
            if (reciveArea.getIsEnable() == 0) {
                map.put("msg", "收货地址未启用");
                return map;
            }
            int count = areaCodeService.findAreaByCode(order.getSend_position());
            int count2 = areaCodeService.findAreaByCode(order.getSend_position());
            if (count > 1 || count2 > 1) {
                i = 11;
            } else {
                order.setCreate_time(DateUtil.getNowDate(""));
                i = orderService.addOrder(order);
                if (i > 0) {
                    //发送消息给团队
                    order.setStatus(1);
                    sendMsgController.sendMsg(request, order, null);
                }
            }
            map.put("message", i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "editOrder", produces = "application/json;charset=UTF-8")
    public @ResponseBody Map<String, Object> editOrder(HttpServletRequest request,
            HttpServletResponse response, Order order) {
        Map<String, Object> map = new HashMap<String, Object>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        map.put("message", "0");
        if (order.getSend_user_id() == null || "".equals(order.getSend_user_id())) {
            Integer send_user_id = user.getId();
            order.setSend_user_id(send_user_id);
        }
        order.setCreate_time(sdf.format(new Date()));
        try {
            Integer i = orderService.update(order);
            map.put("message", i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "checkPositionIsExist", produces = "application/json;charset=UTF-8")
    public @ResponseBody Map<String, Object> checkPositionIsExist(HttpServletRequest request,
            HttpServletResponse response, String area_code) {
        AreaCode areaCode = new AreaCode();
        areaCode.setAreaCode(area_code);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", "0");
        try {
            AreaCode area = areaCodeService.findAreaCodeById(area_code);
            int i = 0;
            if (null != area) {
                map.put("out", area.getAreaOut());
                map.put("is_enable", area.getIsEnable());
                i++;
            }
            map.put("message", i);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "showAllAreaCode", produces = "application/json;charset=UTF-8")
    public @ResponseBody List<AreaCode> showAllAreaCode(HttpServletRequest request,
            HttpServletResponse response) {
        AreaCode areaCode = new AreaCode();
        List<AreaCode> areaCodes = null;
        try {
            areaCodes = areaCodeService.findAreaCodeByPage(areaCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return areaCodes;
    }

    @RequestMapping(value = "showOrders", produces = "application/json;charset=UTF-8")
    public @ResponseBody List<Order> showOrders(HttpServletRequest request,
            HttpServletResponse response, Integer status, Integer rangeIndex, String areaCode) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        Order order = new Order();
        SysConfig systemConfig = systemConfigService.findSystemConfig();
        order.setStatus(status);
        order.setStartIndex(rangeIndex * 10);
        order.setEndIndex((rangeIndex + 1) * 10 - 1);
        order.setSend_position(areaCode);
        if (user != null) {
            order.setSend_user_id(user.getId());
        }
        List<Order> orders = null;
        try {
            orders = orderService.findOrderByPage(order);
            int dayOfWeek = CommonMethod.dayForWeek(sdf.format(new Date()));
            for (Order orderObj : orders) {
                orderObj.setDayDistance(CommonMethod.getTimeDistanceBeforeToday(orderObj
                        .getCreate_time()));
                if (systemConfig.getTimeset().contains(dayOfWeek + "")) {
                    if (status == 1) {
                        if (DateUtil.getBetweenMinuts(new Date(),
                                sdf.parse(orderObj.getCreate_time())) > systemConfig
                                .getDeliveryTimeout()) {
                            orderObj.setIsOverDeliverTime(1);
                        } else {
                            orderObj.setIsOverDeliverTime(0);
                        }
                    } else if (status == 2) {
                        if (DateUtil.getBetweenMinuts(new Date(),
                                sdf.parse(orderObj.getDelivery_time())) > systemConfig
                                .getReceivTimeout()) {
                            orderObj.setIsOverAcceptTime(1);
                        } else {
                            orderObj.setIsOverAcceptTime(0);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @RequestMapping(value = "showMyReciveOrders", produces = "application/json;charset=UTF-8")
    public @ResponseBody List<Order> showMyReciveOrders(HttpServletRequest request,
            HttpServletResponse response, Integer status, Integer rangeIndex) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        Order order = new Order();
        order.setStatus(status);
        order.setStartIndex(rangeIndex * 10);
        order.setEndIndex((rangeIndex + 1) * 10 - 1);
        order.setRecip_user_id(user.getId());
        List<Order> orders = null;
        try {
            orders = orderService.findOrderBypage(order);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @RequestMapping(value = "showRemoveOrders", produces = "application/json;charset=UTF-8")
    public @ResponseBody List<Order> showRemoveOrders(HttpServletRequest request,
            HttpServletResponse response, Integer status) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SysConfig systemConfig = systemConfigService.findSystemConfig();
        List<Order> orders = null;
        try {
            String statusquery = "status=" + status;
            if (status == 3 || status == 5) {
                statusquery = "(`status` = 3 OR `status` = 5)";
            }
            orders = orderService.findMapOrders(statusquery, "send_user_id = " + user.getId());
            for (Order orderObj : orders) {
                if (orderObj.getCreate_time() != null && !"".equals(orderObj.getCreate_time())) {
                    orderObj.setDayDistance(CommonMethod.getTimeDistanceBeforeToday(orderObj
                            .getCreate_time()));
                }
                if (status == 2) {
                    if (DateUtil.getBetweenMinuts(new Date(),
                            sdf.parse(orderObj.getDelivery_time())) > systemConfig
                            .getReceivTimeout()) {
                        orderObj.setIsOverAcceptTime(1);
                    } else {
                        orderObj.setIsOverAcceptTime(0);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @RequestMapping(value = "showMyFinishReciveOrders", produces = "application/json;charset=UTF-8")
    public @ResponseBody List<Order> showMyFinishReciveOrders(HttpServletRequest request,
            HttpServletResponse response, Integer status) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        List<Order> orders = null;
        try {
            orders = orderService.findMapOrders("(`status` = 3 OR `status` = 5)", "recip_user_id="
                    + user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @RequestMapping(value = "deleteRequestOrder", produces = "application/json;charset=UTF-8")
    public @ResponseBody Map<String, Object> deleteRequestOrder(HttpServletRequest request,
            HttpServletResponse response, Integer id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", "0");
        try {
            map.put("message", orderService.delete(id));
        } catch (Exception e) {
            // TODO: handle exception
        }
        return map;
    }

    @RequestMapping(value = "findByUser", produces = "application/json;charset=UTF-8")
    public @ResponseBody SSUser findByUser(HttpServletRequest request,
            HttpServletResponse response, String jobNum) {
        SSUser user = null;
        try {
            user = userService.findByUser(jobNum);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
