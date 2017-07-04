<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增团队</title>
</head>
<body>
<div class="ibox-content">
	<form id="saveForm" class="form-horizontal m-t">
	 <div class="form-group draggable">
	        <label class="col-sm-3 control-label">所属分类:</label>
	        <div class="col-sm-3">
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
	        <label class="col-sm-3 control-label">团队名称:</label>
	        <div class="col-sm-3">
	            <input type="text" name="teamName" id="teamName" class="form-control" placeholder="请输入团队名称" value="${obj.teamName}">
	            <input type="hidden" name="id" id="id" value="${obj.id }">
	        </div>
	    </div>
	    <div class="hr-line-dashed"></div>
	     <div class="form-group draggable">
	        <label class="col-sm-3 control-label">负责人:</label>
	         <div class="col-sm-6 col-sm-offset-3" style="margin-left: 0;">
	           <button class="btn btn-white" type="button" onclick="chooseUser()">选择负责人</button>
	        </div>
	    </div>
	       <div class="form-group">
	        <label class="col-sm-3 control-label"></label>
	        <div class="col-sm-6 col-sm-offset-3" style="margin-left: 0;">
	           <ul class="tag-list userId" id="" style="padding: 0">
	           	<c:forEach items="${jobNumlist }" var="list">
	           		<li id="idss${list.id }"><a class="removea"><i class="fa fa-remove"></i><input type="hidden" name="uid" value="${list.id }">${list.jobNum } </a></li>
	           	</c:forEach>
	           </ul>
	        </div>
	    </div>
		<%--<div class="hr-line-dashed"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label">所属类型:</label>
			<div class="col-sm-3">
				<div class="radio i-checks">
					<label><input type="radio" value="0" name="teamType">干线团队
						<input type="radio" value="1" name="teamType">支线团队</label>
				</div>
			</div>
		</div>--%>
	    <div class="hr-line-dashed"></div>
	     <div class="form-group">
	        <label class="col-sm-3 control-label">是否启用:</label>
	        <div class="col-sm-3">
	        	<div class="radio i-checks">
		            <label><input type="radio" value="1" name="isEnable">是
		            <input type="radio" value="0" name="isEnable">否</label>
	            </div>
	        </div>
	    </div>
	    <div class="hr-line-dashed"></div>
	     <div class="form-group">
	        <label class="col-sm-3 control-label">运输能力:</label>
	        <div class="col-sm-3">
	        	 <div class="checkbox i-checks">
		            <label class="checkbox-inline"><input type="checkbox" name="ability" value="1">小件</label>
	            	<label class="checkbox-inline"><input type="checkbox" name="ability" value="2">中件</label>
	             	<label class="checkbox-inline"><input type="checkbox" name="ability" value="3">大件</label>
	            </div>
	        </div>
	    </div>
	    <div class="hr-line-dashed"></div>
	     <div class="form-group">
	        <label class="col-sm-3 control-label">运输范围:</label>
	        <div class="col-sm-6 col-sm-offset-3" style="margin-left: 0;">
	           <button class="btn btn-white" type="button" onclick="choose()">选择范围</button>
	        </div>
	    </div>
	    <div class="form-group">
	       <label class="col-sm-3 control-label"></label>
	       <div class="col-sm-6 col-sm-offset-3" style="margin-left: 0;">
	    <div class="table-responsive expend">
	       <table class="table table-striped table-bordered">
	           <thead>
	               <tr>
	                   <th>编码</th>
	                   <th>出入库</th>
	                   <th>排序</th>
	                   <th>操作</th>
	               </tr>
	           </thead>
	           <tbody id="areaTBody">
	           	<c:forEach items="${areaList }" var="list">
	           		 <tr>
	                   <td>${list.areaCode}</td>
	                   <td>
	                       <c:if test="${fn:indexOf(list.areaOut, '1') >= 0}">出库 </c:if>
                           <c:if test="${fn:indexOf(list.areaOut, '2') >= 0}">入库</c:if>
	                   </td>
	                   <td><input type="text" name="ssOrder" value="${list.ssOrder}"></td>
	                   <td><input type="hidden" name="areaCode" value="${list.id }"><a class="btn btn-danger delaa">删除</a></td>
	               	</tr>
	           	</c:forEach>
	           </tbody>
	       </table>
	      	
	   </div>
	    <div>
       		<botton class="btn btn-default insexpend">展开</botton>
       </div>
       </div>
	       
	   </div>
	     <div class="hr-line-dashed"></div>
	     <div class="form-group">
	        <label class="col-sm-3 control-label">配套资源:</label>
	        <div class="col-sm-6 col-sm-offset-3" style="margin-left: 0;">
	           <button class="btn btn-white" type="button" onclick="addResource()">添加资源</button>
	        </div>
	    </div>
	    <div class="form-group">
	       <label class="col-sm-3 control-label"></label>
	       <div class="col-sm-6 col-sm-offset-3" style="margin-left: 0;">
	          <div class="table-responsive">
	       <table class="table table-striped table-bordered">
	           <thead>
	               <tr>
	                   <th>所属分类</th>
	                   <th>资源名称</th>
	                   <th>数量</th>
	                   <th>操作</th>
	               </tr>
	           </thead>
	           <tbody id="resourceTbody">
	           	<c:forEach items="${resList }" var="list">
	           		 <tr>
	                   <td>${list.cateName }</td>
	                   <td>${list.rname }</td>
	                   <td>${list.number }</td>
	                   <td><input type="hidden" name="resourceid" value="${list.id }"><a class="btn btn-danger dela">删除</a></td>
	               	</tr>
	           	</c:forEach>
	           </tbody>
	       </table>	

	   </div>
	       </div>
	       
	   </div>
	   
	    <div class="form-group draggable">
	        <div class="col-sm-12 col-sm-offset-3">
	            <a class="btn btn-primary"  onclick="save()">保存</a>
	            <button class="btn btn-white" type="button" onclick="goback()">取消</button>
	        </div>
	    </div>
	</form>
</div>
</body>
<link href="${url }css/plugins/iCheck/custom.css" rel="stylesheet">
<script src="${url }js/jquery.validate.min.js"></script>
<script src="${url }js/plugins/iCheck/icheck.min.js"></script>
<style type="text/css">
.expend{height:290px;overflow: hidden}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#catagoryId").val("${obj.catagoryId}");
	$("#userId").val("${obj.userId}");
	
	var ability = '${obj.ability}';
	$('input[name="ability"]').each(function(){ 
		if(indexOf(ability.split(","),$(this).val()) > -1){
			$(this).attr("checked",'true');
		}
	});

    var teamType = '${obj.teamType}';
    $('input[name="teamType"]').each(function(){
        if(indexOf(teamType.split(","),$(this).val()) > -1){
            $(this).attr("checked",'true');
        }
    });

    var isEnable = '${obj.isEnable}';
	$('input[name="isEnable"]').each(function(){ 
		if(indexOf(isEnable.split(","),$(this).val()) > -1){
			$(this).attr("checked",'true');
		}
	}); 
	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
	

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

function save(){
	if($("#saveForm").valid()){
		$.ajax({
	        url : '${url }admin/transTeam/editTeam',
	        type:'post',
	        data:$("#saveForm").serialize(),
	        success:function(result)
	        {
	          if(result.message > 0){
	        	 layer.alert("操作成功!",function(){
	        	 	location.href="${url}admin/transTeam/gotoTransportTeamList";
	        	 });
	          }else{
	        	 layer.alert("操作失败!",function(){
	        		 location.href="${url}admin/transTeam/gotoTransportTeamList";
	        	 });
	          }
	        }
	    });
	}
}
function goback(){
	 window.history.go(-1);
}

function choose(){
	//iframe层
	layer.open({
	  type: 2,
	  title: '选择范围',
	  shadeClose: true,
	  shade: 0.8,
	  area: ['480px', '90%'],
	  content: '${url}admin/transTeam/findAreaList' //iframe的url
	});

}

function chooseUser(){
	//iframe层
	layer.open({
	  type: 2,
	  title: '选择负责人',
	  shadeClose: true,
	  shade: 0.8,
	  area: ['680px', '90%'],
	  content: '${url}admin/user/gotoUserList?id='+$("#id").val() //iframe的url
	}); 

}

function addResource(){
	//iframe层
	layer.open({
	  type: 2,
	  title: '添加资源',
	  shadeClose: true,
	  shade: 0.8,
	  area: ['680px', '90%'],
	  content: '${url}admin/transTeam/gotoResourceList' //iframe的url
	}); 

}

$("#saveForm").validate({
    rules:{
    	catagoryId:"required",
    	userId:"required",
        teamType:"required",
    	isEnable:"required",
    	ability:"required",
    	areaCode:"required",
    	resourceid:"required",
    	teamName:{
    		required:true,
    		maxlength : 20
        }
    },
    //如果验证控件没有message，将调用默认的信息
    messages:{
    	catagoryId:"请选择分类",
    	userId:"请选择负责人",
        teamType:"请选择类型",
    	isEnable:"请选择是否启用",
    	ability:"请选择运输能力",
    	areaCode:"请选择运输范围",
    	resourceid:"请选择配套资源",
    	teamName:{
    		required:"请输入团队名称",
    		maxlength : "请不要超过{0}个字符"
        }
    }
              
});    

$(".areaid").on("click",".fa",function(){
	$(this).parent().remove();
})

$(".userId").on("click",".fa",function(){
	$(this).parent().remove();
})

$("#resourceTbody").on("click",".dela",function(){
	$(this).parent().parent().remove();
})


$(".table").on("click",".delaa",function(){
	$(this).parent().parent().remove();
})



$(".insexpend").click(function(){
	var pren = $(this).parent().prev();
	if(pren.hasClass("expend")){
		pren.removeClass("expend");
		$(this).text("收起");
	}else{
		pren.addClass("expend");
		$(this).text("展开");
	}
})
</script>
</html>