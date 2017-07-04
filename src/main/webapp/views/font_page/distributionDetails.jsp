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
	<style type="text/css">
		.model{
			position: fixed;
			top:0;
			right: 0;
			bottom: 0;
			left:0;
		}
		.model .model-content{
			position: absolute;
			top:50%;
			width: 100%;
			height:170px;
			margin-top: -100px;
			background: #fff;
			-moz-box-shadow: 1px 1px 5px #888888; /* 老的 Firefox */
			box-shadow: 1px 1px 5px #888888;
			padding: 20px;
		}
		.model from{
			position: relative;
			z-index: 999;
		}

		#saoyisao{
			height: 32px;
			line-height: 32px;
		}
	</style>
		<script type="text/javascript">
		$(function(){

		});

		function accpetThisOrder(id,status,is_big,send_user_id){
			if($("#loginUserId").val()==send_user_id){
				mui.toast("不能接单自己申请的物品单");
				return;
			}
			$.ajax({
				cache : false,
				async : false,
				type : "POST",
				url :  "${url }font/orderList/selectTransportTeamByUserId",
				success : function(result) {
					if(result){
						if(result.isEnable!=1){
							mui.toast("你的运输团队未启用");
							return;
						}else if(result.ability.indexOf(is_big)<0){
							mui.toast("你的运输能力不包含此物类型");
							return;
						}else{
							$.ajax({
								cache : false,
								async : false,
								type : "POST",
								url :  "${url }font/orderList/updateStatus",
								data:{id:id,status:status},
								success : function(resultObj) {
									mui.alert("操作成功",function(){
										location.href="${url }font/orders/indexAcceptOrders";										
									});
									//$("#newCountId").html(parseFloat($("#newCountId").html())-1);
								},
								error : function(request) {
									mui.alert("系统消息", '操作失败!!!');
								}
							});
						}
					}
				},
				error : function(request) {
					mui.alert("系统消息", '操作失败!!!');
				}
			});
		}
		
		function showOrderDetail(id,status){
			location.href="${url }font/orderList/findOrderDetail?id="+id+"&role=3&status="+status;
		}

		var orderid="";
		function saomiao(){
			vrv.jssdk.getInfoWithSweep({       
			       success: function (res) {
			    	   var position = $("#send_position").text();
                       var smcode = (JSON.stringify(res.sweepKey));
                       smcode = eval("("+eval("("+smcode+")")+")");
						if(typeof(smcode.serialNo)=="undefined"&&typeof(smcode.carryoutcode)!="undefined"){//扫描的是载具
                            var carryoutCode = smcode.carryoutcode;
                            $.ajax({
                                cache : false,
                                async : false,
                                type : "POST",
                                url :  "${url }font/orderList/updateCarryOut",
                                data:{id:orderid,carryoutCode:carryoutCode,position:position},
                                success : function(resultObj) {
                                    if(typeof(resultObj.mess)!="undefined"){
                                        mui.alert(resultObj.mess);
                                    } else{
                                        if(resultObj.messageForCarry==1&&resultObj.message==1){
                                            mui.toast("载具操作成功");
                                            location.reload();
                                        } else if(resultObj.messageForCarry==0&&resultObj.message==1){
                                            mui.alert("载具编码不存在");
                                        } else{
                                            mui.alert("系统消息", '操作失败!!!');
                                        }
                                    }
                                },
                                error : function(request) {
                                    mui.alert("系统消息", '操作失败!!!');
                                }
                            });
						} else if(typeof(smcode.serialNo)!="undefined"&&typeof(smcode.carryoutcode)=="undefined"){//扫描的是订单
                            $.post("${url }font/orderList/findOrderDetailByJsonStr",{jsonStr:res.sweepKey,position:position},function(data){
                                if(data.msg != 'success'){
                                    mui.alert(data.msg);
                                }else{
                                    mui.toast('您的运单号：'+data.order.waybill_number+"操作成功！");
                                    orderid = data.order.id;
                                    location.reload();
                                }
                            });
						}
			       }
			   });
		}
		</script>
</head>
<body style="background:#fff">
		<header id="header" class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title" id="send_position">${send_position }</h1>
			<a onclick="saomiao()" class="mui-icon mui-icon-syswhite mui-pull-right"></a>
		</header>
		<!-- 内容 -->
		<input type="hidden" id="loginUserId" value="${user.id }" />
		<div class="mui-content background-white">
			<div class="distribution-title distribution-list" >
				<b>待揽件(
					<c:if test="${empty(orders) }">0</c:if>
					<c:if test="${!empty(orders) }">${fn:length(orders)}</c:if>
				)</b>
			</div>
			<ul class="mui-table-view interleave before-none" style="">
			<c:forEach items="${orders }" var="order">
				<li class="mui-table-view-cell mui-transitioning">
					<div class="mui-slider-right mui-disabled">
						<a onclick="accpetThisOrder(${order.id },2,${order.is_big },${order.send_user_id })" class="mui-btn  " style="transform: translate(0px, 0px);background:#f2914a;">接单</a>
					</div>
					<div class="mui-slider-handle" style="transform: translate(0px, 0px);" onclick="showOrderDetail(${order.id },${order.status })">
						<div class="mui-table-cell">
							<div class="mui-col-xs-12 clearfix">
								<span class="order_title mui-col-xs-2 mui-pull-left">订单号:</span>
								<span class="order_num mui-col-xs-6 mui-pull-left">${order.waybill_number }</span>
								<span class="order_time mui-col-xs-4 mui-pull-left mui-text-right">${fn:substring(order.create_time, 0, 10) }</span>
							</div>
							<div class="mui-col-xs-12 clearfix" style="margin-top:5px;">
								<span class="mui-col-xs-2 mui-pull-left">
									<c:if test="${order.is_big==3 }">大件</c:if>
			    					<c:if test="${order.is_big==2 }">中件</c:if>
			    					<c:if test="${order.is_big==1 }">小件</c:if>
								</span>
								<span class="distribution-person mui-col-xs-6 mui-pull-left">&nbsp;&nbsp;
									<c:if test="${order.is_urgent==1 }">急件</c:if>
								 <span>
								 	${order.send_user }
								 </span></span>
								<span class="distribution-phone mui-col-xs-4 mui-pull-left mui-text-right">${order.send_phone }</span>
							</div>
						</div>
					</div>
				</li>
			</c:forEach>
			</ul>
			
			<div class="distribution-title distribution-list" >
				<b>待送达(
					<c:if test="${empty(orders2) }">0</c:if>
					<c:if test="${!empty(orders2) }">${fn:length(orders2)}</c:if>
				)</b>
			</div>
			<ul class="mui-table-view interleave before-none">
			<c:forEach items="${orders2 }" var="order">
				<li class="mui-table-view-cell mui-transitioning">
					<div class="mui-slider-right mui-disabled">
						<a onclick="accpetThisOrder(${order.id },5,${order.is_big },${order.send_user_id })" class="mui-btn" style="transform: translate(0px, 0px);background:#f2914a;">卸货</a>
					</div>
					<div class="mui-slider-handle" style="transform: translate(0px, 0px);" onclick="showOrderDetail(${order.id },${order.status })">
						<div class="mui-table-cell">
							<div class="mui-col-xs-12 clearfix">
								<span class="order_title mui-col-xs-2 mui-pull-left">订单号:</span>
								<span class="order_num mui-col-xs-6 mui-pull-left">${order.waybill_number }</span>
								<span class="order_time mui-col-xs-4 mui-pull-left mui-text-right">${fn:substring(order.create_time, 0, 10) }</span>
							</div>
							<div class="mui-col-xs-12 clearfix" style="margin-top:5px;">
								<span class="mui-col-xs-2 mui-pull-left">
									<c:if test="${order.is_big==3 }">大件</c:if>
			    					<c:if test="${order.is_big==2 }">中件</c:if>
			    					<c:if test="${order.is_big==1 }">小件</c:if>
								</span>
								<span class="distribution-person mui-col-xs-6 mui-pull-left">&nbsp;&nbsp;
									<c:if test="${order.is_urgent==1 }">急件</c:if>
								 <span>
			    					${order.send_user }
								 </span></span>
								<span class="distribution-phone mui-col-xs-4 mui-pull-left mui-text-right">${order.send_phone }</span>
							</div>
						</div>
					</div>
				</li>
			</c:forEach>
			</ul>
		</div>

	</body>
</html>