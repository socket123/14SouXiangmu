<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>地址编码列表</title>
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
                                    <div class="col-xs-8">
                                        <label  class="col-xs-4 control-label">编码:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="areaCode" id="areaCode" value="${area.areaCode }">
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
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th><a id="btn4">选择</a></th>
                                        <th>编码</th>
                                        <th>出入库</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                   <c:forEach items="${page.list}" var="m">
                                    <tr class="mytr">
                                        <td>
                                        	 <div class="checkbox i-checks">
							            		<label class="checkbox-inline"><input type="checkbox" id="${m.id }" areaCode="${m.areaCode}" value="${m.areaCode }"></label>
							            	</div>
                                        </td>
                                        <td>${m.areaCode }</td>
                                        <td id="td${m.id }">
                                        	<c:if test="${fn:indexOf(m.areaOut, '1') >= 0}">出库 </c:if>
                                        	<c:if test="${fn:indexOf(m.areaOut, '2') >= 0}">入库</c:if>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</body>
<script src="${url }js/jqPaginator.js"></script>
<link href="${url }css/plugins/iCheck/custom.css" rel="stylesheet">
<script src="${url }js/jquery.validate.min.js"></script>
<script src="${url }js/plugins/iCheck/icheck.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	parent.$("input[name=areaCode]").each(function(element) {
		var id = this.value;
		$("#"+id).prop("checked",true);
	});
	
	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
	
	
	$(".mytr").on("click",function(){
		var _t = $(this);
		var _chk = _t.find("input[type='checkbox']");
		var id = _chk.attr("id");
		
		var istrue = _t.find("input[type='checkbox']").attr("checked");
		if(!istrue){
			var html="";
			_chk.prop("checked",true);
			_t.find(".icheckbox_square-green").addClass("checked");
			
			var areaCode= _chk.attr("areaCode");
			var areaOut=$("#td"+id).text();
			
			var html = "<tr id=\"mytr"+id+"\"><td>"+areaCode+"</td>";
			html += "<td>"+areaOut+"</td>";
			html += "<td><input type=\"text\" name=\"ssOrder\" value=\"0\"></td>";
			html += "<td><input type=\"hidden\" name=\"areaCode\" value=\""+id+"\">";
			html += "<a class=\"btn btn-danger delaa\" >删除</a></td></tr>";
			parent.$("#areaTBody").append(html);
			
		}else{
			_chk.prop("checked",false);
			_t.find(".icheckbox_square-green").removeClass("checked");
			parent.$("#mytr"+id).remove();
		}
	})
		$(".confirm").on("click",function(){
			
		parent.layer.closeAll();
	});
});



$("#btn4").on("click",function(){  
	$(".mytr").find("input[type='checkbox']").each(function(){
		var istrue = $(this).is(':checked'); 
		var id = $(this).attr("id");
		if(!istrue){
			var html="";
			$(this).prop("checked",true);
			$(this).parent().addClass("checked");
			
			var areaCode= $(this).attr("areaCode");
			var areaOut=$("#td"+id).text();
			var html = "<tr id=\"mytr"+id+"\"><td>"+areaCode+"</td>";
			html += "<td>"+areaOut+"</td>";
			html += "<td><input type=\"text\" name=\"ssOrder\" value=\"0\"></td>";
			html += "<td><input type=\"hidden\" name=\"areaCode\" value=\""+id+"\">";
			html += "<a class=\"btn btn-danger delaa\" >删除</a></td></tr>";
			parent.$("#areaTBody").append(html);
			
		}else{
			$(this).prop("checked",false);
			$(this).parent().removeClass("checked");
			parent.$("#mytr"+id).remove();
		}
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
</script>
</html>