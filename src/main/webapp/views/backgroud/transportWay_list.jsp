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
        <div class="right col-sm-12">
        <div class="clearfix">
            <div class="clearfix  col-xs-12" style="margin-top:20px;" >
                <form class="form-horizontal col-xs-12" method="post" action="${url }admin/transportWay/gotoTransportWayList">
                        <!-- 一行开始 -->
                       <div class="form-group">
                            <div class="col-xs-12">
                                <div class="row">
                                    <!-- 一组开始 -->
                                    <div class="col-xs-7">
                                        <label  class="col-xs-4 control-label">运输方式:</label>
                                        <div class="col-xs-8 ">
                                              <input type="text" class="form-control" name="transportType" id="transportType" value="${transportWay.transportType }">
                                        </div>
                                    </div>
                                    <!-- 一组结束 -->
                                    <div class="col-xs-4">
                                         <div class="col-xs-3 ">
                                            <button type="sumbit" class="btn btn-primary search" >搜索</button>
                                         </div>
                                          <div class="col-xs-3 ">
                                            <button type="button" class="btn btn-primary search" onclick="addTransportWay()" >新增</button>
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
                                        <th>运输方式</th>
                                        <th>备注</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                   <c:forEach items="${page.list}" var="m">
                                    <tr>
                                        <td>${m.transportType }</td>
                                        <td>${m.remark }</td>
                                        <td> <fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.createTime}" /></td>
                                         <td>
                                        	<a class="btn btn-warning" onclick="editTransportWay(${m.id})">编辑</a>
                                            <a class="btn btn-warning" onclick="deleteTransportWay(${m.id})">删除</a>
                                        </td>
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
<script type="text/javascript">
function addTransportWay(){
	window.location.href="${url}admin/transportWay/gotoAddTransportWay"
}

function editTransportWay(id){
	window.location.href="${url}admin/transportWay/gotoEditTransportWay?id="+id;
}


$('#page-jq').jqPaginator({
    totalPages: parseInt('${page.pages }'),
    visiblePages: 5,
    currentPage: parseInt('${page.pageNumber }'),
    onPageChange:function(num,type){
    	if(type == 'change'){
	    	//resetP('invitecode','currentIndex='+num);
	    	window.location.href="${url}admin/transportWay/gotoTransportWayList?pageNumber="+num;
    	}
    }
});


function deleteTransportWay(id){
	$.ajax({
        url : '${url }admin/transportWay/deleteTransportWay',
        type:'post',
        data:{id:id},
        success:function(result)
        {
          if(result.message==1){
        	 layer.alert("运输方式删除成功!",function(){
        	 window.location.href="${url}admin/transportWay/gotoTransportWayList";
        	 });
          }else{
        	 layer.alert("运输方式删除失败!",function(){
        	 window.location.href="${url}admin/transportWay/gotoTransportWayList";
        	 });
          }
        }
    });
}

</script>
</body>
</html>