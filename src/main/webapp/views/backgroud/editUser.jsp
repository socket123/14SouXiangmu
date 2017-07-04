<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑用户</title>
</head>
<body>
<div class="ibox-content">
                        <form id="saveForm" class="form-horizontal m-t">
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">用户工号:</label>
                                <div class="col-sm-9">
                                    <input type="text" name="jobNum" id="jobNum" value="${ssUser.jobNum }" class="form-control" readonly="readonly">
                                    <input type="hidden" value="${ssUser.id}" id="userId">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">用户姓名:</label>
                                <div class="col-sm-9">
                                    <input type="text" name="userName" id="userName" value="${ssUser.userName }" class="form-control">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">手机号码:</label>
                                <div class="col-sm-9">
                                  <input type="text" name="telephone" id="telephone" value="${ssUser.telephone }" class="form-control">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">创建时间:</label>
                                <div class="col-sm-9">
                                  <input type="text" name="createTime" id="createTime" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${ssUser.createTime}" />" class="form-control" readonly="readonly">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">是否运输团队:</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="isTeam" id="isTeam" disabled="disabled">
                                         <option value="${ssUser.isTeam }" <c:if test='${ssUser.isTeam ==1}'>selected="selected"</c:if>>是</option>
                                         <option value="${ssUser.isTeam }" <c:if test='${ssUser.isTeam ==0}'>selected="selected"</c:if>>否</option>
                                     </select>
                                </div>
                            </div>
                            
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">是否开启短信通知:</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="isOpen" id="isOpen" disabled="disabled">
                                         <option value="${ssUser.isOpen }" <c:if test='${ssUser.isOpen ==1}'>selected="selected"</c:if>>是</option>
                                         <option value="${ssUser.isOpen }" <c:if test='${ssUser.isOpen ==0}'>selected="selected"</c:if>>否</option>
                                     </select>
                                </div>
                            </div>
                            <div class="form-group draggable">
                                <div class="col-sm-12 col-sm-offset-3">
                                    <a class="btn btn-primary"  id="save">保存</a>
                                    <button class="btn btn-white" type="button" onclick="goback()">取消</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
</body>
<script src="${url }js/jquery.validate.min.js"></script>
<script type="text/javascript">
$("#save").on("click",function(){
	if($("#saveForm").valid()){
	var telephone=$("#telephone").val();
	var id=$("#userId").val();
	$.ajax({
        url : '${url }admin/user/editUser',
        type:'post',
        data:{id:id,telephone:telephone},
        success:function(result)
        {
          if(result.message==1){
        	 layer.alert("用户编辑成功!",function(){
        	 window.location.href="${url}admin/user";
        	 });
          }else{
        	 layer.alert("用户编辑失败!",function(){
        	 window.location.href="${url}admin/user";
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
        	telephone:{
        		required:true
            }              
        },
        //如果验证控件没有message，将调用默认的信息
        messages:{
        	telephone:{
        		required:"请输入手机号码 "
            }
        }
                  
    }); 
    
</script>
</html>