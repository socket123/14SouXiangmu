<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="../common_resource.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>订单列表</title>
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">


	<style type="text/css">
		.model{
			position: fixed;
			top:0;
			right: 0;
			bottom: 0;
			left:0;
		}
		.model .model-content{
			position: absolute;
			top:50%;
			width: 100%;
			height:230px;
			margin-top: -100px;
			background: #fff;
			-moz-box-shadow: 1px 1px 5px #888888; /* 老的 Firefox */
			box-shadow: 1px 1px 5px #888888;
			padding: 20px;
		}
		.modelWorker .model-content{
			position: absolute;
			top:40%;
			width: 100%;
			height:300px;
			margin-top: -100px;
			background: #fff;
			-moz-box-shadow: 1px 1px 5px #888888; /* 老的 Firefox */
			box-shadow: 1px 1px 5px #888888;
			padding: 20px;
		}
		.model from{
			position: relative;
			z-index: 999;
		}

		#saoyisao{
			height: 32px;
			line-height: 32px;
		}
		#education option{margin-top:3px;}

		.mui-input-row:after{border-bottom:1px solid #ffffff!important;}

		.mui-p-s{word-wrap:break-word; word-break:normal;width: 100%;}
	</style>
	<script type="text/javascript">
        $(function(){
            initNewOrderPosition();
            findMyOrdersNumAndPosition();
            setInterval("myInterval();",30000);//1000为1秒钟

            $("#saoyisao").on("click",function(){
                vrv.jssdk.getInfoWithSweep({
                    success: function (res) {
                        var carryout = (JSON.stringify(res.sweepKey));
                        carryout = eval("("+eval("("+carryout+")")+")");
                        $("#carryout_code").val(carryout.carryoutcode);
                    }
                })
            });
        });

        function myInterval(){
            initNewOrderPosition();
            findMyOrdersNumAndPosition();
        }

        function initNewOrderPosition(){
            $.ajax({
                cache : false,
                async : false,
                type : "POST",
                url :  "${url }font/orderList/unfinishOrders",
                success : function(result) {
                    $("#newOrderPosition").html("");
                    var innnerHTML="";
                    for(var i =0;i<result.length;i++){
                        innnerHTML+="<li onclick='showPostionOrders(\""+result[i].areaCode+"\",1,"+result[i].inCount+","+result[i].outCount+")' class='mui-table-view-cell'><a class='mui-navigate-right distribution-list'>";
                        innnerHTML+=result[i].areaCode;
                        innnerHTML+="<b style='color:#688C20'>(待揽件<span style='color:red'>"+result[i].outCount+"</span>,待送达<span style='color:red'>"+result[i].inCount+"</span>)</b></a></li>";
                    }
                    $("#newOrderPosition").append(innnerHTML);
                },
                error : function(request) {
                    messagerShow("系统消息", '操作失败!!!');
                }
            });
        }

        function showPostionOrders(send_position,status,inCount,outCount){
            //alert(send_position);return;
            window.location.href="${url }font/orderList/showPostionOrders?role=3&send_position="+send_position+"&inCount="+inCount+"&status="+status+"&outCount="+outCount;
        }

        function findMyOrdersNumAndPosition(){
            linkByDom('myOrderPosition','${url }font/orderList/finishOrders');
        }

        function saomiao(){
            vrv.jssdk.getInfoWithSweep({
                success: function (res) {
                    location.href="${url }font/orderList/findOrderDetailByJsonStr?jsonStr="+res.sweepKey;
                }
            });
        }



		

        //回收载具
        function cancelmodel(){
            $(".models").css("display","none");
        }

        function recoveryCarryout() {
            $(".models").css("display","");
        }


        function subDataForm() {
            var carryoutCode = $("#carryout_code").val();
            var position = $("#position").val();
            if(position==null||position==""){
                mui.alert("配载点不能为空！");
                return;
			}
            $.ajax({
                cache : false,
                async : false,
                type : "POST",
                url :  "${url }font/orderList/updateCarryOut",
                data:{carryoutCode:carryoutCode,position:position},
                success : function(resultObj) {
                    if(typeof(resultObj.mess)!="undefined"){
                        mui.alert(resultObj.mess);
                    } else{
                        if(resultObj.messageForCarry==1&&resultObj.message==1){
                            cancelmodel();
                            mui.toast("操作成功");
                        } else if(resultObj.messageForCarry==0&&resultObj.message==1){
                            mui.alert("载具编码不存在");
                        } else{
                            mui.alert("系统消息", '操作失败!!!');
                        }
                    }
                },
                error : function(request) {
                    mui.alert("系统消息", '操作失败!!!');
                }
            });
        }
	</script>
</head>
<body style="background:#fff">
<header id="header" class="mui-bar mui-bar-nav">
	<a href="${url }font/toChoiceRole" class="mui-icon mui-icon-left-nav mui-pull-left"></a>
	<h1 class="mui-title">订单列表</h1>
	<!-- <a onclick="saomiao()" class="mui-icon mui-icon-syswhite mui-pull-right" id="saomiao"></a> -->
</header>
<input type="hidden" class="modeld-url" value="${url}">
<!-- 内容 -->
<div class="mui-content background-white">
	<div >
		<div id="segmentedControl" class="mui-segmented-control mui-segmented-control-inverted mui-segmented-control-primary">
			<a class="mui-control-item mui-active" href="#item1" style="font-size:1rem; letter-spacing: 3px;">
				我的任务
			</a>
			<a onclick="findMyOrdersNumAndPosition()" class="mui-control-item" href="#item2" style="font-size:1rem; letter-spacing: 3px;">
				已完成
			</a>
		</div>
	</div>
	<div>
		<div id="item1" class="mui-control-content mui-active">
			<ul id="newOrderPosition" class="mui-table-view interleave">
			</ul>
			<div class="boottom_btn">
				<button onclick="showMoreNewOrders()" type="button" class="mui-btn mui-btn-royal" style="width:33.33%;float:left;">加载更多</button>
				<button onclick="recoveryCarryout()" type="button" class="mui-btn mui-btn-royal" style="width:33.33%;float:left;">载具回收</button>
				<button onclick="recoveryWorker()" type="button" class="mui-btn mui-btn-royal" style="width:33.33%;float:left;">绑定民工</button>
			</div>
		</div>
		<div id="item2" class="mui-control-content">
			<ul class="mui-table-view interleave" id="myOrderPosition">
				<!-- <li class="mui-table-view-cell">
                    <a class="mui-navigate-right distribution-list">
                        配送点A01<b >(2)</b>
                    </a>
                </li>
                <li class="mui-table-view-cell">
                    <a class="mui-navigate-right distribution-list">
                        配送点A01<b>(2)</b>
                    </a>
                </li>
                <li class="mui-table-view-cell">
                    <a class="mui-navigate-right distribution-list">
                        配送点A01<b>(2)</b>
                    </a>
                </li> -->
			</ul>
		</div>
	</div>
</div>
<!-- 弹出框 -->
<div class="model models" style="display:none" id="model">
	<div class="model-content" >
		<form id="dataForm" method="post">
			<div class="mui-row">
				<div class="mui-col-sm-12 mui-col-xs-12">
					<li class="mui-table-view-cell">
						<span class="mui-col-xs-3 mui-pull-left">配载点</span>
						<div class="mui-col-xs-8 mui-pull-left">
							<input id="position" type="text" name="position" maxlength="13"/>
						</div>
					</li>
				</div>
				<div class="mui-col-sm-12 mui-col-xs-12">
					<li class="mui-table-view-cell">
						<span class="mui-col-xs-3 mui-pull-left">载具编码</span>
						<div class="mui-col-xs-8 mui-pull-left">
							<input id="carryout_code" type="text" name="carryout_code" maxlength="13"/>
						</div>
						<span class="mui-col-xs-1 mui-pull-left sys" id="saoyisao"></span>
					</li>
				</div>
				<div class="form-group col-sm-12 text-center"  >
					<button type="button" class="btn btn-primary" onclick="subDataForm()">确认</button>
					<button type="button" class="btn btn-primary" onclick="cancelmodel()">取消</button>
				</div>
			</div>

		</form>
	</div>
</div>
<!-- 弹出框 -->
<div class="modelWorker model " style="display:none" id="">
	<div class="model-content" >
		<form id="datasForm" method="post">
			<div class="mui-row">
				<div class="mui-col-sm-12 mui-col-xs-12" style="overflow: auto;height: 60px;" >


											<div class=" li-html-apper" >

											</div>

				</div>
				<div class="mui-col-sm-12 mui-col-xs-12" style="overflow: auto;height: 150px;">

					<c:forEach varStatus="vars" var="teamRelationList" items="${teamRelationList}">
						<div class="mui-input-row mui-checkbox mui-left mui-ckefs">
							<label for="">${teamRelationList.userName}：${teamRelationList.telephone}</label>
							<input type="checkbox" names="${teamRelationList.userName}" name="checkbox" value="${teamRelationList.ids}" class="checkbox_class checkboxs"  onclick="click_checkbox_class()">
						</div>
					</c:forEach>
					<c:forEach varStatus="vars" var="ssUserList" items="${ssUserList}">
						<div class="mui-input-row mui-checkbox mui-left mui-ckefs">
							<label for="">${ssUserList.userName}：${ssUserList.telephone}</label>
							<input type="checkbox" names="${ssUserList.userName}" name="checkbox" value="${ssUserList.id}" class="checkbox_class"  onclick="click_checkbox_class()">
						</div>
					</c:forEach>

				</div>

				<div class="form-group col-sm-12 text-center"  >
					<button type="button" class="btn btn-primary" onclick="subDataForm_work()">确认</button>
					<button type="button" class="btn btn-primary" onclick="cancelmodel_work()">取消</button>
				</div>
			</div>

		</form>
	</div>
</div>
</body>

<script type="text/javascript" src="${url }/statics/js/page/distribution.js"></script>
</html>