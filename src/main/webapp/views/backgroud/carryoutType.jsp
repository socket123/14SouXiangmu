<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>载具分类</title>
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
                        <div class="col-xs-5">
                            <label  class="col-xs-4 control-label">载具分类名称:</label>
                            <div class="col-xs-8 ">
                                <input type="text" class="form-control" name="name" id="name" value="${carryoutType.name }">
                            </div>
                        </div>
                        <!-- 一组结束 -->
                        <div class="col-xs-2">
                            <div class="col-xs-12 ">
                                <a type="sumbit" class="btn btn-primary search" >搜索</a>
                                <button type="button" class="btn btn-primary" onclick="addCarryoutType()">新增</button>
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
                            <th>分类名称</th>
                            <th>所属父级 </th>
                            <th>备注</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="m">
                            <tr>
                                <td>${m.name }</td>
                                <td>${m.pname }</td>
                                <td>${m.remark }</td>
                                <td>
                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.creatTime}" />
                                </td>
                                <td>
                                    <a class="btn btn-warning" onclick="edit(${m.id})"> 编辑</a>
                                    <a class="btn btn-warning" onclick="deleteCarryoutType(${m.id})"> 删除</a>
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
</body>
<script src="${url }js/jqPaginator.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".search").on("click",function(){
            location.href = "${url }admin/carryoutType?"+$("#searchForm").serialize();
        });
    });

    $('#page-jq').jqPaginator({
        totalPages: parseInt('${page.pages }'),
        visiblePages: 5,
        currentPage: parseInt('${page.pageNumber }'),
        onPageChange:function(num,type){
            if(type == 'change'){
                //resetP('invitecode','currentIndex='+num);
                var name=$("#name").val();
                window.location.href="${url }admin/carryoutType?pageNumber="+num+"&name="+name;
            }
        }
    });

    function addCarryoutType(){
        window.location.href="${url}admin/carryoutType/gotoCarryoutTypeAdd";
    }


    function edit(id){
        window.location.href="${url}admin/carryoutType/gotoEdit?id="+id;
    }

    function deleteCarryoutType(id){
        $.ajax({
            url : '${url }admin/carryoutType/deleteCarryoutType',
            type:'post',
            data:{id:id},
            success:function(result)
            {
                if(result.message==1){
                    layer.alert("载具分类删除成功!",function(){
                        window.location.href="${url}admin/carryoutType";
                    });
                }else{
                    if(typeof(result.mess)!="undefined"){
                        layer.alert(result.mess,function(){
                            window.location.href="${url}admin/carryoutType";
                        });
                    } else{
                        layer.alert("载具分类删除失败!",function(){
                            window.location.href="${url}admin/carryoutType";
                        });
                    }
                }
            }
        });
    }
</script>
</html>