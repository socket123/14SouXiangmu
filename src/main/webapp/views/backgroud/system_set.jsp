<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统配置</title>
</head>
<body>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
			    <form id="saveForm" class="form-horizontal m-t">
			    	<input type="hidden" name="id" value="${obj.id }" />
			        <div class="col-md-6">
				    <div class="form-group">
				        <label class="col-sm-3 control-label">工作时间控制：</label>
				        <div class="col-sm-9">
				        	 <div class="checkbox i-checks">
				            	<label class="checkbox-inline"><input type="checkbox" value="1" id="chk1" name="timeset">周一</label>
				            	<label class="checkbox-inline"><input type="checkbox" value="2" id="chk2" name="timeset">周二</label>
				            	<label class="checkbox-inline"><input type="checkbox" value="3" id="chk3" name="timeset">周三</label>
				            	<label class="checkbox-inline"><input type="checkbox" value="4" id="chk4" name="timeset">周四</label>
				            	<label class="checkbox-inline"><input type="checkbox" value="5" id="chk5" name="timeset">周五</label>
				            	<label class="checkbox-inline"><input type="checkbox" value="6" id="chk6" name="timeset">周六</label>
				            	<label class="checkbox-inline"><input type="checkbox" value="7" id="chk7" name="timeset">周日</label>
				             </div>
				        </div>
				    </div>
				    <div class="form-group">
				        <label class="col-sm-3 control-label">超出配送时间设置（分钟）：</label>
				        <div class="col-sm-9">
				            <input type="text" name="deliveryTimeout" class="form-control" value="${obj.deliveryTimeout }" placeholder="请输入数字">
				        </div>
				    </div>
				    <div class="form-group">
				        <label class="col-sm-3 control-label">超出接单时间设置（分钟）：</label>
				        <div class="col-sm-9">
				            <input type="text" name="receivTimeout" class="form-control" value="${obj.receivTimeout }" placeholder="请输入数字">
				        </div>
				    </div>
				    <div class="form-group draggable">
			               <div class="col-sm-12 col-sm-offset-3">
			                   <a class="btn btn-primary save">保存</a>
			               </div>
			           </div>
				</div>
		    </form>
 		</div>
 	</div>
</body>
<link href="${url }css/plugins/iCheck/custom.css" rel="stylesheet">
<script src="${url }js/jquery.validate.min.js"></script>
<script src="${url }js/plugins/iCheck/icheck.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
});

var roles = '${obj.timeset}';
$('input[name="timeset"]').each(function(){ 
	if(indexOf(roles,$(this).val()) > -1){
		$(this).attr("checked",'true');
	}
}); 
function indexOf(arr,item){
  if(!arr){
     return -1;
  }
  for(var i=0;i<arr.length;i++){
    if(arr[i]==item){
      return i;
    }
  }
  return -1;
}
$(".save").on("click",function(){
	if($("#saveForm").valid()){
		$.ajax({
	        url : '${url}admin/sysset/edit?'+$("#saveForm").serialize(),
	        type:'post',
	        data:{},
	        success:function(result)
	        {
	          if(result.code > 0){
	        	layer.alert("保存成功！", {icon: 1},function(){
	        		location.href="${url}admin/sysset/toEdit";
	        	});
	          }else{
	        	  layer.msg("保存失败！", {icon: 5});
	          }
	        }
	    });
	}
});
$("#saveForm").validate({
    rules:{
    	deliveryTimeout:{
    		required:true,
    		range:[0,99999]
        },               
        receivTimeout:{
        	required:true,
    		range:[0,99999]
        }                
    },
    //如果验证控件没有message，将调用默认的信息
    messages:{
    	deliveryTimeout:{
    		required:"请输入超出配送时间",
    		range:"数值介于{0}-{1}之间"
        },               
        receivTimeout:{
        	required:"请输入超出接单时间",
    		range:"数值介于{0}-{1}之间"
        }
    }
              
});    
</script>
</html>