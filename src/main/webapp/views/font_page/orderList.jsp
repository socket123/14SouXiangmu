<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单列表</title>
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!-- 图标 -->
		<script type="text/javascript">
		$(function(){
			initAreaCode();
			initOrders();
			initRemoveOrders(2,"#OA_task_4");
			initRemoveOrders(3,"#OA_task_5");
			initRemoveOrders(4,"#OA_task_3");
			setInterval("myInterval();",30000);//1000为1秒钟
		});
		
			function myInterval()
		    {
				initAreaCode();
				initOrders();
				initRemoveOrders(2,"#OA_task_4");
				initRemoveOrders(3,"#OA_task_5");
				initRemoveOrders(4,"#OA_task_3");
		     }
		
		function showOrderDetail(id,status){
			location.href="${url }font/orderList/findOrderDetail?role=1&id="+id+"&status="+status;
		}
		
		function deleteRequestOrder(id){
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderRequest/deleteRequestOrder",
				data:{id:id},
				success : function(result) {
					if(result.message!=0){
						mui.alert("系统消息", '删除成功');
						initRemoveOrders(4,"#OA_task_3");
					}
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败');
				}
			});
		}
		function editRequestOrder(id){
			location.href="${url }font/orderRequest/toAdd?is_edit=1&id="+id;	
		}
		
		function initRemoveOrders(status,idName){
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderRequest/showRemoveOrders",
				data:{status:status},
				success : function(result) {
					$(idName).html("");
					$(idName).append("<div class='aui-refresh-load'><div class='aui-refresh-pull-arrow'></div></div>");
					$('.aui-refresh-load').show();
					for(var i =0;i<result.length;i++){
						var daysDistanceDetail="";
						if(result[i].dayDistance==0){
							daysDistanceDetail="今天"+result[i].create_time.substring(10, 16);
						}else if(result[i].dayDistance==1){
							daysDistanceDetail="昨天"+result[i].create_time.substring(10, 16);
						}else if(result[i].dayDistance==2){
							daysDistanceDetail="前天"+result[i].create_time.substring(10, 16);
						}else if(result[i].dayDistance==3){
							daysDistanceDetail="三天前";
						}else if(result[i].dayDistance==7){
							daysDistanceDetail="一周前";
						}else if(result[i].dayDistance==15){
							daysDistanceDetail="半个月前";
						}else if(result[i].dayDistance==30){
							daysDistanceDetail="一个月前";
						}else if(result[i].dayDistance==90){
							daysDistanceDetail="三个月前";
						}
						var innerHTML="<li class='mui-table-view-cell mui-transitioning'>";
						if(status==4){
							innerHTML+="<div  class='mui-slider-right mui-disabled'><a onclick='editRequestOrder("+result[i].id+")' class='mui-btn  mui-btn-green' style='transform: translate(0, 0px); font-size: 25px;'>修改</a><a onclick='deleteRequestOrder("+result[i].id+")' class='mui-btn  mui-btn-red' style='transform: translate(0, 0px); font-size: 25px;'>删除</a></div>";	
						}
						innerHTML+="<div onclick='showOrderDetail("+result[i].id+","+result[i].status+")' class='mui-slider-handle' style='transform: translate(0px, 0px);'><div class='mui-table-cell'><div class='mui-col-xs-12'><span class='order_title mui-col-xs-2 mui-pull-left'>订单号:</span>";
						innerHTML+="<span class='order_num mui-col-xs-7 mui-pull-left'>"+result[i].waybill_number+"</span>";	
						innerHTML+="<span class='order_time mui-col-xs-3 mui-pull-left'>"+daysDistanceDetail+"</span></div><div class='mui-col-xs-12'>";		
						innerHTML+="<span class='mui-col-xs-2 mui-pull-left'></span>";
						var isBig;
						if(result[i].is_big==3){
							isBig="大件";
						}else if(result[i].is_big==2){
							isBig="中件";
						}else{
							isBig="小件";
						}
						innerHTML+="<span class='order_message mui-col-xs-8 mui-pull-left'>"+isBig+"&nbsp;&nbsp;&nbsp;&nbsp;"+result[i].send_position+"</span>"		
							if(result[i].isOverAcceptTime==1){
								innerHTML+="<span class='order_location mui-col-xs-2 mui-pull-left' style='color: red;'>异常</span></div></div></div></li>";
							}else{
								innerHTML+="<span class='order_location mui-col-xs-2 mui-pull-left'></span></div></div></div></li>";
							}	
						$(idName).append(innerHTML);
					}
					//$("#OA_task_2").append("<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id='moreButton' onclick='showMoreNewOrders()' type='button' value='---加载更多---' />");
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败');
				}
			});
		}
		
		function initAreaCode(){
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderRequest/showAllAreaCode",
				success : function(result) {
					$("#areaCode").html("");
					var innnerHTML="<option value=''>选择范围</option>";
					for(var i =0;i<result.length;i++){
						innnerHTML+="<option value='"+result[i].areaCode+"'>"+result[i].areaCode+"</option>";
					}
					$("#areaCode").append(innnerHTML);
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败');
				}
			});
		}
		
		function removeRequestOrder(id){
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderList/updateStatus",
				data:{id:id,status:4},
				success : function(result) {
					if(result.message!=0){
						mui.alert("系统消息", '取消成功');
						initOrders();
						initRemoveOrders(4,"#OA_task_3");
					}
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败');
				}
			});
		}
		
		function initOrders(){
			$("#OA_task1_Index").val(0);
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderRequest/showOrders",
				data:{status:1,rangeIndex:$("#OA_task1_Index").val(),areaCode:$("#areaCode").val()},
				success : function(result) {
					$("#OA_task_2").html("");
					$("#OA_task_2").append("<div class='aui-refresh-load'><div class='aui-refresh-pull-arrow'></div></div>");
					$('.aui-refresh-load').show();
					for(var i =0;i<result.length;i++){
						var daysDistanceDetail="";
						if(result[i].dayDistance==0){
							daysDistanceDetail="今天"+result[i].create_time.substring(10, 16);
						}else if(result[i].dayDistance==1){
							daysDistanceDetail="昨天"+result[i].create_time.substring(10, 16);
						}else if(result[i].dayDistance==2){
							daysDistanceDetail="前天"+result[i].create_time.substring(10, 16);
						}else if(result[i].dayDistance==3){
							daysDistanceDetail="三天前";
						}else if(result[i].dayDistance==7){
							daysDistanceDetail="一周前";
						}else if(result[i].dayDistance==15){
							daysDistanceDetail="半个月前";
						}else if(result[i].dayDistance==30){
							daysDistanceDetail="一个月前";
						}else if(result[i].dayDistance==90){
							daysDistanceDetail="三个月前";
						}
						var innerHTML="<li class='mui-table-view-cell mui-transitioning'>"
							+"<div class='mui-slider-right mui-disabled'>"
							+"<a onclick='removeRequestOrder("+result[i].id+")' class='mui-btn  mui-btn-red' style='transform: translate(0, 0px); font-size: 25px;'>取消</a>"
							+"</div><div onclick='showOrderDetail("+result[i].id+","+result[i].status+")' class='mui-slider-handle' style='transform: translate(0px, 0px);'>";
						innerHTML+="<div class='mui-table-cell'><div class='mui-col-xs-12'><span class='order_title mui-col-xs-2 mui-pull-left'>订单号:</span>";
						innerHTML+="<span class='order_num mui-col-xs-7 mui-pull-left'>"+result[i].waybill_number+"</span>";	
						innerHTML+="<span class='order_time mui-col-xs-3 mui-pull-left'>"+daysDistanceDetail+"</span></div><div class='mui-col-xs-12'>";		
						innerHTML+="<span class='mui-col-xs-2 mui-pull-left'></span>";
						var isBig;
						if(result[i].is_big==3){
							isBig="大件";
						}else if(result[i].is_big==2){
							isBig="中件";
						}else{
							isBig="小件";
						}
						innerHTML+="<span class='order_message mui-col-xs-8 mui-pull-left'>"+isBig+"&nbsp;&nbsp;&nbsp;&nbsp;"+result[i].send_position+"</span>";
						if(result[i].isOverDeliverTime==1){
							innerHTML+="<span class='order_location mui-col-xs-2 mui-pull-left' style='color: red;'>异常</span></div></div></div></li>";
						}else{
							innerHTML+="<span class='order_location mui-col-xs-2 mui-pull-left'></span></div></div></div></li>";
						}
						$("#OA_task_2").append(innerHTML);
					}
					//$("#OA_task_2").append("<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id='moreButton' onclick='showMoreNewOrders()' type='button' value='---加载更多---' />");
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败');
				}
			});
		}
		
		function showMoreNewOrders(){
			var showIndex = parseFloat($("#OA_task1_Index").val())+1;
			$("#OA_task1_Index").val(showIndex);
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderRequest/showOrders",
				data:{status:1,rangeIndex:$("#OA_task1_Index").val()},
				success : function(result) {
					if(result.length==0){
						mui.alert("系统消息", '没有数据了');
						return;
					}
					$("#loader").css("display","block");
					for(var i =0;i<result.length;i++){
						var innerHTML="<li class='mui-table-view-cell mui-transitioning'><div class='mui-slider-right mui-disabled'>"
						+"<a onclick='removeRequestOrder("+result[i].id+")' class='mui-btn  mui-btn-red' style='transform: translate(0, 0px); font-size: 25px;'>取消</a></div>"
						+"<div onclick='showOrderDetail("+result[i].id+","+result[i].status+")' class='mui-slider-handle' style='transform: translate(0px, 0px);'>";
						innerHTML+="<div class='mui-table-cell'><div class='mui-col-xs-12'><span class='order_title mui-col-xs-2 mui-pull-left'>订单号:</span>";
						innerHTML+="<span class='order_num mui-col-xs-7 mui-pull-left'>"+result[i].waybill_number+"</span>";	
						innerHTML+="<span class='order_time mui-col-xs-3 mui-pull-left'>"+result[i].create_time+"</span></div><div class='mui-col-xs-12'>";		
						innerHTML+="<span class='mui-col-xs-2 mui-pull-left'></span>";
						var isBig;
						if(result[i].is_big==3){
							isBig="大件";
						}else if(result[i].is_big==2){
							isBig="中件";
						}else{
							isBig="小件";
						}
						innerHTML+="<span class='order_message mui-col-xs-8 mui-pull-left'>"+isBig+"&nbsp;&nbsp;&nbsp;&nbsp;"+result[i].send_position+"</span>"		
						innerHTML+="<span class='order_location mui-col-xs-2 mui-pull-left'></span></div></div></div></li>";	
						$("#OA_task_2").append(innerHTML);
					}
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败');
				}
			});
			
			setTimeout(function(){
					$("#loader").css("display","none"); 
				},2000)
		}
		
		function searchNewOrders(){
			initOrders();
		}
		</script>
</head>
<body class="orders" style="background:#fff">
<div id="loader" class="loader375"></div>
		<header id="header" class="mui-bar mui-bar-nav">
			<h1 class="mui-title">订单列表</h1>
			<a href="${url }font/orders" class="mui-btn  mui-btn-link mui-btn-nav mui-pull-left">
				<span class="mui-icon mui-icon-left-nav"></span>返回
			</a>
		</header>
		<!-- 内容 -->
		<div class="mui-content">
			<div >
				<div id="segmentedControl" class="mui-segmented-control mui-segmented-control-inverted mui-segmented-control-primary">
					<a class="mui-control-item mui-active" href="#item1">
						新订单<b></b>
					</a>
					<a class="mui-control-item" href="#item3">
						运送中<b></b>
					</a>
					<a class="mui-control-item" href="#item4">
						已完成<b></b>
					</a>
					<a class="mui-control-item" href="#item2">
						已取消
					</a>
				</div>
			</div>
			<div>
				<div id="item1" class="mui-control-content mui-active">
					 <div class="mui-col-sm-12 mui-col-xs-12">
			            <li class="mui-table-view-cell">
			                <span class="order_title mui-col-xs-3 mui-pull-left">订单编号</span>
			                <div class="mui-col-xs-7 mui-pull-left">
			                	<select name="areaCode" id="areaCode">
			                	</select>
			                </div>
			                <span class="mui-col-xs-2 mui-pull-left">
			                <button onclick="searchNewOrders()" type="button" class="mui-btn mui-btn-royal">
								搜索
							</button>
							</span>
			            </li>
			            <input type="hidden" id="OA_task1_Index" value="0" />
			            <ul id="OA_task_2" class="mui-table-view aui-refresh-content interleave" style="margin-bottom:57px;" >
						</ul>
						<div class="boottom_btn">
							<button onclick="showMoreNewOrders()" type="button" class="mui-btn mui-btn-royal" style="width:100%;">加载更多</button>
						</div>
					</div>
			    </div>
				<div id="item2" class="mui-control-content">
					<ul id="OA_task_3" class="mui-table-view aui-refresh-content interleave" style="margin-bottom:57px;">
					</ul>
				</div>
				<div id="item3" class="mui-control-content">
				 	<ul id="OA_task_4" class="mui-table-view aui-refresh-content aui-refresh-content interleave" style="margin-bottom:57px;">
						
					</ul>
					<!-- <div class="boottom_btn">
							<button type="button" class="mui-btn mui-btn-royal mui-btn-block">全部完成</button>
						</div> -->
				</div>
				<div id="item4" class="mui-control-content">
					
					
					
					
					<ul id="OA_task_5" class="mui-table-view aui-refresh-content interleave" style="margin-bottom:57px;">
						
					</ul>
					<!-- <div class="boottom_btn">
							<button type="button" class="mui-btn mui-btn-red mui-btn-block">全部删除</button>
					</div> -->
				</div>
			</div>
		</div>
	</body>
	<script>
			$(".mui-segmented-control a").on("tap",function(){
				$(".mui-segmented-control b").each(function(){
					$(this).show();
				})
				$(this).prev().find("b").hide();
			})
			mui.init({
				swipeBack:true //启用右滑关闭功能
			});
			(function($) {
				$('#scroll').scroll({
					indicators: true //是否显示滚动条
				});
				var segmentedControl = document.getElementById('segmentedControl');
				$('.mui-input-group').on('change', 'input', function() {
					if (this.checked) {
						var styleEl = document.querySelector('input[name="style"]:checked');
						var colorEl = document.querySelector('input[name="color"]:checked');
						if (styleEl && colorEl) {
							var style = styleEl.value;
							var color = colorEl.value;
							segmentedControl.className = 'mui-segmented-control' + (style ? (' mui-segmented-control-' + style) : '') + ' mui-segmented-control-' + color;
						}
					}
				});
			})(mui);
			var pullRefresh = new auiPullToRefresh({
				container: document.querySelector('.aui-refresh-content'),
					triggerDistance: 100
				},function(ret){
					if(ret.status=="success"){
						initOrders();
						setTimeout(function(){
							pullRefresh.cancelLoading(); //刷新成功后调用此方法隐藏
						},1500)
					}
				})
		</script>
</html>