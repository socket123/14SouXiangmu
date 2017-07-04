<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>订单申请</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <style type="text/css">
        .raty-cancel,.hint{display: none;}
        .target-demo{float: left;  line-height: 32px;}
    </style>
    <script type="text/javascript" src="${url }js/plugins/start/jquery.raty.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $.fn.raty.defaults.path = '${url }/img';
            $('#star').raty({
                cancel    : true,
                targetKeep: true,
                score: 4
            });
            $('#star1').raty({
                cancel    : true,
                targetKeep: true,
                score: 4
            });
            $('#star2').raty({
                cancel    : true,
                targetKeep: true,
                score: 4
            });
        });

        function submitForm(orderId){
            var service_attitude = $("#star").find("input[name='score']").val();
            var timeliness = $("#star1").find("input[name='score']").val();
            var service_quality = $("#star2").find("input[name='score']").val();
            var remark = $("textarea[name='remark']").val();
            $.ajax({
                cache : false,
                async : false,
                type : "POST",
                url :  "${url }font/orderList/addEvaluateOrder",
                data:{orderId:orderId,service_attitude:service_attitude,timeliness:timeliness,service_quality:service_quality,remark:remark},
                success : function(resultObj) {
                    if(resultObj.message>0){
                        mui.alert("操作成功",function(){
                            window.location.href="${url }font/orders";
                        });
                    } else{
                        mui.alert("系统消息", '操作失败!!!');
                    }
                },
                error : function(request) {
                    mui.alert("系统消息", '操作失败!!!');
                }
            });
        }
    </script>
<body class="orders" style="background:#fff">
<header id="header" class="mui-bar mui-bar-nav">
    <h1 class="mui-title">订单申请</h1>
    <a class="mui-btn mui-btn-link mui-btn-nav mui-pull-left" href="${url }font/orders" style="color:#FFF"><span class="mui-icon mui-icon-left-nav"></span>返回</a></header>
<form id="evaluateForm">

    <div class="mui-content" style="margin-top:44px;">
    <div class="mui-col-sm-12 mui-col-xs-12">
        <li class="mui-table-view-cell">
            <span class="mui-col-xs-3 mui-pull-left">服务态度</span>
            <div class="mui-col-xs-8 mui-pull-left">
                <div class="demo">
                    <div id="star" class="target-demo"></div>
                    <div id="hint" class="hint"></div>
                </div>
            </div>
        </li>
    </div>
        <div class="mui-col-sm-12 mui-col-xs-12">
            <li class="mui-table-view-cell">
                <span class="mui-col-xs-3 mui-pull-left">及时性</span>
                <div class="mui-col-xs-8 mui-pull-left">
                    <div class="demo">
                        <div id="star1" class="target-demo"></div>
                        <div id="hint1" class="hint"></div>
                    </div>
                </div>
            </li>
        </div>
        <div class="mui-col-sm-12 mui-col-xs-12">
            <li class="mui-table-view-cell">
                <span class="mui-col-xs-3 mui-pull-left">服务质量</span>
                <div class="mui-col-xs-8 mui-pull-left">
                    <div class="demo">
                        <div id="star2" class="target-demo"></div>
                        <div id="hint2" class="hint"></div>
                    </div>
                </div>
            </li>
        </div>
    <div class="mui-padd-10   addressee">
        <p class="address-title">意见与建议</p>
        <div class="mui-table-view mui-grid-view mui-grid-9 ">
            <div class="mui-table-view-cell  mui-col-xs-1 ">
            </div>
            <div class="mui-table-view-cell  mui-col-xs-10 ">
                <div class="mui-table-view mui-grid-view mui-grid-9">
                    <div class="mui-table-view-cell  mui-col-xs-2 ">
                        <span class="fa fa-edit" ></span>
                    </div>
                    <div class="mui-table-view-cell  mui-col-xs-10 ">
                        <textarea class="textarea" name="remark">${order.remark }</textarea>
                    </div>
                </div>
            </div>
            <div class="mui-table-view-cell  mui-col-xs-1 ">
            </div>
        </div>
    </div>

    <div style="height:60px;"></div>
    <div class="boottom_btn">
        <button onclick="submitForm(${order.id})" type="button" class="mui-btn mui-btn-royal mui-btn-block">提交评价</button>
    </div>
    </div>

</form>

</body>
</html>
