package com.vrv.mapper;

import java.util.List;
import java.util.Map;

import com.vrv.entity.Order;

public interface OrderMapper extends BaseDao<Order> {

    public List<Order> findOrderByPage(Order order);

    public List<Order> findOrderBypage(Order order);

    public Integer addOrder(Order order);

    /**
     * Description: <br>
     * 查询订单
     * 
     * @return <br>
     */
    public List<Order> findMapOrders(Map<String, Object> map);

    // 取消订单
    public Integer updateOrderStatusById(Order order);

    public Integer updateOrderByNum(Order order);

    public Integer removeRequestOrder(Order order);

    // 查看订单详情
    public Order findOrderDetailById(Integer id);

    // 查询所有订单
    public List<Order> findOrderList(Order order);

    public List<Order> findOrdersByuIdAndStatus(Order order);

    public List<Order> findOrdersByuIdAndSStatus(Order order);

    public Order getByPrimaryKey(Integer id);

    public Order selectBySerialNo(String waybill_number);

    public List<Order> findOrderAnalysis(String startTime);

}
