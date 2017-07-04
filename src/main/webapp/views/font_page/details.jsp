<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>订单详情</title>
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
			height:230px;
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
			var wholeStatus="";
            $(function(){

                var u = navigator.userAgent;
                var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
                if(isAndroid){
					$(".phone").each(function(){
					    $(this).attr("href","beixinyuan:tel/"+$(this).attr("phone"));
					});
				}

                $("#saoyisao").on("click",function(){
                    vrv.jssdk.getInfoWithSweep({
                        success: function (res) {
                            var carryout = (JSON.stringify(res.sweepKey));
                            carryout = eval("("+eval("("+carryout+")")+")");
                            $("#carryout_code").val(carryout.carryoutcode);
                        }
                    })
                });
            });
			function closeCurrentPage(){
				window.history.go(-1);
			}
			
			function editRequestOrder(id){
				location.href="${url }font/orderRequest/toAdd?is_edit=1&id="+id;	
			}
			
			function reciveOrder(id){
				mui.confirm('是否确认收货？', '系统消息', null, function(e) {
	                if(e.index == 1){
	                	$.ajax({
	        				cache : false,
	        				async : false,
	        				type : "POST",
	        				url :  "${url }font/orderList/updateStatus",
	        				data:{id:id,status:3},
	        				success : function(result) {
	        					if(result.message > 0){
	        						mui.alert("操作成功",function(){
										window.location.href="${url }font/orders/myReceiveOrders";
									});
	        						//initUnFinishedOrders();
	        						//initFinishedOrders();
	        					}
	        				},
	        				error : function(request) {
	        					mui.alert("系统消息", '操作失败');
	        				}
	        			});
	                }
	            })
			}

			// 接单
			function accpetThisOrder(id,status,is_big,send_user_id){
				if($("#loginUserId").val()==send_user_id){
					mui.toast("不能操作自己申请的单据");
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
                                        wholeStatus=status;
										$("#model").css("display","");
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
			function cancelmodel(){
				$(".model").css("display","none");
                window.location.href="${url }font/orders/indexAcceptOrders";
			}

            function subDataForm(id) {
			    var carryoutCode = $("#carryout_code").val();
                $.ajax({
                    cache : false,
                    async : false,
                    type : "POST",
                    url :  "${url }font/orderList/updateCarryOut",
                    data:{id:id,carryoutCode:carryoutCode,status:wholeStatus},
                    success : function(resultObj) {
                        if(typeof(resultObj.mess)!="undefined"){
                            mui.alert(resultObj.mess);
						} else{
                            if(resultObj.messageForCarry==1&&resultObj.message==1){
                                mui.alert("操作成功",function(){
                                    window.location.href="${url }font/orders/indexAcceptOrders";
                                });
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
            }

            function evaluateOrder(oid){
                window.location.href="${url }font/orderList/gotoEvaluateOrder?orderId="+oid;
			}
		</script>
</head>
<body class="orders" style="background:#fff">
		<header id="header" class="mui-bar mui-bar-nav">
			<h1 class="mui-title">订单详情</h1>
			<a class="mui-action-back mui-btn  mui-btn-link mui-btn-nav mui-pull-left"><span class="mui-icon mui-icon-left-nav"></span>返回</a>
		</header>
		<div class="mui-content " style="margin-bottom: 60px;">
		    <div class="details-header">
		    	<span style="display:inline-block; vertical-align: top;">订单号: </span><span class="details-id">${order.waybill_number }</span><span class="mui-pull-right" style="font-size:.9rem;">${fn:substring(order.create_time, 0, 10) }</span>
		    </div>
		    <div class="details-body">
		    	<div>
		    	<span style="font-weight:bold;">
			    	<c:if test="${order.is_big==1 }">
			    	小件
			    	</c:if>
			    	<c:if test="${order.is_big==2 }">
			    	中件
			    	</c:if>
			    	<c:if test="${order.is_big==3 }">
			    	大件
			    	</c:if>
		    	</span>
		    	&nbsp;&nbsp;&nbsp;&nbsp;
		    	<c:if test="${order.is_urgent==1 }">
		    	<span style="color: red;">
		    	急件
		    	</span>
		    	</c:if>
		    		<span class="mui-pull-right" style="color:#87acd9">
		    		
		    		</span>
		    	</div>
		    	<br>
		    	<div>
		    		<div class="d-header">送件人信息</div>
		    		<ul class="clearfix">
		    			<li><span>姓名</span>${order.send_username }</li>
		    			<li><span>电话</span>${order.send_phone }<a class="phone" href="tel:${order.send_phone }" phone="${order.send_phone }"></a></li>
		    			<li><span>位置</span>${order.send_position }</li>
		    			<li><span>申请时间</span>${fn:substring(order.create_time, 0, 16) }</li>
		    			<li><span style="float:left;">备注</span><p style="width:60%;float:left;word-break:break-all;">${order.remark }</p></li>
		    		</ul>
		    	</div>
		    	<div style="text-align:center;margin:25px 0;">
		    		<div style="height:1px;background:#eee;width:95%;"></div>
		    	</div>
		    	<div>
		    		<div class="d-header">收件人信息</div>
		    		<ul class="clearfix">
		    			<li><span>姓名</span>${order.recip_username }</li>
		    			<li><span>电话</span>${order.recip_phone }<a class="phone" href="tel:${order.recip_phone }" phone="${order.recip_phone }"></a></li>
		    			<li><span>位置</span>${order.recip_position }</li>
		    			<li><span>确认收货时间</span>${fn:substring(order.recip_time, 0, 16) }</li>
		    			<li><span style="float:left;">备注</span>
		    			<p style="width:60%;float:left;word-break:break-all;">${order.remarkTwo }</p></li>
		    		</ul>
		    	</div>
		    	<div style="text-align:center;margin:25px 0;">
		    		<div style="height:1px;background:#eee;width:95%;"></div>
		    	</div>
		    	<c:if test="${order.status!=1 && order.status!=4}">
		    	<div>
		    		<div class="d-header">运输团队信息</div>
		    		<ul class="clearfix">
		    			<li><span>负责人</span>${order.deliver_job_num }</li>
		    			<li><span>电话</span>${order.deliver_telephone }<a class="phone" href="tel:${order.deliver_telephone }" phone="${order.deliver_telephone }"></a></li>
		    			<li><span>接货时间</span>${fn:substring(order.delivery_time, 0, 16) }</li>
		    			<li><span>卸货时间</span>${fn:substring(order.unloading_time, 0, 16) }</li>
		    		</ul>
		    	</div>
		  		</c:if>
			<div >
				<div style="text-align: center;" >
				<c:if test="${order.if_evalute_send==0 || order.if_evalute_recip==0 }">
					<a onclick="evaluateOrder(${order.id })" class="mui-btn mui-btn-royal express1">评价</a>
				</c:if>
				<c:if test="${role==1 }">
					<c:if test="${order.status==4 }">
						<button onclick="editRequestOrder(${order.id })" type="button" class="mui-btn mui-btn-royal express1">修改</button>
					</c:if>
					<a href="${url }font/orderList/index" class="mui-btn mui-btn-royal express1">返回</a>
				</c:if>
				<c:if test="${role==2 }">
					<c:if test="${order.status==5 }">
						<a onclick="reciveOrder(${order.id })" class="mui-btn mui-btn-royal express1">确认收货</a>
					</c:if>
					<a href="${url }font/orders/myReceiveOrders" class="mui-btn mui-btn-royal express1">返回</a>
				</c:if>
				<c:if test="${role==3 }">
						<c:if test="${order.status==1 }">
							<a href="/sslogistics/font/orderRequest/toAdd?is_edit=1&id=${order.id}&flag=1" class="mui-btn mui-btn-royal express1">变更订单</a>
							<a onclick="accpetThisOrder(${order.id },2,${order.is_big },${order.send_user_id })" class="mui-btn mui-btn-royal express1">接单</a>
						</c:if>
						<c:if test="${order.status==2 }">
							<a onclick="accpetThisOrder(${order.id },6,${order.is_big },${order.send_user_id })" class="mui-btn mui-btn-royal express1">中转点卸货</a>
						</c:if>
						<c:if test="${order.status==6 }">
							<a onclick="accpetThisOrder(${order.id },7,${order.is_big },${order.send_user_id })" class="mui-btn mui-btn-royal express1">中转接单</a>
						</c:if>
						<c:if test="${order.status==8 }">
							<a onclick="accpetThisOrder(${order.id },9,${order.is_big },${order.send_user_id })" class="mui-btn mui-btn-royal express1">中转接单</a>
						</c:if>
						<c:if test="${order.status==9 }">
							<a onclick="accpetThisOrder(${order.id },5,${order.is_big },${order.send_user_id })" class="mui-btn mui-btn-royal express1">卸货</a>
						</c:if>
						<c:if test="${order.status==7 }">
							<a onclick="accpetThisOrder(${order.id },8,${order.is_big },${order.send_user_id })" class="mui-btn mui-btn-royal express1">中转点卸货</a>
						</c:if>
					<a href="${url }font/orders/indexAcceptOrders" class="mui-btn mui-btn-royal express1">返回</a>
				</c:if>
			    </div>
			</div>
		</div>
		</div>

		<!-- 弹出框 -->
		<div class="model" style="display:none" id="model">
			<div class="model-content" >
				<form id="dataForm" method="post">
					<div class="mui-row">
						<div class="mui-col-sm-12 mui-col-xs-12">
							<li class="mui-table-view-cell">
								<span class="mui-col-xs-3 mui-pull-left">载具编号</span>
								<div class="mui-col-xs-8 mui-pull-left">
									<input id="carryout_code" type="text" name="carryout_code" maxlength="13"/>
								</div>
								<span class="mui-col-xs-1 mui-pull-left sys" id="saoyisao"></span>
							</li>
						</div>
						<div class="form-group col-sm-12 text-center"  >
							<button type="button" class="btn btn-primary" onclick="subDataForm(${order.id })">确认</button>
							<button type="button" class="btn btn-primary" onclick="cancelmodel()">取消</button>
						</div>
					</div>

				</form>
			</div>
		</div>
	</body>
</html>