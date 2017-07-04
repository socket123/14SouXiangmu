<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../base.jsp" %>
<title>订单详情</title>
</head>
<body>
<div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>订单详情 </h5>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal">
                         <div class="form-group">
                                <label class="col-sm-2 control-label">运单号:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.source }${order.waybill_number }" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                           <div class="form-group">
                                <label class="col-sm-2 control-label">是否大件:</label>
                                <div class="col-sm-10">
                                    <c:if test="${order.is_big==1 }">
                                    <label class="checkbox-inline">
                                        <input type="radio" value="3" id="inlineCheckbox1" >大件</label>
                                    <label class="checkbox-inline">
                                        <input type="radio" value="2" id="inlineCheckbox2">中件</label>
                                     <label class="checkbox-inline">
                                        <input type="radio" value="1" id="inlineCheckbox2" checked="checked">小件</label>
                                    </c:if>
                                     <c:if test="${order.is_big==2 }">
                                    <label class="checkbox-inline">
                                        <input type="radio" value="3" id="inlineCheckbox1" >大件</label>
                                    <label class="checkbox-inline">
                                        <input type="radio" value="2" id="inlineCheckbox2" checked="checked">中件</label>
                                    <label class="checkbox-inline">
                                        <input type="radio" value="1" id="inlineCheckbox2" >小件</label>
                                    </c:if>
                                    
                                    <c:if test="${order.is_big==3 }">
                                    <label class="checkbox-inline">
                                        <input type="radio" value="3" id="inlineCheckbox1" checked="checked">大件</label>
                                    <label class="checkbox-inline">
                                        <input type="radio" value="2" id="inlineCheckbox2" >中件</label>
                                    <label class="checkbox-inline">
                                        <input type="radio" value="1" id="inlineCheckbox2" >小件</label>
                                    </c:if>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">是否急件:</label>
                                <div class="col-sm-10">
                                 <c:if test="${order.is_urgent==1 }">
                                    <label class="checkbox-inline">
                                        <input type="radio" value="option1" id="inlineCheckbox1" checked="checked">是</label>
                                    <label class="checkbox-inline">
                                        <input type="radio" value="option2" id="inlineCheckbox2">否</label>
                                 </c:if>
                                  <c:if test="${order.is_urgent==0 }">
                                    <label class="checkbox-inline">
                                        <input type="radio" value="option1" id="inlineCheckbox1" >是</label>
                                    <label class="checkbox-inline">
                                        <input type="radio" value="option2" id="inlineCheckbox2" checked="checked">否</label>
                                 </c:if>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">发件人:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.send_user }" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">发件人电话:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.send_phone }" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">位置:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.send_position}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                               <label class="col-sm-2 control-label">申请时间:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${fn:substring(order.create_time, 0, 16)}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">备注:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.remark}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">收件人:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.recip_user}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">收件人电话:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.recip_phone}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                           <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">位置:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.recip_position}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">收货时间:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${fn:substring(order.recip_time, 0, 16)}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                              </div>
                            <div class="hr-line-dashed"></div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">运输团队:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${order.team_name}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                             </div>
                            <div class="hr-line-dashed"></div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">负责人:</label>
                                <div class="col-sm-10">
                                     <textarea style="margin: 0px; width: 100%; height: 100px;" disabled="disabled">${order.username}</textarea>
                                </div>
                             </div>
                           <div class="hr-line-dashed"></div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">接货时间:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" value="${fn:substring(order.create_time, 0, 16)}" readonly="readonly"> <span class="help-block m-b-none"></span>
                                </div>
                            </div>
                              <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-2">
                                    <button class="btn btn-warning" type="button" onclick="goback()">返回</button>
                                </div>
                            </div>
</div>
</div>
</body>
<script type="text/javascript">
    function goback(){
    	 window.history.go(-1);
    }


</script>
</html>