<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增资源类别</title>
</head>
<body>
<div class="ibox-content">
                        <form id="saveForm" class="form-horizontal m-t">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-xs-2 control-label" style="line-height: 34px;">运单号:</label>
                            <div class="col-xs-10">
                              <input type="text" name="waybill_number" id="waybill_number" class="form-control" placeholder="请输入运单号">
                            </div>
                          </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-xs-2 control-label">二维码:</label>
                                <div class="col-xs-10">
                                   <textarea style="margin: 0px; width: 100%; height: 100px;" id="remark"></textarea>
                                </div>
                            </div>
                            <div class="form-group draggable">
                                <div class="col-sm-12 col-sm-offset-3 text-center">
                                    <a class="btn btn-primary" id="save" onclick="confimOrder()">确认</a>
                                    <button class="btn btn-white" type="button" onclick="goback()">取消</button>
                                </div>
                                <br>
                            </div>
                        </form>
                    </div>
</body>
<script src="${url }js/jquery.validate.min.js"></script>
<script type="text/javascript">
function confimOrder(){
	var waybill_number=$("#waybill_number").val();
	var remark=$("#remark").val();
	if(waybill_number=='' && remark=='' ){
		layer.alert("运单号和二维码不能同时为空!");
		return false;
	}
	$.ajax({
        url : '${url}admin/orderAll/updateOrderStatusByNum',
        type:'post',
        data:{waybill_number:waybill_number,remark:remark},
        success:function(result)
        {
          if(result.message==1){
        	 layer.alert("单据回收成功!");
        	 parent.layer.closeAll();
        	 parent.location.reload();
          }else{
        	 layer.alert("运单号不存在!",function(){
        		 parent.layer.closeAll();
            	 parent.location.reload();
        	 });
        	
          }
        }
    });	
}
	



    function goback(){
    	 window.history.go(-1);
    }
</script>
</html>