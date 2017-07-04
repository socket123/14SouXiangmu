<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
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
		left:50%;
		width: 410px;
		height:170px;
		margin-top: -100px;
		margin-left: -250px;
		background: #fff;
		-moz-box-shadow: 1px 1px 5px #888888; /* 老的 Firefox */
		box-shadow: 1px 1px 5px #888888;
		padding: 20px;
	}
	.model from{
		position: relative;
		z-index: 999;
	}
</style>
</head>
<body>
<br>
 <div class="clearfix">
            <div class="clearfix  col-xs-12" id="advanced_query" >
                <form class="form-horizontal col-xs-12" role="form" id="orderForm" method="post" action="${url }admin/user">
                        <!-- 一行开始 -->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <!-- 一组开始 -->
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">姓名:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="userName" id="userName" value="${ssUser.userName }">
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">工号:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="jobNum" id="jobNum" value="${ssUser.jobNum }">
                                        </div>
                                    </div>
                                     <!-- 一组开始 -->
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">电话:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="telephone" id="telephone" value="${ssUser.telephone}" >
                                        </div>
                                    </div>
                                    <!-- 一组结束 -->
                                    <div class="col-xs-3">
                                         <div class="col-xs-12 ">
                                            <button type="sumbit" class="btn btn-primary" >搜索</button>
                                            <button type="button" class="btn btn-info" style="position: relative;width: 53px;height: 34px;" id="importForm" onclick="importExcel()">导入</button>
                                            <button type="button" class="btn btn-success" style="position: relative;width: 80px;height: 34px;" id="ExportForm" onclick="exportExcel()">下载模板</button>
                                            <button type="button" class="btn btn-warning" style="position: relative;width: 80px;height: 34px;" id="syncUserFrom" onclick="syncSSUser()">同步</button>
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
                    <div class="ibox-title">显示 ${page.offset } 到 
				        		<c:set var="endset" value="${page.offset + page.limit}"/>
				        		<c:if test="${endset > page.total }">${page.total }</c:if>
				        		<c:if test="${endset <= page.total }">${endset }</c:if>
				        		 项，共 ${page.total } 项</div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>姓名</th>
                                        <th>工号</th>
                                        <th>电话</th>
                                        <th>是否开启短信通知</th>
                                        <th>创建时间</th>
                                        <th>是否运输团队</th>
                                        <th>是否为民工</th>
                                        <th>民工状态</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                   <c:forEach items="${page.list}" var="m">
                                    <tr>
                                        <td>${m.userName }</td>
                                        <td>${m.jobNum }</td>
                                        <td>${m.telephone }</td>
                                        <td>
                                           <c:if test="${m.isOpen==1}">是</c:if>
                                           <c:if test="${m.isOpen==0}">否</c:if>
                                        </td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.createTime}" /></td>
                                        <td>
                                             <c:if test="${m.isTeam==1 }">是</c:if>
                                             <c:if test="${m.isTeam==0 }">否</c:if>
                                        </td>
                                        <td>
                                             <c:if test="${m.is_worker==1 }">是</c:if>
                                             <c:if test="${m.is_worker==0 }">否</c:if>
                                        </td>
                                        <td>
                                             <c:if test="${m.worker_status==0 ||  m.worker_status==null }">无</c:if>
                                             <c:if test="${m.worker_status==1 }">工作</c:if>
                                             <c:if test="${m.worker_status==2 }">空闲</c:if>
                                             <c:if test="${m.worker_status==3 }">休息</c:if>
                                        </td>
                                        <td>
                                           <c:if test="${m.isTeam==1 }">
                                             <a class="btn btn-warning" onclick="offIsTeam(${m.id})">关闭</a>
                                           </c:if>
                                           <c:if test="${m.isTeam==0 }">
                                             <a class="btn btn-warning" onclick="openIsTeam(${m.id})">开启</a>
                                            </c:if>
                                        	<a class="btn btn-warning" onclick="editUser(${m.id})">编辑</a>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
						
				        <div class="box-footer clearfix">
				        	<div class="pull-right">
								<ul id="page-jq" class="pagination pagination-sm no-margin"></ul>
							</div>
						</div>
                    </div>
                </div>
            </div>
        </div>
<!-- <div id="dlg" class="easyui-dialog"
			style="width: 650px; height:450px; padding-left: 0px;" closed="true"
			modal="true">
			<iframe id="sid" frameborder="0" src="" width="100%" height="100%"></iframe>
</div> -->

<!-- 弹出框 -->
<div class="model" style="display:none" id="model">
	<div class="model-content" ">
			<form id="dataForm" method="post">
			<div class="form-group">
				<label for="" class="col-sm-3">上传文件:</label>
				<input type="file" name="uploadFile" id="uploadFile" class="col-sm-7" />
			</div>
			<br>
			<br>
			<br>
			<div class="form-group col-sm-12 text-center"  >
				<button type="button" class="btn btn-primary" id="subDataForm">上传</button>
				<button type="button" class="btn btn-primary" onclick="cancelExcel()">取消</button>
			</div>
				<!-- 隐藏表单域存放位置 -->
				<!-- <table cellpadding="3">
					<tr>
						<td>上传文件:</td>
						<td><input type="file" name="uploadFile" id="uploadFile" /></td>
					</tr>
					<tr>
						<td colspan="2" align="center"><a href="javascript:void(0)"
							class="easyui-linkbutton" style="width: 100px; height: 30px;"
							id="subDataForm">上传</a></td>
					</tr>
				</table> -->
			</form>
	</div>
</div>
</body>
<script src="${url }js/jqPaginator.js"></script>
<script type="text/javascript">
$(document).ready(function(){
});

$('#page-jq').jqPaginator({
    totalPages: parseInt('${page.pages }'),
    visiblePages: 5,
    currentPage: parseInt('${page.pageNumber }'),
    onPageChange:function(num,type){
    	if(type == 'change'){
	    	//resetP('invitecode','currentIndex='+num);
	    	var jobNum=$("#jobNum").val();
	    	var tel=$("#telephone").val();
	    	window.location.href="${url }admin/user?pageNumber="+num+"&jobNum="+jobNum+"&telephone="+tel;
    	}
    }
});


function exportExcel(){
	window.location.href="${url }admin/user/exportExcel";
}

function cancelExcel(){
	$("#model").css("display","none");
}

function importExcel(){
	$("#model").css("display","");
}
//ajax异步上传附件
$("#subDataForm").click(
		function() {
			//判断是否有选择上传文件  
			var uploadFile = $("#uploadFile").val();
			if (uploadFile == "") {
				layer.alert("提示", "请上传excel！");
				return;
			}
			//判断上传文件的后缀名  
			var strExtension = (uploadFile
					.substr(uploadFile.lastIndexOf('.') + 1)).toLowerCase();
			if (strExtension != 'xls' && strExtension != 'xlsx') {
				layer.alert("提示", "上传的文件格式不对");
				return;
			}
			var data = new FormData();
			$.each($('#uploadFile')[0].files, function(i, file) {
				data.append('file', file);
			});

			$.ajax({
				url : "${url}admin/user/importUser",
				type : 'POST',
				data : data,
				cache : false,
				contentType : false, //不可缺
				processData : false, //不可缺
				success : function(result) {
					var loadindex = layer.load();
					var msg="";
					if(result.result==1){
						if(result.alreayjobNum!=""||result.unFullJobNum!=""){
							msg+="部分导入成功!";
							if(result.alreayjobNum!=""){
								msg+="工号为:"+result.alreayjobNum+"的人员已存在并进行了修改!";
							}
							if(result.unFullJobNum!=""){
								msg+="工号为:"+result.unFullJobNum+"的excel表格数据不完整!";
							}
						}else{
							msg+="导入成功";
						}
						layer.alert(msg,function(){
							window.location.href="${url}admin/user";
							$("#model").css("display","none");
						});
					}else{
						msg+="导入失败!";
						if(result.alreayjobNum!=""){
							msg+="工号为:"+result.alreayjobNum+"的人员已存在!";
						}
						if(result.unFullJobNum!=""){
							msg+="工号为:"+result.unFullJobNum+"的excel表格数据不完整!";
						}
						layer.alert(msg,function(){
							window.location.href="${url}admin/user";
							$("#model").css("display","none");
						});
					}
					layer.close(loadindex);
				}
			});
		});
		
		
function offIsTeam(id)
{
	layer.confirm("确定关闭是否团队?",{
		 btn: ['确定','取消'], //按钮
		 shade: false //不显示遮罩
	},function(index){
			$.ajax({
				url : "${url}admin/user/offUserIsteam?id="+id,
				type : 'POST',
				success : function(result) {
					if(parseInt(result.message)==1){
						 layer.alert("关闭成功!");
						 window.location.href="${url}admin/user";
					}else{
						layer.alert("关闭失败!");
						window.location.href="${url}admin/user";
					}
					
					}
				});
	})
}




function openIsTeam(id)
{
	layer.confirm("确定开启是否团队?",{
		 btn: ['确定','取消'], //按钮
		 shade: false //不显示遮罩
	},function(index){
			$.ajax({
				url : "${url}admin/user/openUserIsteam?id="+id,
				type : 'POST',
				success : function(result) {
					if(parseInt(result.message)==1){
						 layer.alert("开启成功!");
						 window.location.href="${url}admin/user";
					}else{
						layer.alert("开启失败!");
						window.location.href="${url}admin/user";
					}
					
					}
				});
	})
}

function syncSSUser(){
	var index = layer.load(); 
	$.post("${url}admin/user/syncUser",{},function(data){
		layer.close(index);
		if(data.result > 0){
			layer.alert("同步成功!",function(){
				 location.href="${url}admin/user";
			});
		}else{
			layer.alert("同步失败");
		}
	});
}

function editUser(id){
	window.location.href="${url}admin/user/gotoEditUser?id="+id;
}

</script>
</html>