;$(function () {
    clasz_CheckBoxRes("checkboxs");
    click_checkbox_class();
});

function clasz_CheckBoxRes(className) {
    var rdsObj   = document.getElementsByClassName(className);
    console.log(rdsObj);
    for(i = 0; i < rdsObj.length; i++){
        if(rdsObj[i].checked){
        }else{
            rdsObj[i].checked = true;
        }
    }
}

// 提交 aajax
function ajax_sumber(otherid) {
var urls = $(".modeld-url").val();
    $.ajax({
        cache : false,
        async : false,
        type : "POST",
        url :  ""+urls+"/font/orders/saveTeamRelation",
        data:{otherIds:otherid},
        success : function(resultObj) {
            console.log(resultObj)

                if(resultObj.msg == "success"){
                    cancelmodel_work();
                    mui.toast("操作成功");
                } else {
                    mui.alert(resultObj.msg);
                }

        },
        error : function(request) {
            mui.alert("系统消息", '操作失败!!!');
        }
    });
}

// 绑定民工
function recoveryWorker() {
    $(".modelWorker").css("display","");
}
//绑定民工 取消
function cancelmodel_work(){
    $(".modelWorker").css("display","none");
}
//绑定民工 确定
function subDataForm_work(){
    var flag= getVals("checkbox_class");
    // if (flag) {//全选
//                mui.toast('选择');
        var html_1 = getCheckBoxRes("checkbox_class");
        var otherid = html_1.join(",");
        // mui.toast(","+html_1.join(",")+",");
        ajax_sumber(otherid);
    // }else{// 取消全选
    //     mui.alert('请选择');
    //
    // }
}

// 点击显示
function click_checkbox_class() {
    var thiz = $(this);
    var name =	thiz.attr("names");
    var html_1 = getCheckBoxRes_names("checkbox_class");
    if(html_1 != ""){
        $(".li-html-apper").html("<p class='mui-p-s'>【"+html_1.join("/")+"】</p>");
    }else {
        $(".li-html-apper").html(" <p>请选择</p>");
    }

}

// 结算判断mui 获取复选框的值
function getVals(id){
    var flag = false;
    var res = getCheckBoxRes(''+id+'');
    if(res.length < 1){// 没有选择
        // mui.toast('请选择');
        flag = false;
        return;
    }else{// 选择
        flag = true;
    }
    // mui.toast(res);
    return 	flag ;

}
//结算判断 mui 获取复选框的 姓名
function getCheckBoxRes_names(className){
    var rdsObj   = document.getElementsByClassName(className);
    var checkVal = new Array();
    var k        = 0;
    for(i = 0; i < rdsObj.length; i++){
        if(rdsObj[i].checked){
            checkVal[k] = rdsObj[i].getAttribute("names");
            k++;
        }else{

        }
    }
    return checkVal;
}
//结算判断 mui 获取复选框的值
function getCheckBoxRes(className){
    var rdsObj   = document.getElementsByClassName(className);
    var checkVal = new Array();
    var k        = 0;
    for(i = 0; i < rdsObj.length; i++){
        if(rdsObj[i].checked){
            checkVal[k] = rdsObj[i].value;
            k++;
        }else{

        }
    }
    return checkVal;
}
