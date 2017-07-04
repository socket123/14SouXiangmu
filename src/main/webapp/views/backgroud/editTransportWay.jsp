<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增运输方式</title>
</head>
<body>
<div class="ibox-content">
                        <form id="saveForm" class="form-horizontal m-t">
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">运输方式:</label>
                                <div class="col-sm-9">
                                    <input type="text" name="transportType" id="transportType" class="form-control" value="${transportWay.transportType}" placeholder="请输入运输方式">
                                    <input type="hidden" name="id" id="transportId" value="${transportWay.id }">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">备注:</label>
                                <div class="col-sm-9">
                                   <textarea style="margin: 0px; width: 822px; height: 297px;" name="remark" id="remark">${transportWay.remark}</textarea>
                                </div>
                            </div>
                            <div class="form-group draggable">
                                <div class="col-sm-12 col-sm-offset-3">
                                    <a class="btn btn-primary" id="save">保存</a>
                                    <button class="btn btn-white" type="button" onclick="goback()">取消</button>
                                </div>
                            </div>
                        </form>
                    </div>
</body>
<script src="${url }js/jquery.validate.min.js"></script>
<script type="text/javascript">
$("#save").on("click",function(){
	if($("#saveForm").valid()){
	var transportType=$("#transportType").val();
	var remark=$("#remark").val();
	var id=$("#transportId").val();
	$.ajax({
        url : '${url }admin/transportWay/editTransportWay',
        type:'post',
        data:{id:id,transportType:transportType,remark:remark},
        success:function(result)
        {
          if(result.message==1){
        	 layer.alert("运输方式修改成功!",function(){
        		 window.location.href="${url}admin/transportWay/gotoTransportWayList";
        	 });
          }else{
        	 layer.alert("运输方式修改失败!",function(){
        	 	window.location.href="${url}admin/transportWay/gotoTransportWayList";
        	 });
          }
        }
    });
	}
})
    function goback(){
    	 window.history.go(-1);
    }


$("#saveForm").validate({
        rules:{
        	transportType:{
        		required:true
            }              
        },
        //如果验证控件没有message，将调用默认的信息
        messages:{
        	transportType:{
        		required:"请输入运输方式 "
            }
        }
                  
    }); 
</script>
</html>