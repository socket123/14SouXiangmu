<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<title>智慧物配 - 登录</title>
	<%@ include file="../common_resource.jsp" %>
	<style type="text/css">
		.masking{
			position: fixed;
			top: 0;
			left: 0;
			z-index: 9999;
			width: 100%;
			height: 100%;
			text-align: center;
			background: rgba(0,0,0,.7);
		}
		.masking img{
			margin-top: 35%;
		}
	</style>
</head>
<body class="background-white">
	<header id="header" class="mui-bar mui-bar-nav">
		<a class="mui-icon mui-icon-left-nav mui-pull-left" id="closeWindow">&nbsp;&nbsp;</a>
		<h1 class="mui-title" id="closeWindow">登录</h1>
</header>  
	<div class="mui-content background-white">
		<img id="img1" src="${url }statics/font_css/images/bg_top.png" style="width: 100%">
		<div style="margin:35px 15px;"> 
			<form class="login-from">
					<div class="login-input">
						<div class="login-title"></div>
						<input type="text" name="userid" id="userid" class="" placeholder="请输入工号" value="">
					</div>
					<div class="login-input">
						<div class="login-title"></div>
						<input type="password" name="password" id="password" class="" placeholder="请输入密码" value="">
					</div>
					<div class="login-input border_none">
						<div class="login-title">选择角色</div>
						<label style="line-height: 40px;">
							<input type="radio" name="role" value="1" style="height: 20px;"/>
							<span></span>普通用户
							
						</label>
						<span>
						<label style="line-height: 40px;">
							<input type="radio" name="role" value="2" style="height: 20px;"/>
							<span></span>运输团队
						</label>
						</span>
					</div>
					<div class="mui-btn mui-btn-primary mui-btn-block" id="comfirm">登录</div>
			</form>

		</div>
	</div>
	
	<%--<div class="masking">
		<img src="${url }statics/font_css/images/logining.gif">
	</div>--%>
</body>
<%--<script src="http://wechatfe.github.io/vconsole/lib/vconsole.min.js?v=2.5.2"></script>--%>
<script type="text/javascript">
vrv.ready(function(){
	vrv.jssdk.getAccountInfo({
	    success: function (res) {
	    	$.post("${url}login2",{userid:res.extend.f1d8d9b8088e4be5b9ed6914ad6b7ee6,ddId:res.mUserId},function(data){
	    		if(data.code > 0){
	    			if(data.isTeam == 0){
	    				location.href="${url }font/orders";
	    			}else{
	    				location.href="${url }font/toChoiceRole";
	    			}
	    		}else{
	    			mui.alert("该工号尚未在本系统绑定，请联系管理员",function(){
	    				vrv.jssdk.closeView({});
	    			});
	    		}
	    	});
	    }
	});
}); 
	$(".masking").hide();

$("#closeWindow").on("click",function(){
	 vrv.jssdk.closeView({});
});


$("#comfirm").on("click",function(){
	var userid = $("#userid").val();
	var password = $("#password").val();
	var role = $("input[name='role']:checked").val();
	if(!password || !userid){
		mui.toast("工号或密码不能为空"); return;
	}
	if(!role){
		mui.toast("请选择角色"); return;
	}
	$.post("${url}userlogin",{userid:userid,password:password,type:role},function(data){
		if(data.code > 0){
			if(role == 1){
				location.href="${url }font/orders";
			}else{
				location.href="${url }font/orders/indexAcceptOrders";
			} 
		}else{
			mui.toast("工号或密码错误"); return;
		}
	});
});
</script>
</html>