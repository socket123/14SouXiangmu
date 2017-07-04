<%--
  Created by IntelliJ IDEA.
  User: LXX
  Date: 2017-04-27
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>编辑载具</title>
    <link rel="stylesheet" type="text/css" href="${url }css/plugins/zTree/zTreeStyle/zTreeStyle.css"/>
</head>
<body>
<div class="ibox-content">
    <form id="saveForm" class="form-horizontal m-t">
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">载具编码:</label>
            <div class="col-sm-9">
                <input type="text" name="carryoutCode" id="carryoutCode" value="${carryOut.carryoutCode }" class="form-control" readonly="readonly">
                <div id="qrcode" style="margin-top:10px;"></div>
                <input type="hidden" value="${carryOut.id}" id="userId">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">图号:</label>
            <div class="col-sm-9">
                <input type="text" name="figurenum" id="figurenum" value="${carryOut.figurenum }" class="form-control">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">所属部门:</label>
            <div class="col-sm-9">
                <select class="form-control" name="carryoutDeptid" id="carryoutDeptid">
                    <option value="" <c:if test='${carryOut.carryoutDeptid == ""}'>selected="selected"</c:if>></option>
                    <c:forEach items="${carryoutDept}" var="v">
                        <option value="${v.id}" <c:if test="${carryOut.carryoutDeptid == v.id}">selected="selected"</c:if> >${v.deptName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">状态:</label>
            <div class="col-sm-9">
                <select class="form-control" name="carryoutStateid" id="carryoutStateid">
                    <option value="" <c:if test='${carryOut.carryoutStateid == ""}'>selected="selected"</c:if>></option>
                    <c:forEach items="${carryoutState}" var="v">
                        <option value="${v.id}" <c:if test="${carryOut.carryoutStateid == v.id}">selected="selected"</c:if> >${v.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">所属分类:</label>
            <input type="hidden" id="carryoutTypeid" name="carryoutTypeid" value="${carryOut.carryoutTypeid }">
            <input type="hidden" id="carryoutType" name="carryoutType" value="${carryOut.carryoutType }">
            <input type="hidden" id="carryoutTypename" name="carryoutTypename" value="${carryOut.carryoutTypename }">
            <div class="col-sm-9">
                <ul id="treeDemo" class="ztree" valign="top"></ul>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">描述:</label>
            <div class="col-sm-9">
                <input type="text" name="depict" id="depict" value="${carryOut.depict }" class="form-control">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">备注:</label>
            <div class="col-sm-9">
                <textarea style="margin: 0px; width: 822px; height: 297px;" name="remark" id="remark" value="${carryOut.remark }"></textarea>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">当前使用状态:</label>
            <div class="col-sm-9">
                <select class="form-control" name="status" id="status" disabled="disabled">
                    <option value="${carryOut.status }" <c:if test='${carryOut.status ==1}'>selected="selected"</c:if>>未使用</option>
                    <option value="${carryOut.status }" <c:if test='${carryOut.status ==0}'>selected="selected"</c:if>>使用中</option>
                </select>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">当前所属团队:</label>
            <div class="col-sm-9">
                <input type="text" name="teamId" id="teamId" value="${carryOut.teamId }" class="form-control" readonly="readonly">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">创建时间:</label>
            <div class="col-sm-9">
                <input type="text" name="createTime" id="createTime" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm"  value="${carryOut.createTime}" />" class="form-control" readonly="readonly">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">是否启用:</label>
            <div class="col-sm-9">
                <select class="form-control" name="isEnable" id="isEnable" disabled="disabled">
                    <option value="${carryOut.isEnable }" <c:if test='${carryOut.isEnable ==1}'>selected="selected"</c:if>>是</option>
                    <option value="${carryOut.isEnable }" <c:if test='${carryOut.isEnable ==0}'>selected="selected"</c:if>>否</option>
                </select>
            </div>
        </div>

        <div class="form-group draggable">
            <div class="col-sm-12 col-sm-offset-3">
                <a class="btn btn-primary"  id="save">保存</a>
                <button class="btn btn-white" type="button" onclick="goback()">取消</button>
            </div>
        </div>
    </form>
</div>
</div>
</div>
</body>
<script src="${url }js/jquery.validate.min.js"></script>
<script src="${url }js/plugins/QRCode/qrcode.min.js"></script>
<script src="${url }js/plugins/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    var qrcode = new QRCode(document.getElementById("qrcode"), {
        width : 100,
        height : 100
    });
    var elText = document.getElementById("carryoutCode");
    var carryoutCode = "{\"carryoutcode\":\""+elText.value+"\"}";
    qrcode.makeCode(carryoutCode);
    initZtree($("#carryoutTypeid").val());
    var setting = {
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: 0
            }
        },
        key: {
            name: "name"
        },
        check: {
            enable: true,
            chkStyle: "radio",
            radioType: "all"
        },
        callback: {
            onCheck: onCheckTree
        }
    };
    function initZtree(val) {
        $.post("${url }admin/carryoutType/ztree", {
            pid: val
        }, function (data) {
            zNodes = eval(data);
            var treeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        }, 'json');
    }
    function onCheckTree(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        nodes = zTree.getCheckedNodes(true);
        id = nodes[0].id;
        name = nodes[0].name;
        pidL = nodes[0].pidL;
        pNameL = nodes[0].pNameL;
        $("#carryoutTypeid").val(id);
        $("#carryoutType").val(id+","+pidL);
        $("#carryoutTypename").val(name+","+pNameL);
    }

    $("#save").on("click",function(){
        if($("#saveForm").valid()){
            var depict=$("#depict").val();
            var id=$("#userId").val();
            var carryoutTypeid = $("#carryoutTypeid").val();
            var carryoutType = $("#carryoutType").val();
            var carryoutTypename = $("#carryoutTypename").val();
            var carryoutDeptid = $("#carryoutDeptid").val();
            var carryoutStateid = $("#carryoutStateid").val();
            $.ajax({
                url : '${url }admin/carryOut/carryOutUpdateStatus',
                type:'post',
                data:{id:id,depict:depict,carryoutTypeid:carryoutTypeid,carryoutType:carryoutType,carryoutTypename:carryoutTypename,carryoutDeptid:carryoutDeptid,carryoutStateid:carryoutStateid},//
                success:function(result)
                {
                    if(result.code==1){
                        layer.alert("载具编辑成功!",function(){
                            window.location.href="${url}admin/carryOut/carryOutlist";
                        });
                    }else{
                        layer.alert("载具编辑失败!",function(){
                            window.location.href="${url}admin/carryOut/carryOutlist";
                        });
                    }
                }
            });
        }
    })
    function goback(){
        window.history.go(-1);
    }

</script>
</html>
