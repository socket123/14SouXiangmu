<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${empty(orderList) }">
	<li class='mui-table-view-cell mui-transitioning' style="color: #cccccc;">没有已完成的订单</li>
</c:if>
<c:forEach items="${orderList }" var="list">
	<li class='mui-table-view-cell mui-transitioning' onclick="toInfo('${list.id }','${list.status }')">
		<div class='mui-slider-handle' style='transform: translate(0px, 0px);'>
			<div class='mui-table-cell'><div class='mui-col-xs-12'>
				<span class='order_title mui-col-xs-2 mui-pull-left'>订单号:</span>
				<span class='order_num mui-col-xs-6 mui-pull-left'>${list.waybill_number }</span>	
				<span class='order_time mui-col-xs-4 mui-pull-left'>${fn:substring(list.create_time,0,16) }</span>
			</div>
			<div class='mui-col-xs-12'>
				<span class='mui-col-xs-2 mui-pull-left'>
					<c:if test="${list.is_big == 3}">大件</c:if>
					<c:if test="${list.is_big == 2}">中件</c:if>
					<c:if test="${list.is_big == 1}">小件</c:if>
				</span>
				<span class='order_message mui-col-xs-8 mui-pull-left'>
					${list.send_position} - ${list.recip_position}
				</span>		
				<span class='order_location mui-col-xs-2 mui-pull-left'>
					<c:if test="${list.status == 5}">已卸货</c:if>
					<c:if test="${list.status == 3}">已完成</c:if>
				</span>
			</div>
		</div>
	</li>
</c:forEach>
<script>
function toInfo(id,status){
	location.href = path+"font/orderList/findOrderDetail?role=3&id="+id+"&status="+status;
}
</script>