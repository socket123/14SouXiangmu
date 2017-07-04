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
                <form class="form-horizontal col-xs-12" role="form" id="searchForm">
                        <!-- 一行开始 -->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <!-- 一组开始 -->
                                    <div class="col-xs-4">
                                        <label  class="col-xs-4 control-label">工号:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="jobNum" id="jobNum" value="${ssUser.jobNum }">
                                        </div>
                                    </div>
                                     <!-- 一组开始 -->
                                    <div class="col-xs-4">
                                        <label  class="col-xs-4 control-label">电话:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="telephone" id="telephone" value="${ssUser.telephone}" >
                                        </div>
                                    </div>
                                   <!-- 一组结束 -->
                                    <div class="col-xs-4">
                                         <div class="col-xs-6 ">
                                            <a type="sumbit" class="btn btn-primary search" >搜索</a>
                                         </div>
                                         <div class="col-xs-6 ">
                                            <a type="sumbit" class="btn btn-primary confirm" >确认</a>
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
                                        <th>选择</th>
                                        <th>姓名</th>
                                        <th>工号</th>
                                        <th>电话</th>
                                        <th>是否运输团队</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                <input type="hidden" value="${teamId}" id="teamId"/>
                                   <c:forEach items="${page.list}" var="m">
                                    <tr class="mytr">
                                        <td>
                                             <div class="checkbox i-checks">
							            		<label class="checkbox-inline"><input type="checkbox" id="${m.id }" value="${m.jobNum }"></label>
							            	</div>
							            </td>
							            <td>${m.userName }</td>
                                        <td>${m.jobNum }</td>
                                        <td>${m.telephone }</td>
                                        <td>
                                             <c:if test="${m.isTeam==1 }">是</c:if>
                                             <c:if test="${m.isTeam==0 }">否</c:if>
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
<link href="${url }css/plugins/iCheck/custom.css" rel="stylesheet">
<script src="${url }js/jqPaginator.js"></script>
<script src="${url }js/plugins/iCheck/icheck.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	parent.$("input[name='uid']").each(function(element) {
		var id = this.value;
		$("#"+id).prop("checked",true);
	});
	$(".search").on("click",function(){
		location.href = "${url }admin/user/gotoUserList?"+$("#searchForm").serialize();
	})
	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
	
	$(".mytr").on("click",function(){
        var teamId=$("#teamId").val();
	    var html = "";
		var _t = $(this);
		var _chk = _t.find("input[type='checkbox']");
		var id = _chk.attr("id");
		var value=_chk.attr("value");
		
		var istrue = _chk.is(':checked'); 
		if(!istrue){
			$.ajax({
				url : "${url}admin/transTeam/findTeamRelation",
				type : 'POST',
				data:{other_id:id,team_id:teamId},
				success : function(result) {
				   if(parseInt(result.message)==0){
					   _chk.prop("checked",true);
						_t.find(".icheckbox_square-green").addClass("checked");
						
						html += "<li id=\"idss"+id+"\"><a class=\"removea\"><i class=\"fa fa-remove\"></i><input type=\"hidden\" name=\"uid\" value=\""+id+"\"> "+value+" </a></li>"
						parent.$(".userId").append(html);
				   }else{
						layer.alert("该负责人已经存在其他团队!");
						return;
					}
				}
		    });
		}else{
			_chk.prop("checked",false);
			_t.find(".icheckbox_square-green").removeClass("checked");
			
			parent.$("#idss"+id).remove();
		}
	})
});


$(".confirm").on("click",function(){
	parent.layer.closeAll();
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
	    	window.location.href="${url }admin/user/gotoUserList?pageNumber="+num+"&jobNum="+jobNum+"&telephone="+tel;
    	}
    }
});


</script>
</html>