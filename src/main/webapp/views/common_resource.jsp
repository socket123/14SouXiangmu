<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="url" value="${pageContext.request.contextPath}/" />
<link rel="stylesheet" href="${url }statics/font_css/css/font-awesome.min.css">
<!--标准mui.css-->
<link rel="stylesheet" href="${url }statics/font_css/css/mui.min.css">
<link rel="stylesheet" href="${url }statics/font_css/css/icons-extra.css">
<link rel="stylesheet" type="text/css" href="${url }statics/font_css/css/mui.picker.min.css"/>
<!--App自定义的css-->
<link rel="stylesheet" type="text/css" href="${url }statics/font_css/css/app.css"/>
<link rel="stylesheet" type="text/css" href="${url }statics/font_css/css/aui-pull-refresh.css"/>
<script type="text/javascript" src="${url }statics/font_css/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="${url }statics/font_css/js/mui.min.js"></script>
<script type="text/javascript" src="${url }statics/font_css/js/mui.picker.min.js"></script>
<script type="text/javascript" src="${url }statics/font_css/js/aui-pull-refresh.js"></script>

<script type="text/javascript" src="${url }statics/font_css/js/aui-pull-refresh.js"></script>
<script type="text/javascript" src="${url }statics/vrv-jssdk-v1.4.min.js"></script> 
<script>
vrv.init({
    debug:false
});
vrv.ready(function(){
	vrv.jssdk.showNavigationBar({       
	    show:false//true or false 显示或隐藏导航栏
	})
});

var path = "${url}";
function linkByDom(dom, url) {
	$.ajax({
		url : url,
		type : "get",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data : {},
		traditional : true,
		beforeSend : function(a, b, c) {
		},
		cache : false,
		success : function(data, statusText, jqXHR) {
			$('#' + dom).html(data);
		},
		error : function(a, b, c) {
			alert("网络不畅，请刷新页面重试！");
		}
	});
}

</script>