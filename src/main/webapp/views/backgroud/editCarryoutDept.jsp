<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>编辑部门</title>
</head>
<body>
<div class="ibox-content">
    <form id="saveForm" class="form-horizontal m-t">
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">部门名称:</label>
            <div class="col-sm-9">
                <input type="text" name="catName" id="catName" value="${carryoutDept.deptName }" class="form-control" placeholder="请输入部门名称">
                <input type="hidden" value="${carryoutDept.id }" id="rId">
            </div>
        </div>
        <div class="hr-line-dashed"></div>
        <div class="form-group draggable">
            <label class="col-sm-3 control-label">备注:</label>
            <div class="col-sm-9">
                <textarea style="margin: 0px; width: 822px; height: 297px;" name="remark" id="remark">${carryoutDept.remark }</textarea>
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
<script type="text/javascript">
    $("#save").on("click",function(){
        if($("#saveForm").valid()){
            var catName=$("#catName").val();
            var remark=$("#remark").val();
            $.ajax({
                url : '${url }admin/carryoutDept/editCarryoutDept',
                type:'post',
                data:{id:id,name:catName,remark:remark},
                success:function(result)
                {
                    if(result.message==1){
                        layer.alert("部门编辑成功!",function(){
                            window.location.href="${url}admin/carryoutDept";
                        });
                    }else{
                        if(typeof(result.mess)!="undefined"){
                            layer.alert(result.mess);
                        } else{
                            layer.alert("部门编辑失败!",function(){
                                window.location.href="${url}admin/carryoutDept";
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
                required:"请输入部门名称 "
            }
        }
    });

</script>
</html>