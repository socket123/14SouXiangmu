<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>智慧物配后台管理</title>
    <%@ include file="../base.jsp" %>
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">${username}</strong></span>
                                <span class="text-muted text-xs block">超级管理员<b class="caret"></b></span>
                                </span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${url }admin/orderAll"><i class="fa fa-list"></i> <span class="nav-label">订单列表</span></a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${url }admin/user"><i class="fa fa-users"></i> <span class="nav-label">用户列表</span></a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa fa-sun-o"></i>
                            <span class="nav-label">配套资源管理</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li><a class="J_menuItem" href="${url }admin/resource">资源类别</a></li>
                            <li><a class="J_menuItem" href="${url }admin/resou/gotoResourceList">资源列表</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="mailbox.html"><i class="fa fa-automobile"></i> <span class="nav-label">运输团队管理 </span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li><a class="J_menuItem" href="${url }admin/resource/gotoTeamType">团队分类</a></li>
                            <li><a class="J_menuItem" href="${url }admin/transTeam/gotoTransportTeamList">团队管理</a></li>
                            <li><a class="J_menuItem" href="${url }admin/transportWay/gotoTransportWayList">运输方式</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${url }admin/areaCode/list"><i class="fa fa-map"></i> <span class="nav-label">配载点管理</span></a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa fa-sun-o"></i>
                            <span class="nav-label">载具管理</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li><a class="J_menuItem" href="${url }admin/carryoutType">载具类别</a></li>
                            <li><a class="J_menuItem" href="${url }admin/carryoutState">载具状态</a></li>
                            <li><a class="J_menuItem" href="${url }admin/carryoutDept">部门</a></li>
                            <li><a class="J_menuItem" href="${url }admin/carryOut/carryOutlist">载具管理</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa fa-sun-o"></i>
                            <span class="nav-label">统计报表</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li><a class="J_menuItem" href="${url }admin/orderAll/orderAnalysis">订单趋势分析</a></li>
                            <li><a class="J_menuItem" href="${url }admin/transTeam/transTeamAnalysis">配送人员工作量分析</a></li>
                            <li><a class="J_menuItem" href="${url }admin/evaluate/evaluatelist">订单评价分析</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${url }admin/calendar"><i class="fa fa-gears"></i> <span class="nav-label">日历</span></a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${url }admin/sysset/toEdit"><i class="fa fa-gears"></i> <span class="nav-label">系统设置</span></a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>

                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </div>
                <a href="${url}login" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="" frameborder="0" data-id="" seamless></iframe>
            </div>
        </div>
        <!--右侧部分结束-->
    </div>
</body>

</html>