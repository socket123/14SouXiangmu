<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="url" value="${pageContext.request.contextPath}/" />

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="shortcut icon" href="favicon.ico">

<link rel="stylesheet" type="text/css"  href="${url }css/bootstrap.min.css" >
<link href="${url }css/font-awesome.min.css?v=4.4.0" rel="stylesheet" type="text/css">
<link href="${url }css/animate.min.css" rel="stylesheet" type="text/css">
<link href="${url }css/style.min.css?v=4.0.0" rel="stylesheet" type="text/css">

<script src="${url }js/jquery.min.js?v=2.1.4"></script>
<script src="${url }js/bootstrap.min.js?v=3.3.5"></script>
<script src="${url }js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="${url }js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${url }js/plugins/layer/layer.js"></script>
<script src="${url }js/hplus.min.js?v=4.0.0"></script>
<script type="text/javascript" src="${url }js/contabs.min.js"></script>
<script src="${url }js/plugins/pace/pace.min.js"></script>

<script type="text/javascript">
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