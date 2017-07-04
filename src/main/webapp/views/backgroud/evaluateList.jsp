<%--
  Created by IntelliJ IDEA.
  User: LXX
  Date: 2017-04-27
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>订单评价列表</title>
    <style type="text/css">

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
                    <%--<div class="row">
                        <!-- 一组开始 -->
                        <div class="col-xs-3">
                            <label  class="col-xs-4 control-label">当前所属团队:</label>
                            <div class="col-xs-8 ">
                                <select class="form-control" name="teamId" id="teamId">
                                    <option value="" ></option>
                                    <c:forEach items="${transportTeam}" var="v">
                                        <option value="${v.id}" <c:if test="${carryOut.teamId == v.id}">selected="selected"</c:if> >${v.teamName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <!-- 一组结束 -->
                        <div class="col-xs-4">
                            <div class="col-xs-12 ">
                                <a type="sumbit" class="btn btn-primary search" >搜索</a>
                            </div>
                        </div>
                    </div>--%>
                        <div class="row">
                            <div class="col-xs-4">
                                <div class="col-xs-12 ">
                                    <a type="sumbit" class="btn btn-primary search" >统计图表</a>
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
                            <th>订单编码</th>
                            <th>发货方/收货方</th>
                            <th>运输人员</th>
                            <th>服务态度</th>
                            <th>及时性</th>
                            <th>服务质量</th>
                            <th>意见与建议</th>
                            <th>评价用户</th>
                            <th>评价时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="m">
                            <tr>
                                <td>${m.waybillNumber }</td>
                                <td>
                                    <c:if test="${fn:indexOf(m.sendorreci, 's') >= 0}">发货方 </c:if>
                                    <c:if test="${fn:indexOf(m.sendorreci, 'r') >= 0}">收货方</c:if>
                                </td>
                                <td>${m.courierName }</td>
                                <td>${m.serviceAttitude }</td>
                                <td>${m.timeliness }</td>
                                <td>${m.serviceQuality }</td>
                                <td>
                                    <c:if test="${m.ifDefault==1}">默认评价</c:if>
                                    <c:if test="${m.ifDefault==0}">${m.remark }</c:if>
                                </td>
                                <td>${m.userName }</td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.createTime}" /></td>
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
            location.href = "${url }admin/evaluate/evaluateAnalysis"
        });

        $('#page-jq').jqPaginator({
            totalPages: parseInt('${page.pages }'),
            visiblePages: 5,
            currentPage: parseInt('${page.pageNumber }'),
            onPageChange:function(num,type){
                if(type == 'change'){
                    window.location.href="${url }admin/evaluate/evaluatelist?pageNumber="+num+"";
                }
            }
        });

    });
</script>
</html>
