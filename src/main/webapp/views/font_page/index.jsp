<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<script type="text/javascript">
	function toMyOrders(){
		window.location.href="${url }font/orders";
	}
	
	function toDistribution(){
		$.post("${url}font/orders/roleSelection",{},function(data){
			if(data.msg == "success"){
				window.location.href="${url }font/orders/indexAcceptOrders";
			}else{
				mui.toast(data.msg);
			}
		});
	}

	function closeWindow(){
		 vrv.jssdk.closeView({});
	}
</script>
</head>
<body class="orders" style="background:#fff">
		<header id="header" class="mui-bar mui-bar-nav">
			<a class="mui-icon mui-icon-left-nav mui-pull-left" onclick="closeWindow()" >&nbsp;&nbsp;</a>
			<h1 class="mui-title">选择身份</h1>
		<!-- <button class="mui-action-back mui-btn  mui-btn-link mui-btn-nav mui-pull-left"><span class="mui-icon mui-icon-left-nav"></span>返回</button> --></header>
		<div class="mui-content">
				<button onclick="toMyOrders()" class="menu menu-first mui-btn mui-btn-block mui-btn-success" >
					<span class="menu_icon"></span>
						<b>收/寄快递</b>
					<span class="aspect"></span>
				</button>
				<button onclick="toDistribution()" class="menu menu-second mui-btn mui-btn-block mui-btn-warning" >
					<span class="menu_icon"></span>
						<b>配送快递</b>
					<span class="aspect"></span>
				</button>
		</div>
	</body>
	<style>
	

	</style>
</html>