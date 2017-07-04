<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>订单列表</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<script type="text/javascript">
		$(function(){
			
		});
		
		function showOrderDetail(id,status){
			location.href="${url }font/orderList/findOrderDetail?id="+id+"&status="+status;
		}
		</script>
</head>
<body style="background:#fff">
		<header id="header" class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">订单列表</h1>
		<!-- <a class="mui-icon mui-icon-syswhite mui-pull-right"></a> --></header>
		<!-- 内容 -->
		<div class="mui-content background-white">
			<div class="distribution-title distribution-list" >
				&nbsp;${send_position }<b  class="">(<span id="newCountId">${outCount }</span>)</b>
			</div>
			<ul  class="mui-table-view" style="">
			<c:forEach items="${orders }" var="order">
					<li class="mui-table-view-cell mui-transitioning" onclick="showOrderDetail(${order.id },${order.status })">
						<%-- <div class="mui-slider-right mui-disabled">
							<a onclick="accpetThisOrder(${order.id })" class="mui-btn  " style="transform: translate(0px, 0px);background:#f2914a;">接单</a>
						
						</div> --%>
						<div class="mui-slider-handle" style="transform: translate(0px, 0px);">
							<div class="mui-table-cell">
								<div class="mui-col-xs-12 clearfix">
									<span class="order_title mui-col-xs-2 mui-pull-left">订单号:</span>
									<span class="order_num mui-col-xs-6 mui-pull-left">${order.waybill_number }</span>
									<span class="order_time mui-col-xs-4 mui-pull-left">${fn:substring(order.create_time, 0, 10) }</span>
								</div>
								<div class="mui-col-xs-12 clearfix" style="margin-top:5px;">
									<span class="mui-col-xs-2 mui-pull-left"></span>
									<span class="distribution-person mui-col-xs-6 mui-pull-left">&nbsp;&nbsp;${order.send_position } <span>${order.send_user }</span></span>
									<span class="distribution-phone mui-col-xs-4 mui-pull-left">${order.send_phone }</span>
								</div>
							</div>
						</div>
					</li>
			</c:forEach>
					
					<!-- <li class="mui-table-view-cell mui-transitioning">
						<div class="mui-slider-right mui-disabled">
							<a class="mui-btn  " style="transform: translate(0px, 0px);background:#f2914a;">完成</a>
						
						</div>
						<div class="mui-slider-handle" style="transform: translate(0px, 0px);">
							<div class="mui-table-cell">
								<div class="mui-col-xs-12 clearfix">
									<span class="order_title mui-col-xs-2 mui-pull-left">订单号:</span>
									<span class="order_num mui-col-xs-7 mui-pull-left">NG7777777749IO</span>
									<span class="order_time mui-col-xs-3 mui-pull-left">13:30  今天</span>
								</div>
								<div class="mui-col-xs-12 clearfix" style="margin-top:5px;">
									<span class="mui-col-xs-2 mui-pull-left"></span>
									<span class="distribution-person mui-col-xs-7 mui-pull-left">&nbsp;&nbsp;A2010332 <span>张小小</span></span>
									<span class="distribution-phone mui-col-xs-3 mui-pull-left">1391045920</span>
								</div>
							</div>
						</div>
					</li>
					<li class="mui-table-view-cell mui-transitioning">
						<div class="mui-slider-right mui-disabled">
							<a class="mui-btn  " style="transform: translate(0px, 0px);background:#f2914a;">完成</a>
						
						</div>
						<div class="mui-slider-handle" style="transform: translate(0px, 0px);">
							<div class="mui-table-cell">
								<div class="mui-col-xs-12 clearfix">
									<span class="order_title mui-col-xs-2 mui-pull-left">订单号:</span>
									<span class="order_num mui-col-xs-7 mui-pull-left">NG7777777749IO</span>
									<span class="order_time mui-col-xs-3 mui-pull-left">13:30  今天</span>
								</div>
								<div class="mui-col-xs-12 clearfix" style="margin-top:5px;">
									<span class="mui-col-xs-2 mui-pull-left"></span>
									<span class="distribution-person mui-col-xs-7 mui-pull-left">&nbsp;&nbsp;A2010332 <span>张小小</span></span>
									<span class="distribution-phone mui-col-xs-3 mui-pull-left">1391045920</span>
								</div>
							</div>
						</div>
					</li>
					<li class="mui-table-view-cell mui-transitioning">
						<div class="mui-slider-right mui-disabled">
							<a class="mui-btn  " style="transform: translate(0px, 0px);background:#f2914a;">完成</a>
						
						</div>
						<div class="mui-slider-handle" style="transform: translate(0px, 0px);">
							<div class="mui-table-cell">
								<div class="mui-col-xs-12 clearfix">
									<span class="order_title mui-col-xs-2 mui-pull-left">订单号:</span>
									<span class="order_num mui-col-xs-7 mui-pull-left">NG7777777749IO</span>
									<span class="order_time mui-col-xs-3 mui-pull-left">13:30  今天</span>
								</div>
								<div class="mui-col-xs-12 clearfix" style="margin-top:5px;">
									<span class="mui-col-xs-2 mui-pull-left"></span>
									<span class="distribution-person mui-col-xs-7 mui-pull-left">&nbsp;&nbsp;A2010332 <span>张小小</span></span>
									<span class="distribution-phone mui-col-xs-3 mui-pull-left">1391045920</span>
								</div>
							</div>
						</div>
					</li> -->
				</ul>
		</div>
	</body>
</html>