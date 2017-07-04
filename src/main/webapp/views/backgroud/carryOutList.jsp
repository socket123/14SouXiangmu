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
    <title>载具编码列表</title>
    <style type="text/css">
        .model{
            position: fixed;
            top:0;
            right: 0;
            bottom: 0;
            left:0;
            z-index:1;
        }
        .model .model-content{
            position: absolute;
            top:50%;
            left:50%;
            width: 410px;
            height:170px;
            margin-top: -100px;
            margin-left: -250px;
            background: #fff;
            -moz-box-shadow: 1px 1px 5px #888888; /* 老的 Firefox */
            box-shadow: 1px 1px 5px #888888;
            padding: 20px;
        }

        #QRmodel .model-content{
            width: 410px;
            height:200px;
        }
        #qrcode{width:100px;height:100px;margin:10px auto;}
        .model from{
            position: relative;
            z-index: 999;
        }
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
                    <div class="row">
                        <!-- 一组开始 -->
                        <div class="col-xs-4">
                            <label  class="col-xs-4 control-label">当前所属配载点:</label>
                            <div class="col-xs-8 ">
                                <input type="text" class="form-control" name="position" id="position" value="${carryOut.position }">
                            </div>
                        </div>
                        <div class="col-xs-4">
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
                                <button type="button" class="btn btn-primary" onclick="addCarryout()">新增</button>
                                <button type="button" class="btn btn-info" style="position: relative;width: 53px;height: 34px;" id="importForm" onclick="importExcel()">导入</button>
                                <button type="button" class="btn btn-info" style="position: relative;width: 53px;height: 34px;" onclick="exportExcelList()">导出</button>
                                <button type="button" class="btn btn-success" style="position: relative;width: 80px;height: 34px;" id="ExportForm" onclick="exportExcel()">下载模板</button>
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
                            <th>编码</th>
                            <th>图号</th>
                            <th>所属部门</th>
                            <th>状态</th>
                            <th>所属分类</th>
                            <th>描述</th>
                            <th>使用情况</th>
                            <th>当前所属</th>
                            <th>最后一次使用时间</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="m">
                            <tr>
                                <td>${m.carryoutCode }</td>
                                <td>${m.figurenum }</td>
                                <td>${m.carryoutDeptName }</td>
                                <td>${m.carryoutStateName }</td>
                                <td>${m.pname }</td>
                                <td>${m.depict }</td>
                                <td>
                                    <c:if test="${fn:indexOf(m.status, '0') >= 0}">未使用 </c:if>
                                    <c:if test="${fn:indexOf(m.status, '1') >= 0}">使用中</c:if>
                                </td>
                                <td>
                                    <c:if test="${fn:indexOf(m.status, '0') >= 0}">${m.position } </c:if>
                                    <c:if test="${fn:indexOf(m.status, '1') >= 0}">${m.teamName }</c:if>
                                </td>
                                <td>
                                    <c:if test="${m.lastTime!=null}"><fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.lastTime}" /></c:if>
                                    <c:if test="${m.lastTime==null}"></c:if>
                                </td>
                                <td>
                                    <c:if test="${m.createTime!=null}"><fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${m.createTime}" /></c:if>
                                    <c:if test="${m.createTime==null}"></c:if>
                                </td>
                                <td>
                                    <a class="btn btn-warning" onclick="editCarryOut(${m.id})">编辑</a>
                                        <a class="btn btn-warning" onclick="deleteCarryout(${m.id})"> 删除</a>
                                    <a class="btn btn-warning qrcodeBtn" carryoutCode="${m.carryoutCode}">条码</a>
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
<!-- 弹出框 -->
<div class="model" style="display:none" id="model">
    <div class="model-content" >
        <form id="dataForm" method="post">
            <div class="form-group">
                <label for class="col-sm-3">上传文件:</label>
                <input type="file" name="uploadFile" id="uploadFile" class="col-sm-7" />
            </div>
            <br>
            <br>
            <br>
            <div class="form-group col-sm-12 text-center"  >
                <button type="button" class="btn btn-primary" id="subDataForm">上传</button>
                <a class="btn btn-primary" onclick="cancelmodel()">取消</a>
            </div>
        </form>
    </div>
</div>

<div class="model" style="display:none" id="QRmodel">
    <div class="model-content" >
        <div id="qrcode" <%--style="margin-top:10px;"--%>></div>
        <div class="form-group col-sm-12 text-center"  >
            <%--<button type="button" class="btn btn-primary" id="">上传</button>--%>
            <a class="btn btn-primary" onclick="cancelmodel()">取消</a>
        </div>
    </div>
</div>
</body>
<script src="${url }js/jqPaginator.js"></script>
<script src="${url }js/plugins/QRCode/qrcode.min.js"></script>
<script type="text/javascript">
    var qrcode = new QRCode(document.getElementById("qrcode"), {
        width : 100,
        height : 100
    });
    $(document).ready(function(){
        $(".search").on("click",function(){
            location.href = "${url }admin/carryOut/carryOutlist?"+$("#searchForm").serialize();
        })
        $(".updstatus").on("click",function(){
            var _t = $(this);
            var _tr = _t.parents("tr");
            var id = _t.attr("id");
            var status = _t.attr("status");
            $.post("${url}admin/carryOut/carryOutUpdateStatus",{id:id,isEnable:status},function(data){
                if(data.code > 0){
                    layer.msg("操作成功！", {icon: 1});
                    if(status == "1"){
                        _t.removeClass("btn-success");
                        _t.addClass("btn-danger");
                        _t.text("禁用");
                        _t.removeAttr("status")
                        _t.attr("status","0");
                        _tr.find("td:eq(3)").text("否");
                    }else{
                        _t.removeClass("btn-danger");
                        _t.addClass("btn-success");
                        _t.text("启用");
                        _t.removeAttr("status")
                        _t.attr("status","1");
                        _tr.find("td:eq(3)").text("是");
                    }
                }else{
                    layer.msg("操作失败！")
                }
            });
        });

        $("body").on("click",".qrcodeBtn",function(){
            $("#QRmodel").css("display","");
            var carryoutCode = "{\"carryoutcode\":\""+$(this).attr("carryoutCode")+"\"}";
            qrcode.makeCode(carryoutCode);
        });
    });

    $('#page-jq').jqPaginator({
        totalPages: parseInt('${page.pages }'),
        visiblePages: 5,
        currentPage: parseInt('${page.pageNumber }'),
        onPageChange:function(num,type){
            if(type == 'change'){
                location.href = "${url }admin/carryOut/carryOutlist?pageNo="+num+"&"+$("#searchForm").serialize();
            }
        }
    });



    function importExcel(){
        $("#model").css("display","");
    }
    function cancelmodel(){
        $(".model").css("display","none");
    }
    //ajax异步上传附件
    $("#subDataForm").click(
        function() {
            //判断是否有选择上传文件
            var uploadFile = $("#uploadFile").val();
            if (uploadFile == "") {
                layer.alert("提示", "请上传excel！");
                return;
            }
            //判断上传文件的后缀名
            var strExtension = (uploadFile
                .substr(uploadFile.lastIndexOf('.') + 1)).toLowerCase();
            if (strExtension != 'xls' && strExtension != 'xlsx') {
                layer.alert("提示", "上传的文件格式不对,支持xls,xlsx");
                return;
            }
            var data = new FormData();
            $.each($('#uploadFile')[0].files, function(i, file) {
                data.append('file', file);
            });

            $.ajax({
                url : "${url}/admin/carryOut/importCarryOut",
                type : 'POST',
                data : data,
                cache : false,
                contentType : false, //不可缺
                processData : false, //不可缺
                success : function(result) {
                    var loadindex = layer.load();
                    var msg="";
                    if(result.result==1){
                        if(result.alreayjobNum!=""||result.unFullJobNum!=""){
                            msg+="部分导入成功!";
                            if(result.alreaycarryOutNo!=""){
                                msg+="载具编码为:"+result.alreayjobNum+"的载具已存在并进行了修改!";
                            }
                            if(result.unFullcarryOutNo!=""){
                                msg+="载具编码为:"+result.unFullJobNum+"的excel表格数据不完整!";
                            }
                        }else{
                            msg+="导入成功";
                        }
                        layer.alert(msg,function(){
                            window.location.href="${url}admin/carryOut/carryOutlist";
                            $("#model").css("display","none");
                        });
                    }else{
                        msg+="导入失败!";
                        if(result.alreayjobNum!=""){
                            msg+="载具编码为:"+result.alreayjobNum+"的载具已存在!";
                        }
                        if(result.unFullJobNum!=""){
                            msg+="载具编码为:"+result.unFullJobNum+"的excel表格数据不完整!";
                        }
                        layer.alert(msg,function(){
                            window.location.href="${url}admin/carryOut/carryOutlist";
                            $("#model").css("display","none");
                        });
                    }
                    layer.close(loadindex);
                }
            });
        });


    function exportExcel(){
        window.location.href="${url}/admin/carryOut/exportExcel"
    }

    function editCarryOut(id){
        window.location.href="${url}admin/carryOut/toCarryOutEdit?id="+id;
    }

    function deleteCarryout(id){
        $.ajax({
            url : '${url }admin/carryOut/deleteCarryout',
            type:'post',
            data:{id:id},
            success:function(result)
            {
                if(result.message==1){
                    layer.alert("载具删除成功!",function(){
                        window.location.href="${url}admin/carryOut/carryOutlist";
                    });
                }else{
                    if(typeof(result.mess)!="undefined"){
                        layer.alert(result.mess,function(){
                            window.location.href="${url}admin/carryOut/carryOutlist";
                        });
                    } else{
                        layer.alert("载具分类失败!",function(){
                            window.location.href="${url}admin/carryOut/carryOutlist";
                        });
                    }
                }
            }
        });
    }

    function addCarryout(){
        window.location.href="${url}admin/carryOut/gotoCarryoutAdd";
    }

    function exportExcelList(){
        var position=$("#position").val();
        var teamId=$("#teamId").val();
        window.location.href='${url}admin/carryOut/exportCarryOutExcel?position='+position+"&teamId="+teamId;

    }


</script>
</html>
