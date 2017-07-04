<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>订单趋势分析</title>
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
                            <label  class="col-xs-2 control-label">选择时间：</label>
                            <div class="col-xs-10 ">
                                <input type="date" class="form-control" name="startTime" style="width:45%;display:inline-block;" id="startTime" value="${startTime}">
                            </div>
                        </div>
                        <!-- 一组结束 -->
                        <div class="col-xs-4">
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
        var yAxisArray = [];
        <c:forEach var="v" items="${order}" varStatus="">
        xAxisArray.push('${v.send_position}');
        yAxisArray.push(${v.workload});
        </c:forEach>
        setLine(xAxisArray,yAxisArray);

        $(".search").click(function(){
            window.location.href="${url }admin/orderAll/orderAnalysis?startTime="+$("#startTime").val();
        });
    });

    function setLine(xAxisArray,yAxisArray){
        $("#container").highcharts({
            exporting:{
                enabled:false
            },
            credits: {
                enabled: false
            },
            title: {
                text: "订单趋势分析" //图表的名称
            },
            legend: {
                align: 'right', //水平方向位置
                verticalAlign: 'top', //垂直方向位置
                borderWidth: 0
            },
            xAxis: {
                categories: xAxisArray,
                tickWidth: 0,
                labels: {
                    enabled: false
                }
            },
            yAxis: {
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            series: [{
                name: "各片区",
                data: yAxisArray,
                marker: {
                    enabled: false
                }
            }]
        });
    }
</script>
</html>
