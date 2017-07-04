<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>新增载具类别</title>
    <link rel="stylesheet" type="text/css" href="${url }css/plugins/zTree/zTreeStyle/zTreeStyle.css"/>
</head>
<body>
<div class="ibox-content">
    <form id="saveForm" class="form-horizontal m-t">
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">分类名称:</label>
            <div class="col-sm-9">
                <input type="text" name="catName" id="catName" value="${carryoutType.name }" class="form-control" placeholder="请输入分类名称">
                <input type="hidden" value="${carryoutType.id }" id="rId">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">所属父级分类:</label>
            <input type="hidden" id="pid" name="pid"  value="${carryoutType.pid }">
            <input type="hidden" id="parentid" name="parentid"  value="${carryoutType.parentid }">
            <input type="hidden" id="parentName" name="parentName" value="${carryoutType.parentName }">
            <div class="col-sm-9">
                <ul id="treeDemo" class="ztree" valign="top"></ul>
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">备注:</label>
            <div class="col-sm-9">
                <textarea style="margin: 0px; width: 822px; height: 297px;" name="remark" id="remark">${carryoutType.remark }</textarea>
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
<script src="${url }js/plugins/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">

    initZtree($("#pid").val());
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
        $("#pid").val(id);
        $("#parentid").val(pidL);
        $("#parentName").val(pNameL);
    }
    $("#save").on("click",function(){
        if($("#saveForm").valid()){
            var catName=$("#catName").val();
            var remark=$("#remark").val();
            var id=$("#rId").val();
            var pid=$("#pid").val();
            if(null == pid||"" == pid){
                pid=0;
            }
            var parentid=$("#parentid").val();
            var parentName=$("#parentName").val();
            $.ajax({
                url : '${url }admin/carryoutType/editCarryoutType',
                type:'post',
                data:{id:id,name:catName,remark:remark,pid:pid,parentid:parentid},
                success:function(result)
                {
                    if(result.message==1){
                        layer.alert("载具分类编辑成功!",function(){
                            window.location.href="${url}admin/carryoutType";
                        });
                    }else{
                        if(typeof(result.mess)!="undefined"){
                            layer.alert(result.mess);
                        } else{
                            layer.alert("载具分类编辑失败!",function(){
                                window.location.href="${url}admin/carryoutType";
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
            catName:{
                required:true
            }
        },
        //如果验证控件没有message，将调用默认的信息
        messages:{
            catName:{
                required:"请输入分类名称 "
            }
        }

    });

</script>
</html>