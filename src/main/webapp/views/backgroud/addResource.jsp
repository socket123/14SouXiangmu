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
                         <div class="form-group draggable">
                                <label class="col-sm-3 control-label">所属分类:</label>
                                <div class="col-sm-9">
                                     <select class="form-control" name="catagoryId" id="catagoryId">
                                                  <option value="" >---全部---</option>
                                                  <c:forEach items="${list }" var="catagory">
                                                     <option value="${catagory.id }">${catagory.catName }</option>
                                                  </c:forEach>
                                     </select>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">资源名称:</label>
                                <div class="col-sm-9">
                                    <input type="text" name="rname" id="rName" class="form-control" placeholder="请输入资源名称">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                             <div class="form-group draggable">
                                <label class="col-sm-3 control-label">数量:</label>
                                <div class="col-sm-9">
                                    <input type="text" name="number" id="number" class="form-control" placeholder="请输入数量 ">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group draggable">
                                <label class="col-sm-3 control-label">备注:</label>
                                <div class="col-sm-9">
                                   <textarea style="margin: 0px; width: 822px; height: 297px;" name="remark" id="remark"></textarea>
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
	var catagoryId=$("#catagoryId").val();
	var rName=$("#rName").val();
	var remark=$("#remark").val();
	var number=$("#number").val();
	$.ajax({
        url : '${url }admin/resou/addResource',
        type:'post',
        data:{catagoryId:catagoryId,rname:rName,remark:remark,number:number},
        success:function(result)
        {
          if(result.message==1){
        	 layer.alert("资源添加成功!",function(){
        		 
        	 window.location.href="${url}admin/resou/gotoResourceList";
        	 });
          }else{
        	 layer.alert("资源添加失败!",function(){
        		 
        	 window.location.href="${url}admin/resou/gotoResourceList";
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
        	rname:{
        		required:true
            },
            catagoryId:{
        		required:true
            },
            number:{
            	required:true,
        		range:[0,99999]
            }
        },
        //如果验证控件没有message，将调用默认的信息
        messages:{
        	rname:{
        		required:"请输入资源名称 "
            },
        	catagoryId:{
        		required:"请选择分类 "
            },
            number:{
            	required:"请输入数量",
        		range:"数值介于{0}-{1}之间"
            }
        }
                  
    });    
</script>
</html>