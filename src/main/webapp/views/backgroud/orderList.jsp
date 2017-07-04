<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<title>订单列表</title>
<style type="text/css">
.form-horizontal .control-label{
	text-align: left;
}
</style>
</head>
<body>
		<br>
       <div class="clearfix">
            <div class="clearfix  col-xs-12" id="advanced_query" >
                <form class="form-horizontal col-xs-12" role="form" id="orderForm" method="post" action="${url }admin/orderAll">
                        <!-- 一行开始 -->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <!-- 一组开始 -->
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">运单号</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="waybill_number" id="waybill_number" value="${order.waybill_number }">
                                        </div>
                                    </div>
                                     <!-- 一组开始 -->
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">申请人</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="jobNumOne" id="jobNumOne" value="${order.jobNumOne }" >
                                        </div>
                                    </div>
                                    <!-- 一组结束 -->
                                    <!-- 一组开始 -->
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">收货人</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="jobNumTwo" id="jobNumTwo" value="${order.jobNumTwo }" >
                                        </div>
                                    </div>
                                    <!-- 一组结束 -->
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">状态</label>
                                        <div class="col-xs-8 ">
                                               <select class="form-control" name="status" id="status">
                                                  <option value="" <c:if test='${order.status==""}'>selected="selected"</c:if>>==全部==</option>
                                                  <option value="1" <c:if test='${order.status==1}'>selected="selected"</c:if>>申请中</option>
                                                  <option value="2" <c:if test='${order.status==2}'>selected="selected"</c:if>>运输中</option>
                                                  <option value="3" <c:if test='${order.status==3}'>selected="selected"</c:if>>已完成</option>
                                                  <option value="4" <c:if test='${order.status==4}'>selected="selected"</c:if>>已取消</option>
                                                  <option value="5" <c:if test='${order.status==5}'>selected="selected"</c:if>>已卸货</option>
                                                </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 再一行-->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <label  class="col-xs-2 control-label">申请时间</label>
                                        <div class="col-xs-10 ">
                                              <input type="date" class="form-control" name="startTime" style="width:45%;display:inline-block;" id="startTime" value="${order.startTime }">
                                              --
                                              <input type="date" class="form-control" name="endTime" style="width:45%;display:inline-block;" id="endTime" value="${order.endTime }">
                                        </div>
                                    </div>
                                   <div class="col-xs-5">
                                        <label  class="col-xs-2 control-label">发货时间</label>
                                        <div class="col-xs-10 ">
                                              <input type="date" class="form-control" name="recipStartTime" style="width:45%;display:inline-block;" id="recipStartTime" value="${order.recipStartTime }">
                                              --
                                              <input type="date" class="form-control" name="recipEndTime" style="width:45%;display:inline-block;" id="recipEndTime" value="${order.recipEndTime }">
                                        </div>
                                    </div>
                                    <div class="col-xs-2">
                                    
                                         <div class="col-xs-12 ">
                                            <button type="sumbit" class="btn btn-primary" >搜索</button>
                                            <button type="button" class="btn btn-primary" onclick="exportExcel()">导出</button>
                                         </div>
                                    </div>
                                </div>
                            </div>
                        </div>                                                   
                </form>
            </div>
        </div>  
<div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    </div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>运单号</th>
                                        <th>货物大小</th>
                                        <th>订单状态</th>
                                        <th>申请人工号</th>
                                        <th>发货地址</th>
                                        <th>申请时间</th>
                                        <th>运输团队</th>
                                        <th>接货时间</th>
                                        <th>目的地</th>
                                        <th>收货人工号</th>
                                        <th>是否异常</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                   <c:forEach items="${page.list}" var="m">
                                    <tr>
                                        <td><a href="${url }admin/orderAll/findOrderDetailById?id=${m.id}">${m.source}${m.waybill_number}</a></td>
                                        <td><c:if test="${m.is_big==1}">小件</c:if>
                                            <c:if test="${m.is_big==2}">中件</c:if>
                                            <c:if test="${m.is_big==3}">大件</c:if>
                                         </td>
                                        <td>
                                           <c:if test="${m.status==1}">申请中</c:if>
                                           <c:if test="${m.status==2}">运输中</c:if>
                                           <c:if test="${m.status==3}">已完成</c:if>
                                           <c:if test="${m.status==4}">已取消</c:if>
                                           <c:if test="${m.status==5}">已卸货</c:if>
                                        </td>
                                        <td>${m.jobNumOne}</td>
                                        <td>${m.send_position}</td>
                                        <td>
                                         ${fn:substring(m.create_time, 0, 16)}
                                        </td>
                                        <td>${m.team_name}</td>
                                        <td>${fn:substring(m.recip_time, 0, 16)}</td>
                                        <td>${m.recip_position}</td>
                                        <td>${m.jobNumTwo}</td>
                                        <td>
                                        <c:choose> 
	                                         <c:when test="${m.status==1 }">
	                                            <c:if test="${m.unusual==0}">正常</c:if>
	                                            <c:if test="${m.unusual==1}"><span style="color:red">异常</span></c:if>
	                                         </c:when>
	                                           <c:when test="${m.status==2 }">
	                                            <c:if test="${m.unusual==0}">正常</c:if>
	                                            <c:if test="${m.unusual==1}"><span style="color:red">异常</span></c:if>
	                                         </c:when>
	                                         <c:otherwise>正常</c:otherwise>
                                         </c:choose> 
                                        </td>
                                        <td>
                                        <c:if test="${m.status==1}">
                                        	<a class="btn btn-warning" onclick="cancelOrder(${m.id})"> 取消订单</a>
                                        </c:if>
                                        <c:if test="${m.status==4}">
                                        <a class="btn btn-warning" onclick="deleteOrder(${m.id})">删除</a>
                                        </c:if>
                                        <c:if test="${m.status==5}">
                                        <a class="btn btn-warning" onclick="recy()">单据回收</a>
                                        </c:if>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
						
				        <div class="box-footer clearfix">
				        	<div class="pull-right">
								<ul class="pagination pagination-sm no-margin">
									<li><span class="pa-span">每页<i> ${page.limit } </i>条记录，共<i> ${page.total } </i>条记录</span></li>
								</ul>
								<ul id="page-jq" class="pagination pagination-sm no-margin"></ul>
							</div>
						</div>
                    </div>
                </div>
            </div>
        </div>
</body>
<script src="${url }js/jqPaginator.js"></script>
<script type="text/javascript">
$(document).ready(function(){
});

function recy(){
	//iframe层
	layer.open({
	  type: 2,
	  title: '单据回收',
	  shadeClose: true,
	  shade: 0.8,
	  area: ['500px', '330px'],
	  content: '${url}admin/orderAll/gotoRecy' //iframe的url
	}); 

}



$('#page-jq').jqPaginator({
    totalPages: parseInt('${page.pages }'),
    visiblePages: 5,
    currentPage: parseInt('${page.pageNumber }'),
    onPageChange:function(num,type){
    	if(type == 'change'){
	    	//resetP('invitecode','currentIndex='+num);
	    	 var waybill_number=$("#waybill_number").val();
			 var jobNumOne=$("#jobNumOne").val();
			 var jobNumTwo=$("#jobNumTwo").val();
			 var status=$("#status").val();
			 var startTime=$("#startTime").val();
			 var endTime=$("#endTime").val();
			 var recipStartTime=$("#recipStartTime").val();
			 var recipEndTime=$("#recipEndTime").val();
	    	window.location.href="${url }admin/orderAll?pageNumber="+num+"&jobNumOne="+jobNumOne+"&waybill_number="+waybill_number
															            +"&jobNumTwo="+jobNumTwo+"&status="+status
															            +"&startTime="+startTime+"&endTime="+endTime
															            +"&recipStartTime="+recipStartTime+"&recipEndTime="+recipEndTime;
    	}
    }
});

function cancelOrder(id){
	layer.confirm("确定取消订单?",{
		 btn: ['确定','取消'], //按钮
		 shade: false //不显示遮罩
	}, function(index){
		$.ajax({
	        url : '${url}admin/orderAll/updateStatusById',
	        type:'post',
	        data:{id:id,status:4},
	        success:function(result)
	        {
	          if(result.message==1){
	        	 layer.alert("订单取消成功!");
	        	 window.location.href="${url}admin/orderAll";
	          }else{
	        	 layer.alert("订单取消失败!");
	        	 window.location.href="${url}admin/orderAll";
	          }
	        }
	    });
	    layer.close(index);
	},function(index){
		layer.close(index);
	})
}





function deleteOrder(id){
	layer.confirm("确定删除订单?",{
		 btn: ['确定','取消'], //按钮
		 shade: false //不显示遮罩
	}, function(index){
			$.ajax({
		        url : '${url}admin/orderAll/deleteOrderById',
		        type:'post',
		        data:{id:id},
		        success:function(result)
		        {
		          if(result.message==1){
		        	 layer.alert("订单删除成功!",function(){
		        	 window.location.href="${url}admin/orderAll";
		        	 });
		          }else{
		        	 layer.alert("订单删除失败!",function(){
		        	 window.location.href="${url}admin/orderAll";
		        	 });
                 }
               }
           });
            layer.close(index);
	},function(index){
		layer.close(index);
	})
}

function seach(){
	$("#orderForm").submit();
}

function exportExcel(){
	 var waybill_number=$("#waybill_number").val();
	 var jobNumOne=$("#jobNumOne").val();
	 var jobNumTwo=$("#jobNumTwo").val();
	 var status=$("#status").val();
	 var startTime=$("#startTime").val();
	 var endTime=$("#endTime").val();
	 var recipStartTime=$("#recipStartTime").val();
	 var recipEndTime=$("#recipEndTime").val();
     window.location.href='${url}admin/orderAll/exportOrderExcel?waybill_number='+waybill_number+"&jobNumOne="+jobNumOne
    		                                                                      +"&jobNumTwo="+jobNumTwo+"&status="+status
    		                                                                      +"&startTime="+startTime+"&endTime="+endTime
    		                                                                      +"&recipStartTime="+recipStartTime+"&recipEndTime="+recipEndTime;

}

function collect(){
	
}
</script>
</html>