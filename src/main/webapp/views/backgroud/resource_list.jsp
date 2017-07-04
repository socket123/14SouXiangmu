<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源列表</title>
</head>
<body>
        <!-- 右侧 -->
        <div class="right col-sm-9">
        <div class="clearfix">
            <div class="clearfix  col-xs-12" style="margin-top:20px;" >
                <form class="form-horizontal col-xs-12" method="post" action="${url}admin/transTeam/gotoResourceList">
                        <!-- 一行开始 -->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <!-- 一组开始 -->
                                    <div class="col-xs-7">
                                        <label  class="col-xs-4 control-label">资源名称:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="rname" id="rName" value="${ssResource.rname }">
                                        </div>
                                    </div>
                                    <!-- 一组结束 -->
                                    <div class="col-xs-4">
                                         <div class="col-xs-6 ">
                                            <button type="sumbit" class="btn btn-primary search" >搜索</button>
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
                    <div class="ibox-content">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>选择</th>
                                        <th>所属分类</th>
                                        <th>资源名称</th>
                                        <th>数量</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                   <c:forEach items="${page.list}" var="m">
                                    <tr class="mytr">
                                        <td>
                                        	 <div class="checkbox i-checks">
							            		<label class="checkbox-inline"><input type="checkbox" id="${m.id }" value="${m.rname }" cateName="${m.cateName }" mnum="${m.number }"></label>
							            	</div>
                                        </td>
                                        <td>${m.cateName }</td>
                                        <td>${m.rname }</td>
                                        <td>${m.number }</td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
						
				        <div class="box-footer clearfix">
				        	<div class="pull-right">
								<ul class="pagination pagination-sm no-margin">
									<li><span class="pa-span">共<i> ${page.total } </i>条</span></li>
								</ul>
								<ul id="page-jq" class="pagination pagination-sm no-margin"></ul>
							</div>
						</div>
                    </div>
                </div>
            </div>
        </div>
        </div>
</body>
<script src="${url }js/jqPaginator.js"></script>
<link href="${url }css/plugins/iCheck/custom.css" rel="stylesheet">
<script src="${url }js/plugins/iCheck/icheck.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	parent.$("input[name=resourceid]").each(function(element) {
		var id = this.value;
		$("#"+id).prop("checked",true);
	});
	
	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
	
	$(".mytr").on("click",function(){
		var _t = $(this);
		var _chk = _t.find("input[type='checkbox']");
		var id = _chk.attr("id");
		
		var istrue = _chk.is(':checked'); 
		if(!istrue){
			_chk.prop("checked",true);
			_t.find(".icheckbox_square-green").addClass("checked");
			
			var cateName = _chk.attr("cateName");
			var mnum = _chk.attr("mnum");
			var rname = _chk.attr("value");
			
			var html = "<tr id=\"mytr"+id+"\"><td>"+cateName+"</td>";
				html += "<td>"+rname+"</td>";
				html += "<td>"+mnum+"</td>";
				html += "<td><input type=\"hidden\" name=\"resourceid\" value=\""+id+"\">";
				html += "<a class=\"btn btn-danger dela\" >删除</a></td></tr>";
			
			parent.$("#resourceTbody").append(html);
		}else{
			_chk.prop("checked",false);
			_t.find(".icheckbox_square-green").removeClass("checked");
			
			parent.$("#mytr"+id).remove();
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
	    	window.location.href="${url}admin/transTeam/gotoResourceList?pageNumber="+num;
    	}
    }
});

$("#btn4").on("click",function(){  
	$(".mytr").find("input[type='checkbox']").each(function(){
		var istrue = $(this).is(':checked'); 
		if(!istrue){
			$(this).prop("checked",true);
			$(this).parent().addClass("checked");
		}else{
			$(this).prop("checked",false);
			$(this).parent().removeClass("checked");
		}
	})
});

</script>
</body>
</html>