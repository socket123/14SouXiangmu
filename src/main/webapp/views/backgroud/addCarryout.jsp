<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>新增载具</title>
    <link rel="stylesheet" type="text/css" href="${url }css/plugins/zTree/zTreeStyle/zTreeStyle.css"/>
</head>
<body>
<div class="ibox-content">
    <form id="saveForm" class="form-horizontal m-t">
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">载具编码:</label>
            <div class="col-sm-9">
                <input type="text" name="carryoutCode" id="carryoutCode" class="form-control" placeholder="请输入载具编码">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">图号:</label>
            <div class="col-sm-9">
                <input type="text" name="figurenum" id="figurenum" class="form-control" placeholder="请输入图号">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">所属部门:</label>
            <div class="col-sm-9">
                <select class="form-control" name="carryoutDeptid" id="carryoutDeptid">
                    <option value=""></option>
                    <c:forEach items="${carryoutDept}" var="v">
                        <option value="${v.id}" >${v.deptName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">状态:</label>
            <div class="col-sm-9">
                <select class="form-control" name="carryoutStateid" id="carryoutStateid">
                    <option value=""></option>
                    <c:forEach items="${carryoutState}" var="v">
                        <option value="${v.id}">${v.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">所属分类:</label>
            <input type="hidden" id="carryoutTypeid" name="carryoutTypeid">
            <input type="hidden" id="carryoutType" name="carryoutType">
            <input type="hidden" id="carryoutTypename" name="carryoutTypename">
            <div class="col-sm-9">
                <ul id="treeDemo" class="ztree" valign="top"></ul>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">描述:</label>
            <div class="col-sm-9">
                <input type="text" name="depict" id="depict" placeholder="请输入描述" class="form-control">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">备注:</label>
            <div class="col-sm-9">
                <textarea style="margin: 0px; width: 822px; height: 297px;" name="remark" id="remark"></textarea>
            </div>
        </div>
        <div class="form-group draggable">
            <div class="col-sm-12 col-sm-offset-3">
                <a class="btn btn-primary" id="save">保存</a>
                <button class="btn btn-white" type="button" onclick="goback()">取消</button>
            </div>
        </div>
    </form>
</div>
</body>
<script src="${url }js/jquery.validate.min.js"></script>
<script src="${url }js/plugins/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    initZtree();
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
            $.ajax({
                url : '${url }admin/carryOut/addCarryout',
                type:'post',
                data:$("#saveForm").serialize(),
                success:function(result)
                {
                    if(result.message==1){
                        layer.alert("载具添加成功!",function(){
                            window.location.href="${url}admin/carryOut/carryOutlist";
                        });
                    }else{
                        if(typeof(result.mess)!="undefined"){
                            layer.alert(result.mess);
                        } else{
                            layer.alert("载具添加失败!",function(){
                                window.location.href="${url}admin/carryOut/carryOutlist";
                            });
                        }
                    }
                }
            });
        }
    })
    function goback(){
        window.history.go(-1);
    }

    $("#saveForm").validate({
        rules:{
            carryoutCode:{
                required:true
            }
        },
        //如果验证控件没有message，将调用默认的信息
        messages:{
            carryoutCode:{
                required:"请输入载具编码 "
            }
        }

    });
</script>
</html>