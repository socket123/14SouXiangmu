<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="url" value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>智慧物配 - 404 页面</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="${url }css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${url }css/animate.min.css" rel="stylesheet">
    <link href="${url }css/style.min.css?v=4.0.0" rel="stylesheet"><base target="_blank">
</head>

<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h1>404</h1>
        <h3 class="font-bold">页面未找到！</h3>
        <div class="error-desc">抱歉，页面好像去火星了~</div>
    </div>
    <script src="${url }js/jquery.min.js?v=2.1.4"></script>
    <script src="${url }js/bootstrap.min.js?v=3.3.5"></script>
</body>
</html>