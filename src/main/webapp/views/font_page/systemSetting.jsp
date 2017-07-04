<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设置</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<style type="text/css">
			.fonter-back{
				position: fixed;
				bottom: 35px;
				width: 100%;
			}
		</style>
		<script type="text/javascript">
		$(function(){
			if($("#is_open").val()==1){
				//$("#switchDiv").removeClass("mui-active");
				$("#switchDiv").addClass("mui-active");
			}else{
				$("#switchDiv").removeClass("mui-active");
			}
		});
		
		function goBack(){
			window.history.go(-1);
		}
		</script>
</head>
<body>

		<header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">设置</h1>
			<input type="hidden" id="is_open" value="${user.isOpen }" />
		</header>
		<div class="mui-content">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<span></span>
					<div id="switchDiv" class="mui-switch">
						<div class="mui-switch-handle"></div>
					</div>
				</li>
			</ul>
			<br>
			<ul class="mui-table-view fonter-back" >
				<li class="mui-table-view-cell mui-text-center">
					<span onclick="goBack()">退出</span>
				</li>
			</ul>

		</div>
		<script>
			mui.init({
				swipeBack:false //启用右滑关闭功能
			});
			mui('.mui-content .mui-switch').each(function() { //循环所有toggle
				//toggle.classList.contains('mui-active') 可识别该toggle的开关状态
				this.parentNode.querySelector('span').innerText = '是否开启短信提醒：';
				/**
				 * toggle 事件监听
				 */
				this.addEventListener('toggle', function(event) {
					var isOpen=0;
					if(this.classList.contains('mui-active')){
						isOpen=1;
					}
					$.ajax({
						cache : false,
						async : false,
						type : "POST",
						url :  "${url }font/switchIsOpen",
						data:{isOpen:isOpen},
						success : function(result) {
							if(result.message!=0){
								
							}
						},
						error : function(request) {
							messagerShow("系统消息", '操作失败!!!');
						}
					});
					//event.detail.isActive 可直接获取当前状态
					//this.parentNode.querySelector('span').innerText = '状态：' + (event.detail.isActive ? 'true' : 'false');
				});
			});
		</script>
	</body>
</html>