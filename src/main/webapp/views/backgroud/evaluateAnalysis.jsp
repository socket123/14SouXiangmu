<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>评价情况分析</title>
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
                            <label  class="col-xs-4 control-label">当前所属团队:</label>
                            <div class="col-xs-8 ">
                                <select class="form-control" name="teamId" id="teamId">
                                    <option value="" <c:if test='${teamId == ""}'>selected="selected"</c:if>>==全部==</option>
                                    <c:forEach items="${transportTeam}" var="v">
                                        <option value="${v.id}" <c:if test="${teamId == v.id}">selected="selected"</c:if> >${v.teamName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-xs-5">
                            <label  class="col-xs-2 control-label">时间段：</label>
                            <div class="col-xs-10 ">
                                <input type="date" class="form-control" name="startTime" style="width:45%;display:inline-block;" id="startTime" value="${startTime }">
                                --
                                <input type="date" class="form-control" name="endTime" style="width:45%;display:inline-block;" id="endTime" value="${endTime }">
                            </div>
                        </div>
                        <!-- 一组结束 -->
                        <div class="col-xs-4">
                            <div class="col-xs-12 ">
                                <a type="sumbit" class="btn btn-primary search" >搜索</a>
                                <a type="sumbit" class="btn btn-primary listbtn" >返回列表</a>
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
        <div id="container" style="min-width:400px;height:400px"></div>
    </div>
</div>
<script src="${url}js/plugins/highcharts/highcharts.js"></script>
<script src="${url}js/plugins/highcharts/exporting.js"></script>
<script src="${url}js/plugins/highcharts/highcharts-zh_CN.js"></script>
</body>
<script type="text/javascript">
    $(document).ready(function(){
        var xAxisArray = [];
        var yAxisArray1 = [];
        var yAxisArray2 = [];
        var yAxisArray3 = [];
        <c:forEach var="v" items="${evaluate}" varStatus="">
        xAxisArray.push('${v.teamName}');
        yAxisArray1.push(${v.serviceAttitude});
        yAxisArray2.push(${v.timeliness});
        yAxisArray3.push(${v.serviceQuality});
        </c:forEach>
        setLine(xAxisArray,yAxisArray1,yAxisArray2,yAxisArray3);

        $(".search").on("click",function(){
            location.href = "${url }admin/evaluate/evaluateAnalysis?"+$("#searchForm").serialize();
        });

        $(".listbtn").on("click",function(){
            location.href = "${url }admin/evaluate/evaluatelist"
        });
    });

    function setLine(xAxisArray,yAxisArray1,yAxisArray2,yAxisArray3){
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
                text: '订单评价分析'
            },
            xAxis: {
                categories: xAxisArray,
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: '评分'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: '服务态度',
                data: yAxisArray1
            }, {
                name: '及时性',
                data: yAxisArray2
            }, {
                name: '服务质量',
                data: yAxisArray3
            }]
        });
    }


</script>
</html>
