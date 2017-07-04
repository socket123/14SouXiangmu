<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的详情</title>
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
</head>
<script type="text/javascript">
function closeWindow(){
	 vrv.jssdk.closeView({});
}
</script>
<body>
<header id="header" class="mui-bar mui-bar-nav">
		<a class="mui-icon mui-icon-left-nav mui-pull-left" onclick="closeWindow()" ></a>
		<h1 class="mui-title">我的订单</h1>
</header>

	<body class="background-white">
		<div class="mui-content background-white">
		        <ul class="mui-table-view mui-grid-view mui-grid-9 border_none">
		            <li class="mui-table-view-cell mui-media mui-col-xs-6 mui-col-sm-6"><a href="${url }font/orderRequest/toAdd?is_edit=0">
		                    <span class="fa fa-edit color1"></span>
		                    <div class="mui-media-body">订单申请</div></a></li>
		            <li class="mui-table-view-cell mui-media mui-col-xs-6 mui-col-sm-6"><a href="${url }font/orders/myReceiveOrders">
		                    <span class="fa fa-check-square-o color1"><span class="mui-badge">${newOrderCount }</span></span>
		                    <div class="mui-media-body">收包裹</div></a></li>
		            <li class="mui-table-view-cell mui-media mui-col-xs-6 mui-col-sm-6 border_nobottom"><a href="${url }font/orderList/index">
		                    <span class="fa fa-send color2 "></span>
		                    <div class="mui-media-body">我的订单</div></a></li>
		            <li class="mui-table-view-cell mui-media mui-col-xs-6 mui-col-sm-6 border_nobottom"><a href="${url }font/systemSetting">
		                    <span class="fa fa-cog color3"></span>
		                    <div class="mui-media-body">设置</div></a></li>
		        </ul> 
		</div>
		<div class="mui-padd-10" style="margin-top:15px;">
			<p class="mui-text-center">相关说明</p>
			<p>1.配送员只接本园区的物料配送</p>
			<p>2.请配送工作单位的物料，私人物料请联系社会物流公司。</p>
			<p>3.如有问题请联系物流管理员</p>
		</div>
		<div class="footer">
			<h5 class="mui-text-center font_16">中国电子集团第十四所研究所</h5>
			<h5 class="mui-text-center">Copyright 江苏神州信源系统有限工程公司</h5>
		</div>
	</body>
</body>
</html>