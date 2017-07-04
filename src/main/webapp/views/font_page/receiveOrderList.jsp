<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的订单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<script type="text/javascript">
		$(function(){
			initUnFinishedOrders();
			initFinishedOrders();
			setInterval("myInterval();",30000);//1000为1秒钟
		});
		
		function myInterval(){
			initUnFinishedOrders();
			initFinishedOrders();
		}
		
		function showOrderDetail(id,status){
			location.href="${url }font/orderList/findOrderDetail?role=2&id="+id+"&status="+status;
		}
		
		function reciveOrder(id){
			mui.confirm('是否确认收货？', '系统消息', null, function(e) {
                if(e.index == 1){
                	$.ajax({
        				cache : false,
        				async : false,
        				type : "POST",
        				url :  "${url }font/orderRequest/updateStatus",
        				data:{id:id,status:3},
        				success : function(result) {
        					if(result.message!=0){
        						mui.alert("系统消息", '确认收货成功');

//        						initUnFinishedOrders();
//        						initFinishedOrders();
        					}
        				},
        				error : function(request) {
        					mui.alert("系统消息", '操作失败');
        				}
        			});
                }
            })
		}
		
		function initUnFinishedOrders(){
			$("#OA_task1_Index").val(0);
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderRequest/showMyReciveOrders",
				data:{status:2,rangeIndex:$("#OA_task1_Index").val()},
				success : function(result) {
					$("#OA_task_2").html("");
					$("#OA_task_2").append("<div class='aui-refresh-load'><div class='aui-refresh-pull-arrow'></div></div>");
					$('.aui-refresh-load').show();
					for(var i =0;i<result.length;i++){
						var innerHTML="<li class='mui-table-view-cell mui-transitioning'>";
						if(result[i].status==2){
							innerHTML+="<div class='mui-slider-right mui-disabled'><a onclick='reciveOrder("+result[i].id+")' class='mui-btn  mui-btn-red' style='transform: translate(0, 0px); font-size: 25px;'>确认收货</a></div>";	
						}
						innerHTML+="<div onclick='showOrderDetail("+result[i].id+","+result[i].status+")' class='mui-slider-handle' style='transform: translate(0px, 0px);'><div class='mui-table-cell'><div class='mui-col-xs-12'><span class='order_title mui-col-xs-2 mui-pull-left'>订单号:</span>";
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
				url :  "${url }font/orderRequest/showMyReciveOrders",
				data:{status:2,rangeIndex:$("#OA_task1_Index").val()},
				success : function(result) {
					if(result.length==0){
						mui.alert("系统消息", '没有数据了');
						return;
					}
					$("#loader").css("display","block");
					for(var i =0;i<result.length;i++){
						var innerHTML="<li class='mui-table-view-cell mui-transitioning'><div class='mui-slider-right mui-disabled'><a onclick='reciveOrder("+result[i].id+")' class='mui-btn  mui-btn-red' style='transform: translate(0, 0px); font-size: 25px;'>确认收货</a></div><div onclick='showOrderDetail("+result[i].id+","+result[i].status+")' class='mui-slider-handle' style='transform: translate(0px, 0px);'>";
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
		
		
		function initFinishedOrders(){
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderRequest/showMyFinishReciveOrders",
				data:{status:3},
				success : function(result) {
					$("#OA_task_3").html("");
					//$("#OA_task_3").append("<div class='aui-refresh-load'><div class='aui-refresh-pull-arrow'></div></div>");
					$('.aui-refresh-load').show();
					for(var i =0;i<result.length;i++){
						var innerHTML="<li class='mui-table-view-cell mui-transitioning'>";
						innerHTML+="<div onclick='showOrderDetail("+result[i].id+","+result[i].status+")' class='mui-slider-handle' style='transform: translate(0px, 0px);'><div class='mui-table-cell'><div class='mui-col-xs-12'><span class='order_title mui-col-xs-2 mui-pull-left'>订单号:</span>";
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
						$("#OA_task_3").append(innerHTML);
					}
					//$("#OA_task_2").append("<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id='moreButton' onclick='showMoreNewOrders()' type='button' value='---加载更多---' />");
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败');
				}
			});
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
					未完成
					</a>
					<a class="mui-control-item" href="#item2">
						已完成
					</a>
				</div>
			</div>
			<div>
				<div id="item1" class="mui-control-content mui-active">
					 <div class="mui-col-sm-12 mui-col-xs-12">
			            <input type="hidden" id="OA_task1_Index" value="0" />
			            <ul id="OA_task_2" class="mui-table-view aui-refresh-content interleave" style="margin-bottom:57px;" >
						</ul>
						<div class="boottom_btn">
							<button onclick="showMoreNewOrders()" type="button" class="mui-btn mui-btn-royal mui-btn-block">加载更多</button>
						</div>
					</div>
			    </div>
				<div id="item2" class="mui-control-content">
					<ul id="OA_task_3" class="mui-table-view aui-refresh-content interleave" style="margin-bottom:57px;">
					</ul>
				</div>
			</div>
		</div>
	</body>
	<script>
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
						initUnFinishedOrders();
						setTimeout(function(){
							pullRefresh.cancelLoading(); //刷新成功后调用此方法隐藏
						},1500)
					}
				})
		</script>
</html>