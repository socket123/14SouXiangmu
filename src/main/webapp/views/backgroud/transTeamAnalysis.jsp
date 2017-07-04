<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>运输人员相关分析</title>
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
                                <label  class="col-xs-4 control-label">人员：</label>
                                <div class="col-xs-7 ">
                                    <select class="form-control" name="searchFlag" id="searchFlag">
                                        <option value="0" <c:if test='${searchFlag ==0}'>selected="selected"</c:if>>团队</option>
                                        <option value="1" <c:if test='${searchFlag ==1}'>selected="selected"</c:if>>团队负责人</option>
                                        <option value="2" <c:if test='${searchFlag ==2}'>selected="selected"</c:if>>民工</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label  class="col-xs-2 control-label">时间段：</label>
                                <div class="col-xs-10 ">
                                    <input type="date" class="form-control" name="startTime" style="width:45%;display:inline-block;" id="startTime" value="${startTime }">
                                    --
                                    <input type="date" class="form-control" name="endTime" style="width:45%;display:inline-block;" id="endTime" value="${endTime }">
                                </div>
                            </div>
                            <!-- 一组结束 -->
                            <div class="col-xs-3">
                                <div class="col-xs-12 ">
                                    <a type="sumbit" class="btn btn-primary search" >搜索</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

<%--中件--%>

<input type="hidden" value="" class="">
<input type="hidden" value="" class="">
<input type="hidden" value="" class="">
<%--大件--%>
<input type="hidden" value="" class="">
<input type="hidden" value="" class="">
<input type="hidden" value="" class="">

<div class="row">
    <div class="col-sm-12">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <%--显示 ${page.offset } 到--%>
                <%--<c:set var="endset" value="${page.offset + page.limit}"/>--%>
                <%--<c:if test="${endset > page.total }">${page.total }</c:if>--%>
                <%--<c:if test="${endset <= page.total }">${endset }</c:if>--%>
                <%--项，--%>
                共 ${page.total } 项</div>
            <div class="ibox-content">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>名称</th>

                            <th>小件</th>
                            <th>中件</th>
                            <th>大件</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="m">
                            <tr>
                                <td>${m.user_name }</td>
                                <td>${m.is_big_xiao }</td>
                                <td>${m.is_big_zhong }</td>
                                <td>${m.is_big_big }</td>

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
<script src="${url}js/plugins/highcharts/highcharts.js"></script>
<script src="${url}js/plugins/highcharts/exporting.js"></script>
<script src="${url}js/plugins/highcharts/drilldown.js"></script>
<script src="${url}js/plugins/highcharts/highcharts-zh_CN.js"></script>
</body>
<script type="text/javascript">
$(document).ready(function(){
    var yAxisArray = [];
    var yAxisArrayBelow = [];
    var yAxisArrayData = [];

    <c:forEach var="t" items="${transpostTeam}" varStatus="">
    yAxisArray.push({name: '${t.teamName}',
                    y: ${t.orderdata},
                    drilldown: ${t.id}
    });
        <c:forEach var="u" items="${transpostTeamUser[t.id]}" varStatus="">
            yAxisArrayData.push(['${u.teamName}',${u.orderdata}]);
       </c:forEach>
        yAxisArrayBelow.push({name: '${t.teamName}',
            id: ${t.id},
            data: yAxisArrayData
        });
        yAxisArrayData = [];
    </c:forEach>
    $(".search").click(function(){
        window.location.href="${url }admin/transTeam/transTeamAnalysis?startTime="+$("#startTime").val()+"&endTime="+$("#endTime").val()+"&searchFlag="+$("#searchFlag").val();
    });
    setLine(yAxisArray,yAxisArrayBelow);

});

function setLine(yAxisArray,yAxisArrayBelow){
    $("#container").highcharts({
        chart: {
            type: 'column'
        },
        exporting:{
            enabled:false
        },
        credits: {
            enabled: false
        },
        title: {
            text: '运输团队工作量统计'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            title: {
                text: '派件数'
            }
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true
                }
            }
        },
        series: [{
            name: '运输团队',
            colorByPoint: true,
            data: yAxisArray
        }],
        drilldown: {
            series: yAxisArrayBelow
        }
    });
}


</script>
</html>
