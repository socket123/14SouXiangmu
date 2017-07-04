<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单申请</title>
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<script type="text/javascript">
function submitForm(isedit,val){
	if(!checkIsNotNull("waybill_number")){
		return;
	}
	if(!checkIsNotNull("send_user")){
		return;
	}
	if(!checkIsNotNull("send_phone")){
		return;
	}
	if(!checkIsNotNull("send_position")){
		return;
	} 
	if(!checkIsNotNull("recip_user")){
		return;
	}
	if(!checkIsNotNull("recip_phone")){
		return;
	}
	if(!checkIsNotNull("recip_position")){
		return;
	}
	if(checkWallBillNoIsExist($("#waybill_number").val())==1 && isedit == 0){
		mui.toast("该运单编号已经存在");
		return;
	}
	if($("#send_user").val()==$("#recip_user").val()){
		mui.toast("发件人工号和收件人工号不能相同");
		return;
	}
	if($("#send_position").val()==$("#recip_position").val()){
		mui.toast("发件人地址编码和收件人地址编码不能相同");
		return;
	}
	var path = '${url }font/orderRequest/addOrder';
	if(isedit == 1){
		path = "${url }font/orderRequest/editOrder";
	}
	$.ajax({
		cache : false,
		async : false,
		type : "POST",
		url :  path,
		data : $('#orderForm').serialize(),
		success : function(result) {
			if(result.message == 1){
				mui.alert("提示", '操作成功!!!', function() {
				    if(val ==1){
                        location.href = "${url }font/orders/indexAcceptOrders";
					} else{
                        location.href = "${url }font/orderList/index";
					}
	            });
			}else{
				mui.toast(result.msg);
			}
		},
		error : function(request) {
			mui.alert("系统消息", '操作失败!!!');
		}
	});
}

function checkWallBillNoIsExist(value){
	var flag=-1
	$.ajax({
		cache : false,
		async : false,
		type : "POST",
		url :  "${url }font/orderList/checkWaybillNumberIsExist",
		data : {waybill_number:value},
		success : function(result) {
			flag = result.message;
		},
		error : function(request) {
			mui.alert("系统消息", '操作失败!!!');
		}
	});
	return flag;
}

function checkIsNotNull(cellId){
	if($("#"+cellId).val()==""){
		mui.toast("表单没有填写完整！");
		return false;
	}
	return true;
}

function checkPositionIsExist(value,type,obj){
	if(value==""){
		mui.toast("地址编码不能为空");
		return;
	}
	$.ajax({
		cache : false,
		async : false,
		type : "POST",
		url :  "${url }font/orderRequest/checkPositionIsExist",
		data : {area_code:value},
		success : function(result) {
			if(result.message==0){
				mui.toast("地址编码不存在");
				$(obj).val("");
				return;
			}
			if(result.is_enable!=1){
				mui.toast("地址编码未启用");
				$(obj).val("");
				return;
			}
			if(result.out.indexOf(type)<0){
				mui.toast("填写的地址编码不符合出入库的标准");
				$(obj).val("");
				return;
			}
		},
		error : function(request) {
			mui.alert("系统消息", '操作失败');
		}
	});
	
}

function findRecipId(jobNum,obj){
	$.ajax({
		cache : false,
		async : false,
		type : "POST",
		url :  "${url }font/orderRequest/findByUser",
		data : {jobNum:jobNum},
		success : function(result) {
			if(result){
				$("#recip_user_id").val(result.id);
				$("#recip_phone").val(result.telephone);
			}else{
				mui.toast('该工号不存在');
				$(obj).val("");
			}
		},
		error : function(request) {
			mui.alert("系统消息", '操作失败');
		}
	});
}

$(function(){
	$("#saoyisao").on("click",function(){
		vrv.jssdk.getInfoWithSweep({       
	       success: function (res) {
	    	   //alert(JSON.stringify(res.sweepKey));
	           //如：{"sweepKey":"这是一个二维码扫描测试"}
	           $.post("${url}font/orders/smAccept",{param:res.sweepKey},function(data){
	        	   if(data.msg == "success"){
	        		   location.href = "${url}font/orders/toAddOrder?is_edit=0&param="+data.obj;
	        	   }else{
	        		   mui.toast(data.msg);
	        	   }
	           })
	       }
	   })
	});
});

</script>
</head>
<body class="orders" style="background:#fff">
		<header id="header" class="mui-bar mui-bar-nav">
			<h1 class="mui-title">订单申请</h1>
			<a class="mui-btn mui-btn-link mui-btn-nav mui-pull-left" href="${url }font/orders" style="color:#FFF"><span class="mui-icon mui-icon-left-nav"></span>返回</a></header>
		<form id="orderForm">
		<div class="mui-content" style="margin-top:44px;">
		    <div class="mui-row">
		        <div class="mui-col-sm-12 mui-col-xs-12">
		            <li class="mui-table-view-cell">
		                <span class="mui-col-xs-3 mui-pull-left">订单编号</span>
		                <div class="mui-col-xs-8 mui-pull-left">
		                	<input value="${order.waybill_number }" <c:if test="${is_edit==1 }">readonly="readonly"</c:if> id="waybill_number" type="text" name="waybill_number" maxlength="13"/>
		               		<c:if test="${is_edit==1 }">
		               			<input type="hidden" name="id" value="${order.id }" />
		               		</c:if>
		                </div>
		                <span class="mui-col-xs-1 mui-pull-left sys" id="saoyisao"></span>
		            </li>
		        </div>
		        
		        <div class="mui-col-sm-12 mui-col-xs-12">
		            <li class="mui-table-view-cell">
		                <span class="mui-col-xs-3 mui-pull-left" style="line-height: 28px;margin-top:7px;">物品大小</span>
		                <div class="mui-col-xs-3 mui-pull-left">
		                	<div class="mui-input-row mui-radio mui-left">
							<label>大</label>
							<input 
							<c:if test="${order.is_big==3 }"> checked="checked" </c:if> name="is_big" type="radio" value="3" />
						    </div>
		                </div>
		                 <div class="mui-col-xs-3 mui-pull-left">
		                	<div class="mui-input-row mui-radio mui-left">
							<label>中</label>
							<input
							<c:if test="${order.is_big==2 }"> checked="checked" </c:if> name="is_big" type="radio" value="2" />
						    </div>
		                </div>
		                <div class="mui-col-xs-3 mui-pull-left">
		                	<div class="mui-input-row mui-radio mui-left">
							<label>小</label>
							<input
							<c:if test="${order.is_big==1 }"> checked="checked" </c:if> name="is_big" type="radio" value="1" />
						    </div>
		                </div>
		            </li>
		        </div>
		    </div>
	    </div>
	    <div class="mui-col-sm-12 mui-col-xs-12">
		            <li class="mui-table-view-cell">
		                <span class="mui-col-xs-3 mui-pull-left" style="line-height: 28px;margin-top:7px;">是否急件</span>
		                <div class="mui-col-xs-3 mui-pull-left">
		                	<div class="mui-input-row mui-radio mui-left">
							<label>是</label>
							<input <c:if test="${order.is_urgent==1 }"> checked="checked" </c:if> name="is_urgent" type="radio" value="1" />
						    </div>
		                </div>
		                 <div class="mui-col-xs-3 mui-pull-left">
		                	<div class="mui-input-row mui-radio mui-left">
							<label>否</label>
							<input
							<c:if test="${order.is_urgent!=1 }"> checked="checked" </c:if>  name="is_urgent" type="radio" value="0" />
						    </div>
		                </div>
		            </li>
		        </div>
		        <div class="mui-col-sm-12 mui-col-xs-12">
		            <li class="mui-table-view-cell">
		                <span class="mui-col-xs-3 mui-pull-left">来源</span>
		                <div class="mui-col-xs-8 mui-pull-left">
		                <c:if test="${is_edit==1 }">
		                	<input readonly="readonly" value="${order.source }" id=source type="text" name="source" style="height: 30px;border: 1px solid #9da6d1;" />
		                </c:if>
		                <c:if test="${is_edit==0}">
		                	<c:set var="orderSource" value="M"/>
		                	<c:if test="${order.source != null && order.source != ''}">
		                		<c:set var="orderSource" value="${order.source}"/>
		                	</c:if>
		                	<input value="${orderSource }" readonly="readonly" id=source type="text" name="source" style="height: 30px;border: 1px solid #9da6d1;" />
		                </c:if>
		                </div>
		            </li>
		        </div>
		        
		    </div>
	    </div>
	    
		<div class="mui-padd-10   addressee">
			<p class="address-title">发件人信息</p>
			<div class="mui-table-view mui-grid-view mui-grid-9 ">
					<!-- 一个 -->
		            <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-user" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
							<c:if test="${is_edit==0 }">
								<c:set var="orderuserid" value="${user.id }"/>
								<c:set var="orderjobnum" value="${user.jobNum }"/>
								
			                	<c:if test="${!empty(order) && order.send_user_id != null && order.send_user_id != ''}">
			                		<c:set var="orderuserid" value="${order.send_user_id }"/>
									<c:set var="orderjobnum" value="${order.send_user }"/>
			                	</c:if>
			                	
								<input value="${orderuserid }" type="hidden" name="send_user_id" />
								<input id="send_user" value="${orderjobnum }" name="send_user" type="text" placeholder="工号" style="margin-bottom: 10px;">
							</c:if>
							<c:if test="${is_edit==1 }">
								<input value="${order.send_user_id }" type="hidden" name="send_user_id" />
								<input id="send_user" value="${order.send_user }" name="send_user" type="text" placeholder="工号" style="margin-bottom: 10px;">
							</c:if>	
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
        			<!-- 一个 -->
		            <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-phone" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
							<c:if test="${is_edit==0 }">
								<c:set var="sendphone" value="${user.telephone }"/>
								
			                	<c:if test="${!empty(order) && order.send_phone != null && order.send_phone != ''}">
			                		<c:set var="sendphone" value="${order.send_phone }"/>
			                	</c:if>
								<input id="send_phone" value="${sendphone }" name="send_phone" send_phone type="text" placeholder="电话" style="margin-bottom: 10px;" maxlength="11">
							</c:if>
							<c:if test="${is_edit==1 }">
								<input id="send_phone" value="${order.send_phone }" name="send_phone" send_phone type="text" placeholder="电话" style="margin-bottom: 10px;" maxlength="11">
							</c:if>	
								
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
        			<!-- 一个 -->
		            <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-map-marker" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
								<input value="${order.send_position }" id="send_position" onblur="checkPositionIsExist(this.value,1,this)" name="send_position" type="text" placeholder="地址编码" style="margin-bottom: 10px;">
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
        			<!-- 一个 -->
		           <!-- <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div> -->
	                <!-- <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-clock-o" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 " style="margin-bottom: 10px;">
								<button id="dateOne" data-options="{}" class="btn btn-clock">选择日期时间 ...</button>
								<input type="hidden" id="dateOneIndex" name="create_time" />
							</div>
	               		</div>
	                </div> -->
	               <!--  <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div> -->
	                <!-- 一个 -->
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-edit" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
								<textarea class="textarea" name="remark">${order.remark }</textarea>
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
		    </div>
		</div>
		<div class="mui-padd-10   addressee">
			<p class="address-title">收件人信息</p>
			<div class="mui-table-view mui-grid-view mui-grid-9 ">
					<!-- 一个 -->
		            <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-user" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
								<input value="${order.recip_user_id }" type="hidden" name="recip_user_id" id="recip_user_id" />
								<input value="${order.recip_user }" onblur="findRecipId(this.value,this)" id="recip_user" name="recip_user" type="text" placeholder="工号" style="margin-bottom: 10px;">
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
        			<!-- 一个 -->
		            <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-phone" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
								<input value="${order.recip_phone }" id="recip_phone" name="recip_phone" type="text" placeholder="电话" style="margin-bottom: 10px;" maxlength="11">
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
        			<!-- 一个 -->
		            <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-map-marker" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
								<input value="${order.recip_position }" id="recip_position" onblur="checkPositionIsExist(this.value,2,this)" name="recip_position" type="text" placeholder="地址编码" style="margin-bottom: 10px;">
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
        			<!-- 一个 -->
		           <!-- <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div> -->
	                <!-- <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-clock-o" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 " style="margin-bottom: 10px;">
								<button id="dateTwo" data-options="{}" class="btn btn-clock">选择日期时间 ...</button>
								<input type="text" id="dateTwoIndex" name="recip_time" />
							</div>
	               		</div>
	                </div> -->
	                <!-- <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div> -->
	                <!-- 一个 -->
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-10 ">
	               		<div class="mui-table-view mui-grid-view mui-grid-9">
							<div class="mui-table-view-cell  mui-col-xs-2 ">
								<span class="fa fa-edit" ></span>
							</div>
							<div class="mui-table-view-cell  mui-col-xs-10 ">
								<textarea name="remarkTwo" class="textarea">${order.remarkTwo }</textarea>
								<input type="hidden" name="status" value="1" />
							</div>
	               		</div>
	                </div>
	                <div class="mui-table-view-cell  mui-col-xs-1 ">
	                </div>
		    </div>
		</div>
		<div style="height:60px;"></div>
		<div class="boottom_btn">
			<c:choose>
				<c:when test="${flag==1 }">
					<button onclick="submitForm(${is_edit},1)" type="button" class="mui-btn mui-btn-royal mui-btn-block">变更订单</button>
				</c:when>
				<c:otherwise>
					<button onclick="submitForm(${is_edit},0)" type="button" class="mui-btn mui-btn-royal mui-btn-block">提交申请</button>
				</c:otherwise>
			</c:choose>
		</div>
		</form>
	</body>
	<script type="text/javascript">
			(function($) {
				$.init();
				var this_time;
				var result = $('#result')[0];
				var btns = $('.btn');
				btns.each(function(i, btn) {
					btn.addEventListener('tap', function() {
						var optionsJson = this.getAttribute('data-options') || '{}';
						var options = JSON.parse(optionsJson);
						var id = this.getAttribute('id');
						var that = this;
						/*
						 * 首次显示时实例化组件
						 * 示例为了简洁，将 options 放在了按钮的 dom 上
						 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
						 */
						var picker = new $.DtPicker(options);
						picker.show(function(rs) {

							/*
							 * rs.value 拼合后的 value
							 * rs.text 拼合后的 text
							 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
							 * rs.m 月，用法同年
							 * rs.d 日，用法同年
							 * rs.h 时，用法同年
							 * rs.i 分（minutes 的第二个字母），用法同年
							 */
							that.innerText =  rs.text;
							document.getElementById(id+"Index").value =  rs.text;
							/* 
							 * 返回 false 可以阻止选择框的关闭
							 * return false;
							 */
							/*
							 * 释放组件资源，释放后将将不能再操作组件
							 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
							 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
							 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
							 */
							picker.dispose();
						});
					}, false);
				});
			})(mui);

	</script>
</html>