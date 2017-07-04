<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../base.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源列表</title>
<style>
#resourceUl,#resourceUl li{
	list-style: none;
}
#resourceUl .fa{
 margin-right: 3px;
}
</style>
</head>
<body>
       <div class="row col-sm-3">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>资源列表</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div id="jstree1">
                                    <ul id="resourceUl">
                                      
                                        
                                    </ul>
                               
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- 右侧 -->
        <div class="right col-sm-9">
        <div class="clearfix">
            <div class="clearfix  col-xs-12" style="margin-top:20px;" >
                <form class="form-horizontal col-xs-12" method="post" action="${url }admin/resou/gotoResourceList">
                        <!-- 一行开始 -->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <!-- 一组开始 -->
                                    <div class="col-xs-5">
                                        <label  class="col-xs-4 control-label">资源名称:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="rname" id="rName" value="${ssResource.rname }">
                                        </div>
                                    </div>
                                    <!-- 一组结束 -->
                                    <div class="col-xs-4">
                                         <div class="col-xs-12 ">
                                            <button type="sumbit" class="btn btn-primary" >搜索</button>
                                            <button type="button" class="btn btn-primary" onclick="addResource()">新增</button>
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
                                        <th>资源名称</th>
                                        <th>数量</th>
                                        <th>备注</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                   <c:forEach items="${page.list}" var="m">
                                    <tr>
                                        <td>${m.rname }</td>
                                        <td>${m.number }</td>
                                        <td>${m.remark }</td>
                                        <td>
                                          <fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.createTime}" />
                                        </td>
                                        <td>
                                        	<a class="btn btn-warning" onclick="edit(${m.id})"> 编辑</a>
                                        	<a class="btn btn-warning" onclick="deleteResource(${m.id})"> 删除</a>
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
        </div>
</body>
<script src="${url }js/jqPaginator.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	rList();
});
function showIndex(id){
	 window.location.href="${url}admin/resou/gotoResourceList?catagoryId="+id;
}


function showChildRen(id){
	 window.location.href="${url}admin/resou/gotoResourceList?id="+id;
}
function rList(){
	var appendStr="";
	$.ajax({
        url : '${url }admin/resou/findCatagoryList',
        type:'post',
        success:function(result)
        {
        	var id_index=0;
          $("#resourceUl").html("");
        	for(var i=0;i<result.length;i++){
        		for(var itemName in result[i]){
        			if(itemName.indexOf("_id")<0){
        				id_index = result[i][itemName+"_id"];
	        			appendStr+="<li><a onclick='showIndex("+id_index+")'><i class='fa fa-folder-open'></i>";
	        			appendStr+=itemName;
	        			appendStr+="</a>";
	        			appendStr+="<ul>";
	        			for(var j = 0;j<result[i][itemName].length;j++){
	        					appendStr+="<a onclick='showChildRen("+result[i][itemName][j].id+")'><li data-jstree='{'type':'css'}'><i class='fa fa-file'></i>"+result[i][itemName][j].rname+"</li></a>";
	        			}
	        			appendStr+="</ul></li>";
        			}
        		}
        	}
        	 $("#resourceUl").append(appendStr);
        }
    });
}

$('#page-jq').jqPaginator({
    totalPages: parseInt('${page.pages }'),
    visiblePages: 5,
    currentPage: parseInt('${page.pageNumber }'),
    onPageChange:function(num,type){
    	if(type == 'change'){
	    	//resetP('invitecode','currentIndex='+num);
	    	var rname=$("#rName").val();
	    	window.location.href="${url}admin/resou/gotoResourceList?pageNumber="+num+"&rname="+rname;
    	}
    }
});

function addResource(){
	window.location.href="${url}admin/resou/gotoAdd";
}


function edit(id){
	window.location.href="${url}admin/resou/gotoEdit?id="+id;
}

function deleteResource(id){
	$.ajax({
        url : '${url }admin/resou/deleteResource',
        type:'post',
        data:{id:id},
        success:function(result)
        {
          if(result.message==1){
        	 layer.alert("资源删除成功!",function(){
        	 window.location.href="${url}admin/resou/gotoResourceList";
        	 });
          }else{
        	 layer.alert("资源删除失败!",function(){
        	 window.location.href="${url}admin/resou/gotoResourceList";
        	 });
          }
        }
    });
}
</script>
</body>
</html>