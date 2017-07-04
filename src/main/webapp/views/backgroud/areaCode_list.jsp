<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>地址编码列表</title>
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
                <form class="form-horizontal col-xs-12" role="form" id="searchForm">
                        <!-- 一行开始 -->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <!-- 一组开始 -->
                                    <div class="col-xs-3">
                                        <label  class="col-xs-4 control-label">编码:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="areaCode" id="areaCode" value="${area.areaCode }">
                                        </div>
                                    </div>
                                    <!-- 一组结束 -->
                                    <div class="col-xs-4">
                                         <div class="col-xs-12 ">
                                            <a type="sumbit" class="btn btn-primary search" >搜索</a>
                                             <button type="button" class="btn btn-info" style="position: relative;width: 53px;height: 34px;" id="importForm" onclick="importExcel()">导入</button>
											 <button type="button" class="btn btn-success" style="position: relative;width: 80px;height: 34px;" id="ExportForm" onclick="exportExcel()">下载模板</button>                                            
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
                                        <th>编码</th>
                                        <th>出入库</th>
                                        <th>所属中转点</th>
                                        <th>是否启用</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                   <c:forEach items="${page.list}" var="m">
                                    <tr>
                                        <td>${m.areaCode }</td>
                                        <td>
                                        	<c:if test="${fn:indexOf(m.areaOut, '1') >= 0}">出库 </c:if>
                                        	<c:if test="${fn:indexOf(m.areaOut, '2') >= 0}">入库</c:if>
                                        </td>
                                        <td>${m.areaTrunk }</td>
                                        <td>
                                           <c:if test="${m.isEnable==1}">是</c:if>
                                           <c:if test="${m.isEnable==0}">否</c:if>
                                        </td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.createTime}" /></td>
                                        <td>
                                        	<c:if test="${m.isEnable==0}">
                                        		<a class="btn btn-success updstatus" id="${m.id}" status="1">启用</a>
                                        	</c:if>
                                           <c:if test="${m.isEnable==1}">
                                           		<a class="btn btn-danger updstatus" id="${m.id}" status="0">禁用</a>
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
<!-- 弹出框 -->
<div class="model" style="display:none" id="model">
	<div class="model-content" >
			<form id="dataForm" method="post">
			<div class="form-group">
				<label for class="col-sm-3">上传文件:</label>
				<input type="file" name="uploadFile" id="uploadFile" class="col-sm-7" />
			</div>
			<br>
			<br>
			<br>
			<div class="form-group col-sm-12 text-center"  >
				<button type="button" class="btn btn-primary" id="subDataForm">上传</button>
				<a class="btn btn-primary" onclick="cancelExcel()">取消</a>
			</div>
			</form>
	</div>
</div>
</body>
<script src="${url }js/jqPaginator.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".search").on("click",function(){
		location.href = "${url }admin/areaCode/list?"+$("#searchForm").serialize();
	})
	$(".updstatus").on("click",function(){
		var _t = $(this);
		var id = _t.attr("id");
		var status = _t.attr("status");
		
		$.post("${url}admin/areaCode/edit",{id:id,isEnable:status},function(data){
			if(data.code > 0){
				layer.msg("操作成功！", {icon: 1});
				if(status == "1"){
					_t.removeClass("btn-success");
					_t.addClass("btn-danger");
					_t.text("禁用");
					_t.removeAttr("status")
					_t.attr("status","0");
				}else{
					_t.removeClass("btn-danger");
					_t.addClass("btn-success");
					_t.text("启用");
					_t.removeAttr("status")
					_t.attr("status","1");
				}
			}else{
				layer.msg("操作失败！")
			}
		});
	})
});

$('#page-jq').jqPaginator({
    totalPages: parseInt('${page.pages }'),
    visiblePages: 5,
    currentPage: parseInt('${page.pageNumber }'),
    onPageChange:function(num,type){
    	if(type == 'change'){
	    	location.href = "${url }admin/areaCode/list?pageNo="+num+"&"+$("#searchForm").serialize();
    	}
    }
});



function importExcel(){
	$("#model").css("display","");
}
function cancelExcel(){
	$("#model").css("display","none");
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
				layer.alert("提示", "上传的文件格式不对,支持xls,xlsx");
				return;
			}
			var data = new FormData();
			$.each($('#uploadFile')[0].files, function(i, file) {
				data.append('file', file);
			});

			$.ajax({
				url : "${url}/admin/areaCode/importArea",
				type : 'POST',
				data : data,
				cache : false,
				contentType : false, //不可缺
				processData : false, //不可缺
				success : function(result) {
					if (result.code > 0) {
						layer.alert("成功"+result.code+"条!<br>失败信息："+result.msg,function(){
							window.location.href="${url}/admin/areaCode/list";
							$("#model").css("display","none");
						});
					}else{
						layer.alert("导入失败!<br>原因："+result.msg,function(){
							window.location.href="${url}/admin/areaCode/list";
							$("#model").css("display","none");
						});
					}
				}
			});
		});
		
		
		function exportExcel(){
			window.location.href="${url}/admin/areaCode/exportExcel"
		}
</script>
</html>