<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../base.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>系统配置</title>
    <link href="${url }css/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
    <link href="${url }css/plugins/fullcalendar/fullcalendar.print.min.css" rel="stylesheet" media="print" />
    <style>

        body {
            margin: 40px 10px;
            padding: 0;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
            font-size: 14px;
        }

        #calendar {
            max-width: 900px;
            margin: 0 auto;
        }

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
            top:20%;
            left:50%;
            width: 410px;
            height:500px;
            margin-top: -100px;
            margin-left: -250px;
            background: #fff;
            -moz-box-shadow: 1px 1px 5px #888888; /* 老的 Firefox */
            box-shadow: 1px 1px 5px #888888;
            padding: 20px;
        }

        .model from{
            position: relative;
            z-index: 999;
        }

    </style>
</head>
<body>
<div id='calendar'></div>
<div class="model" style="display:none" id="myModel">
    <div class="model-content" >
        <form id="calendarForm" class="form-horizontal m-t">
            <input type="hidden" id="type" name="type">
            <input type="hidden" id="id" name="id">
            <div class="form-group draggable">
                <label for class="col-sm-3">是否加班:</label>
                <div class="col-sm-7">
                    <input type="checkbox" name="typeCheck" id="typeCheck"/>
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">标题:</label>
                <div class="col-sm-7">
                    <input type="text" name="title" id="title" class="form-control" placeholder="请输入标题" />
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">生效日期:</label>
                <div class="col-sm-7">
                    <input type="date" name="effectDate" id="effectDate" class="form-control" placeholder="" />
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">开始时间:</label>
                <div class="col-sm-7">
                    <select class="form-control" id="startTime" name="startTime">
                        <option value="00:00:00">00:00:00</option>
                        <option value="00:30:00">00:30:00</option>
                        <option value="01:00:00">01:00:00</option>
                        <option value="01:30:00">01:30:00</option>
                        <option value="02:00:00">02:00:00</option>
                        <option value="02:30:00">02:30:00</option>
                        <option value="03:00:00">03:00:00</option>
                        <option value="03:30:00">03:30:00</option>
                        <option value="04:00:00">04:00:00</option>
                        <option value="04:30:00">04:30:00</option>
                        <option value="05:00:00">05:00:00</option>
                        <option value="05:30:00">05:30:00</option>
                        <option value="06:00:00">06:00:00</option>
                        <option value="06:30:00">06:30:00</option>
                        <option value="07:00:00">07:00:00</option>
                        <option value="07:30:00">07:30:00</option>
                        <option value="08:00:00">08:00:00</option>
                        <option value="08:30:00">08:30:00</option>
                        <option value="09:00:00">09:00:00</option>
                        <option value="09:30:00">09:30:00</option>
                        <option value="10:00:00">10:00:00</option>
                        <option value="10:30:00">10:30:00</option>
                        <option value="11:00:00">11:00:00</option>
                        <option value="11:30:00">11:30:00</option>
                        <option value="12:00:00">12:00:00</option>
                        <option value="12:30:00">12:30:00</option>
                        <option value="13:00:00">13:00:00</option>
                        <option value="13:30:00">13:30:00</option>
                        <option value="14:00:00">14:00:00</option>
                        <option value="14:30:00">14:30:00</option>
                        <option value="15:00:00">15:00:00</option>
                        <option value="15:30:00">15:30:00</option>
                        <option value="16:00:00">16:00:00</option>
                        <option value="16:30:00">16:30:00</option>
                        <option value="17:00:00">17:00:00</option>
                        <option value="17:30:00">17:30:00</option>
                        <option value="18:00:00">18:00:00</option>
                        <option value="18:30:00">18:30:00</option>
                        <option value="19:00:00">19:00:00</option>
                        <option value="19:30:00">19:30:00</option>
                        <option value="20:00:00">20:00:00</option>
                        <option value="20:30:00">20:30:00</option>
                        <option value="21:00:00">21:00:00</option>
                        <option value="21:30:00">21:30:00</option>
                        <option value="22:00:00">22:00:00</option>
                        <option value="22:30:00">22:30:00</option>
                        <option value="23:00:00">23:00:00</option>
                        <option value="23:30:00">23:30:00</option>
                    </select>
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">结束时间:</label>
                <div class="col-sm-7">
                    <select class=" form-control" id="endTime" name="endTime">
                        <option value="00:00:00">00:00:00</option>
                        <option value="00:30:00">00:30:00</option>
                        <option value="01:00:00">01:00:00</option>
                        <option value="01:30:00">01:30:00</option>
                        <option value="02:00:00">02:00:00</option>
                        <option value="02:30:00">02:30:00</option>
                        <option value="03:00:00">03:00:00</option>
                        <option value="03:30:00">03:30:00</option>
                        <option value="04:00:00">04:00:00</option>
                        <option value="04:30:00">04:30:00</option>
                        <option value="05:00:00">05:00:00</option>
                        <option value="05:30:00">05:30:00</option>
                        <option value="06:00:00">06:00:00</option>
                        <option value="06:30:00">06:30:00</option>
                        <option value="07:00:00">07:00:00</option>
                        <option value="07:30:00">07:30:00</option>
                        <option value="08:00:00">08:00:00</option>
                        <option value="08:30:00">08:30:00</option>
                        <option value="09:00:00">09:00:00</option>
                        <option value="09:30:00">09:30:00</option>
                        <option value="10:00:00">10:00:00</option>
                        <option value="10:30:00">10:30:00</option>
                        <option value="11:00:00">11:00:00</option>
                        <option value="11:30:00">11:30:00</option>
                        <option value="12:00:00">12:00:00</option>
                        <option value="12:30:00">12:30:00</option>
                        <option value="13:00:00">13:00:00</option>
                        <option value="13:30:00">13:30:00</option>
                        <option value="14:00:00">14:00:00</option>
                        <option value="14:30:00">14:30:00</option>
                        <option value="15:00:00">15:00:00</option>
                        <option value="15:30:00">15:30:00</option>
                        <option value="16:00:00">16:00:00</option>
                        <option value="16:30:00">16:30:00</option>
                        <option value="17:00:00">17:00:00</option>
                        <option value="17:30:00">17:30:00</option>
                        <option value="18:00:00">18:00:00</option>
                        <option value="18:30:00">18:30:00</option>
                        <option value="19:00:00">19:00:00</option>
                        <option value="19:30:00">19:30:00</option>
                        <option value="20:00:00">20:00:00</option>
                        <option value="20:30:00">20:30:00</option>
                        <option value="21:00:00">21:00:00</option>
                        <option value="21:30:00">21:30:00</option>
                        <option value="22:00:00">22:00:00</option>
                        <option value="22:30:00">22:30:00</option>
                        <option value="23:00:00">23:00:00</option>
                        <option value="23:30:00">23:30:00</option>
                    </select>
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">备注:</label>
                <div class="col-sm-7">
                    <textarea  name="remark" id="remark" class="form-control" placeholder="请输入备注" ></textarea>
                </div>
            </div>
            <br>
            <div class="form-group col-sm-12 text-center"  >
                <button type="button" class="btn btn-primary" id="subDataForm">确定</button>
                <button type="button" class="btn btn-warning" id="delDataForm" style="display:none;">删除</button>
                <a class="btn btn-white" onclick="cancelmodel()">取消</a>
            </div>
        </form>
    </div>
</div>
<div class="model" style="display:none" id="setModel">
    <div class="model-content" >
        <form id="calendarSetForm" class="form-horizontal m-t">
            <input type="hidden" id="startTimeSetHidden" name="startTimeSetHidden" value="${startTimeSet}">
            <input type="hidden" id="endTimeSetHidden" name="endTimeSetHidden" value="${endTimeSet}">
            <input type="hidden" id="remarkSetHidden" name="remarkSetHidden" value="${remarkSet}">
            <input type="hidden" id="idSetOvertimeHidden" name="idSetOvertimeHidden" value="${idSetOvertime}">
            <input type="hidden" id="startTimeSetOvertimeHidden" name="startTimeSetOvertimeHidden" value="${startTimeSetOvertime}">
            <input type="hidden" id="endTimeSetOvertimeHidden" name="endTimeSetOvertimeHidden" value="${endTimeSetOvertime}">

            <div class="form-group draggable">
                <label for class="col-sm-12">默认正常工作时间</label>
            </div>
            <input type="hidden" id="idSet" name="idSet" value="${idSet}">
            <div class="form-group draggable">
                <label for class="col-sm-3">开始时间:</label>
                <div class="col-sm-7">
                    <select class="form-control" id="startTimeSet" name="startTimeSet">
                        <option value="00:00:00" <c:if test="${startTimeSet == '00:00:00'}">selected="selected"</c:if> >00:00:00</option>
                        <option value="00:30:00" <c:if test="${startTimeSet == '00:30:00'}">selected="selected"</c:if> >00:30:00</option>
                        <option value="01:00:00" <c:if test="${startTimeSet == '01:00:00'}">selected="selected"</c:if> >01:00:00</option>
                        <option value="01:30:00" <c:if test="${startTimeSet == '01:30:00'}">selected="selected"</c:if> >01:30:00</option>
                        <option value="02:00:00" <c:if test="${startTimeSet == '02:00:00'}">selected="selected"</c:if> >02:00:00</option>
                        <option value="02:30:00" <c:if test="${startTimeSet == '02:30:00'}">selected="selected"</c:if> >02:30:00</option>
                        <option value="03:00:00" <c:if test="${startTimeSet == '03:00:00'}">selected="selected"</c:if> >03:00:00</option>
                        <option value="03:30:00" <c:if test="${startTimeSet == '03:30:00'}">selected="selected"</c:if> >03:30:00</option>
                        <option value="04:00:00" <c:if test="${startTimeSet == '04:00:00'}">selected="selected"</c:if> >04:00:00</option>
                        <option value="04:30:00" <c:if test="${startTimeSet == '04:30:00'}">selected="selected"</c:if> >04:30:00</option>
                        <option value="05:00:00" <c:if test="${startTimeSet == '05:00:00'}">selected="selected"</c:if> >05:00:00</option>
                        <option value="05:30:00" <c:if test="${startTimeSet == '05:30:00'}">selected="selected"</c:if> >05:30:00</option>
                        <option value="06:00:00" <c:if test="${startTimeSet == '06:00:00'}">selected="selected"</c:if> >06:00:00</option>
                        <option value="06:30:00" <c:if test="${startTimeSet == '06:30:00'}">selected="selected"</c:if> >06:30:00</option>
                        <option value="07:00:00" <c:if test="${startTimeSet == '07:00:00'}">selected="selected"</c:if> >07:00:00</option>
                        <option value="07:30:00" <c:if test="${startTimeSet == '07:30:00'}">selected="selected"</c:if> >07:30:00</option>
                        <option value="08:00:00" <c:if test="${startTimeSet == '08:00:00'}">selected="selected"</c:if> >08:00:00</option>
                        <option value="08:30:00" <c:if test="${startTimeSet == '08:30:00'}">selected="selected"</c:if> >08:30:00</option>
                        <option value="09:00:00" <c:if test="${startTimeSet == '09:00:00'}">selected="selected"</c:if> >09:00:00</option>
                        <option value="09:30:00" <c:if test="${startTimeSet == '09:30:00'}">selected="selected"</c:if> >09:30:00</option>
                        <option value="10:00:00" <c:if test="${startTimeSet == '10:00:00'}">selected="selected"</c:if> >10:00:00</option>
                        <option value="10:30:00" <c:if test="${startTimeSet == '10:30:00'}">selected="selected"</c:if> >10:30:00</option>
                        <option value="11:00:00" <c:if test="${startTimeSet == '11:00:00'}">selected="selected"</c:if> >11:00:00</option>
                        <option value="11:30:00" <c:if test="${startTimeSet == '11:30:00'}">selected="selected"</c:if> >11:30:00</option>
                        <option value="12:00:00" <c:if test="${startTimeSet == '12:00:00'}">selected="selected"</c:if> >12:00:00</option>
                        <option value="12:30:00" <c:if test="${startTimeSet == '12:30:00'}">selected="selected"</c:if> >12:30:00</option>
                        <option value="13:00:00" <c:if test="${startTimeSet == '13:00:00'}">selected="selected"</c:if> >13:00:00</option>
                        <option value="13:30:00" <c:if test="${startTimeSet == '13:30:00'}">selected="selected"</c:if> >13:30:00</option>
                        <option value="14:00:00" <c:if test="${startTimeSet == '14:00:00'}">selected="selected"</c:if> >14:00:00</option>
                        <option value="14:30:00" <c:if test="${startTimeSet == '14:30:00'}">selected="selected"</c:if> >14:30:00</option>
                        <option value="15:00:00" <c:if test="${startTimeSet == '15:00:00'}">selected="selected"</c:if> >15:00:00</option>
                        <option value="15:30:00" <c:if test="${startTimeSet == '15:30:00'}">selected="selected"</c:if> >15:30:00</option>
                        <option value="16:00:00" <c:if test="${startTimeSet == '16:00:00'}">selected="selected"</c:if> >16:00:00</option>
                        <option value="16:30:00" <c:if test="${startTimeSet == '16:30:00'}">selected="selected"</c:if> >16:30:00</option>
                        <option value="17:00:00" <c:if test="${startTimeSet == '17:00:00'}">selected="selected"</c:if> >17:00:00</option>
                        <option value="17:30:00" <c:if test="${startTimeSet == '17:30:00'}">selected="selected"</c:if> >17:30:00</option>
                        <option value="18:00:00" <c:if test="${startTimeSet == '18:00:00'}">selected="selected"</c:if> >18:00:00</option>
                        <option value="18:30:00" <c:if test="${startTimeSet == '18:30:00'}">selected="selected"</c:if> >18:30:00</option>
                        <option value="19:00:00" <c:if test="${startTimeSet == '19:00:00'}">selected="selected"</c:if> >19:00:00</option>
                        <option value="19:30:00" <c:if test="${startTimeSet == '19:30:00'}">selected="selected"</c:if> >19:30:00</option>
                        <option value="20:00:00" <c:if test="${startTimeSet == '20:00:00'}">selected="selected"</c:if> >20:00:00</option>
                        <option value="20:30:00" <c:if test="${startTimeSet == '20:30:00'}">selected="selected"</c:if> >20:30:00</option>
                        <option value="21:00:00" <c:if test="${startTimeSet == '21:00:00'}">selected="selected"</c:if> >21:00:00</option>
                        <option value="21:30:00" <c:if test="${startTimeSet == '21:30:00'}">selected="selected"</c:if> >21:30:00</option>
                        <option value="22:00:00" <c:if test="${startTimeSet == '22:00:00'}">selected="selected"</c:if> >22:00:00</option>
                        <option value="22:30:00" <c:if test="${startTimeSet == '22:30:00'}">selected="selected"</c:if> >22:30:00</option>
                        <option value="23:00:00" <c:if test="${startTimeSet == '23:00:00'}">selected="selected"</c:if> >23:00:00</option>
                        <option value="23:30:00" <c:if test="${startTimeSet == '23:30:00'}">selected="selected"</c:if> >23:30:00</option>
                    </select>
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">结束时间:</label>
                <div class="col-sm-7">
                    <select class=" form-control" id="endTimeSet" name="endTimeSet">
                        <option value="00:00:00" <c:if test="${endTimeSet == '00:00:00'}">selected="selected"</c:if> >00:00:00</option>
                        <option value="00:30:00" <c:if test="${endTimeSet == '00:30:00'}">selected="selected"</c:if> >00:30:00</option>
                        <option value="01:00:00" <c:if test="${endTimeSet == '01:00:00'}">selected="selected"</c:if> >01:00:00</option>
                        <option value="01:30:00" <c:if test="${endTimeSet == '01:30:00'}">selected="selected"</c:if> >01:30:00</option>
                        <option value="02:00:00" <c:if test="${endTimeSet == '02:00:00'}">selected="selected"</c:if> >02:00:00</option>
                        <option value="02:30:00" <c:if test="${endTimeSet == '02:30:00'}">selected="selected"</c:if> >02:30:00</option>
                        <option value="03:00:00" <c:if test="${endTimeSet == '03:00:00'}">selected="selected"</c:if> >03:00:00</option>
                        <option value="03:30:00" <c:if test="${endTimeSet == '03:30:00'}">selected="selected"</c:if> >03:30:00</option>
                        <option value="04:00:00" <c:if test="${endTimeSet == '04:00:00'}">selected="selected"</c:if> >04:00:00</option>
                        <option value="04:30:00" <c:if test="${endTimeSet == '04:30:00'}">selected="selected"</c:if> >04:30:00</option>
                        <option value="05:00:00" <c:if test="${endTimeSet == '05:00:00'}">selected="selected"</c:if> >05:00:00</option>
                        <option value="05:30:00" <c:if test="${endTimeSet == '05:30:00'}">selected="selected"</c:if> >05:30:00</option>
                        <option value="06:00:00" <c:if test="${endTimeSet == '06:00:00'}">selected="selected"</c:if> >06:00:00</option>
                        <option value="06:30:00" <c:if test="${endTimeSet == '06:30:00'}">selected="selected"</c:if> >06:30:00</option>
                        <option value="07:00:00" <c:if test="${endTimeSet == '07:00:00'}">selected="selected"</c:if> >07:00:00</option>
                        <option value="07:30:00" <c:if test="${endTimeSet == '07:30:00'}">selected="selected"</c:if> >07:30:00</option>
                        <option value="08:00:00" <c:if test="${endTimeSet == '08:00:00'}">selected="selected"</c:if> >08:00:00</option>
                        <option value="08:30:00" <c:if test="${endTimeSet == '08:30:00'}">selected="selected"</c:if> >08:30:00</option>
                        <option value="09:00:00" <c:if test="${endTimeSet == '09:00:00'}">selected="selected"</c:if> >09:00:00</option>
                        <option value="09:30:00" <c:if test="${endTimeSet == '09:30:00'}">selected="selected"</c:if> >09:30:00</option>
                        <option value="10:00:00" <c:if test="${endTimeSet == '10:00:00'}">selected="selected"</c:if> >10:00:00</option>
                        <option value="10:30:00" <c:if test="${endTimeSet == '10:30:00'}">selected="selected"</c:if> >10:30:00</option>
                        <option value="11:00:00" <c:if test="${endTimeSet == '11:00:00'}">selected="selected"</c:if> >11:00:00</option>
                        <option value="11:30:00" <c:if test="${endTimeSet == '11:30:00'}">selected="selected"</c:if> >11:30:00</option>
                        <option value="12:00:00" <c:if test="${endTimeSet == '12:00:00'}">selected="selected"</c:if> >12:00:00</option>
                        <option value="12:30:00" <c:if test="${endTimeSet == '12:30:00'}">selected="selected"</c:if> >12:30:00</option>
                        <option value="13:00:00" <c:if test="${endTimeSet == '13:00:00'}">selected="selected"</c:if> >13:00:00</option>
                        <option value="13:30:00" <c:if test="${endTimeSet == '13:30:00'}">selected="selected"</c:if> >13:30:00</option>
                        <option value="14:00:00" <c:if test="${endTimeSet == '14:00:00'}">selected="selected"</c:if> >14:00:00</option>
                        <option value="14:30:00" <c:if test="${endTimeSet == '14:30:00'}">selected="selected"</c:if> >14:30:00</option>
                        <option value="15:00:00" <c:if test="${endTimeSet == '15:00:00'}">selected="selected"</c:if> >15:00:00</option>
                        <option value="15:30:00" <c:if test="${endTimeSet == '15:30:00'}">selected="selected"</c:if> >15:30:00</option>
                        <option value="16:00:00" <c:if test="${endTimeSet == '16:00:00'}">selected="selected"</c:if> >16:00:00</option>
                        <option value="16:30:00" <c:if test="${endTimeSet == '16:30:00'}">selected="selected"</c:if> >16:30:00</option>
                        <option value="17:00:00" <c:if test="${endTimeSet == '17:00:00'}">selected="selected"</c:if> >17:00:00</option>
                        <option value="17:30:00" <c:if test="${endTimeSet == '17:30:00'}">selected="selected"</c:if> >17:30:00</option>
                        <option value="18:00:00" <c:if test="${endTimeSet == '18:00:00'}">selected="selected"</c:if> >18:00:00</option>
                        <option value="18:30:00" <c:if test="${endTimeSet == '18:30:00'}">selected="selected"</c:if> >18:30:00</option>
                        <option value="19:00:00" <c:if test="${endTimeSet == '19:00:00'}">selected="selected"</c:if> >19:00:00</option>
                        <option value="19:30:00" <c:if test="${endTimeSet == '19:30:00'}">selected="selected"</c:if> >19:30:00</option>
                        <option value="20:00:00" <c:if test="${endTimeSet == '20:00:00'}">selected="selected"</c:if> >20:00:00</option>
                        <option value="20:30:00" <c:if test="${endTimeSet == '20:30:00'}">selected="selected"</c:if> >20:30:00</option>
                        <option value="21:00:00" <c:if test="${endTimeSet == '21:00:00'}">selected="selected"</c:if> >21:00:00</option>
                        <option value="21:30:00" <c:if test="${endTimeSet == '21:30:00'}">selected="selected"</c:if> >21:30:00</option>
                        <option value="22:00:00" <c:if test="${endTimeSet == '22:00:00'}">selected="selected"</c:if> >22:00:00</option>
                        <option value="22:30:00" <c:if test="${endTimeSet == '22:30:00'}">selected="selected"</c:if> >22:30:00</option>
                        <option value="23:00:00" <c:if test="${endTimeSet == '23:00:00'}">selected="selected"</c:if> >23:00:00</option>
                        <option value="23:30:00" <c:if test="${endTimeSet == '23:30:00'}">selected="selected"</c:if> >23:30:00</option>
                    </select>
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">备注:</label>
                <div class="col-sm-7">
                    <textarea  name="remarkSet" id="remarkSet" value="${remarkSet}" class="form-control" placeholder="请输入备注" ></textarea>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            <div class="form-group draggable">
                <label for class="col-sm-12">默认加班时间</label>
            </div>
            <input type="hidden" id="idSetOvertime" name="idSetOvertime" value="${idSetOvertime}">
            <div class="form-group draggable">
                <label for class="col-sm-3">开始时间:</label>
                <div class="col-sm-7">
                    <select class="form-control" id="startTimeSetOvertime" name="startTimeSetOvertime">
                        <option value="00:00:00" <c:if test="${startTimeSetOvertime == '00:00:00'}">selected="selected"</c:if> >00:00:00</option>
                        <option value="00:30:00" <c:if test="${startTimeSetOvertime == '00:30:00'}">selected="selected"</c:if> >00:30:00</option>
                        <option value="01:00:00" <c:if test="${startTimeSetOvertime == '01:00:00'}">selected="selected"</c:if> >01:00:00</option>
                        <option value="01:30:00" <c:if test="${startTimeSetOvertime == '01:30:00'}">selected="selected"</c:if> >01:30:00</option>
                        <option value="02:00:00" <c:if test="${startTimeSetOvertime == '02:00:00'}">selected="selected"</c:if> >02:00:00</option>
                        <option value="02:30:00" <c:if test="${startTimeSetOvertime == '02:30:00'}">selected="selected"</c:if> >02:30:00</option>
                        <option value="03:00:00" <c:if test="${startTimeSetOvertime == '03:00:00'}">selected="selected"</c:if> >03:00:00</option>
                        <option value="03:30:00" <c:if test="${startTimeSetOvertime == '03:30:00'}">selected="selected"</c:if> >03:30:00</option>
                        <option value="04:00:00" <c:if test="${startTimeSetOvertime == '04:00:00'}">selected="selected"</c:if> >04:00:00</option>
                        <option value="04:30:00" <c:if test="${startTimeSetOvertime == '04:30:00'}">selected="selected"</c:if> >04:30:00</option>
                        <option value="05:00:00" <c:if test="${startTimeSetOvertime == '05:00:00'}">selected="selected"</c:if> >05:00:00</option>
                        <option value="05:30:00" <c:if test="${startTimeSetOvertime == '05:30:00'}">selected="selected"</c:if> >05:30:00</option>
                        <option value="06:00:00" <c:if test="${startTimeSetOvertime == '06:00:00'}">selected="selected"</c:if> >06:00:00</option>
                        <option value="06:30:00" <c:if test="${startTimeSetOvertime == '06:30:00'}">selected="selected"</c:if> >06:30:00</option>
                        <option value="07:00:00" <c:if test="${startTimeSetOvertime == '07:00:00'}">selected="selected"</c:if> >07:00:00</option>
                        <option value="07:30:00" <c:if test="${startTimeSetOvertime == '07:30:00'}">selected="selected"</c:if> >07:30:00</option>
                        <option value="08:00:00" <c:if test="${startTimeSetOvertime == '08:00:00'}">selected="selected"</c:if> >08:00:00</option>
                        <option value="08:30:00" <c:if test="${startTimeSetOvertime == '08:30:00'}">selected="selected"</c:if> >08:30:00</option>
                        <option value="09:00:00" <c:if test="${startTimeSetOvertime == '09:00:00'}">selected="selected"</c:if> >09:00:00</option>
                        <option value="09:30:00" <c:if test="${startTimeSetOvertime == '09:30:00'}">selected="selected"</c:if> >09:30:00</option>
                        <option value="10:00:00" <c:if test="${startTimeSetOvertime == '10:00:00'}">selected="selected"</c:if> >10:00:00</option>
                        <option value="10:30:00" <c:if test="${startTimeSetOvertime == '10:30:00'}">selected="selected"</c:if> >10:30:00</option>
                        <option value="11:00:00" <c:if test="${startTimeSetOvertime == '11:00:00'}">selected="selected"</c:if> >11:00:00</option>
                        <option value="11:30:00" <c:if test="${startTimeSetOvertime == '11:30:00'}">selected="selected"</c:if> >11:30:00</option>
                        <option value="12:00:00" <c:if test="${startTimeSetOvertime == '12:00:00'}">selected="selected"</c:if> >12:00:00</option>
                        <option value="12:30:00" <c:if test="${startTimeSetOvertime == '12:30:00'}">selected="selected"</c:if> >12:30:00</option>
                        <option value="13:00:00" <c:if test="${startTimeSetOvertime == '13:00:00'}">selected="selected"</c:if> >13:00:00</option>
                        <option value="13:30:00" <c:if test="${startTimeSetOvertime == '13:30:00'}">selected="selected"</c:if> >13:30:00</option>
                        <option value="14:00:00" <c:if test="${startTimeSetOvertime == '14:00:00'}">selected="selected"</c:if> >14:00:00</option>
                        <option value="14:30:00" <c:if test="${startTimeSetOvertime == '14:30:00'}">selected="selected"</c:if> >14:30:00</option>
                        <option value="15:00:00" <c:if test="${startTimeSetOvertime == '15:00:00'}">selected="selected"</c:if> >15:00:00</option>
                        <option value="15:30:00" <c:if test="${startTimeSetOvertime == '15:30:00'}">selected="selected"</c:if> >15:30:00</option>
                        <option value="16:00:00" <c:if test="${startTimeSetOvertime == '16:00:00'}">selected="selected"</c:if> >16:00:00</option>
                        <option value="16:30:00" <c:if test="${startTimeSetOvertime == '16:30:00'}">selected="selected"</c:if> >16:30:00</option>
                        <option value="17:00:00" <c:if test="${startTimeSetOvertime == '17:00:00'}">selected="selected"</c:if> >17:00:00</option>
                        <option value="17:30:00" <c:if test="${startTimeSetOvertime == '17:30:00'}">selected="selected"</c:if> >17:30:00</option>
                        <option value="18:00:00" <c:if test="${startTimeSetOvertime == '18:00:00'}">selected="selected"</c:if> >18:00:00</option>
                        <option value="18:30:00" <c:if test="${startTimeSetOvertime == '18:30:00'}">selected="selected"</c:if> >18:30:00</option>
                        <option value="19:00:00" <c:if test="${startTimeSetOvertime == '19:00:00'}">selected="selected"</c:if> >19:00:00</option>
                        <option value="19:30:00" <c:if test="${startTimeSetOvertime == '19:30:00'}">selected="selected"</c:if> >19:30:00</option>
                        <option value="20:00:00" <c:if test="${startTimeSetOvertime == '20:00:00'}">selected="selected"</c:if> >20:00:00</option>
                        <option value="20:30:00" <c:if test="${startTimeSetOvertime == '20:30:00'}">selected="selected"</c:if> >20:30:00</option>
                        <option value="21:00:00" <c:if test="${startTimeSetOvertime == '21:00:00'}">selected="selected"</c:if> >21:00:00</option>
                        <option value="21:30:00" <c:if test="${startTimeSetOvertime == '21:30:00'}">selected="selected"</c:if> >21:30:00</option>
                        <option value="22:00:00" <c:if test="${startTimeSetOvertime == '22:00:00'}">selected="selected"</c:if> >22:00:00</option>
                        <option value="22:30:00" <c:if test="${startTimeSetOvertime == '22:30:00'}">selected="selected"</c:if> >22:30:00</option>
                        <option value="23:00:00" <c:if test="${startTimeSetOvertime == '23:00:00'}">selected="selected"</c:if> >23:00:00</option>
                        <option value="23:30:00" <c:if test="${startTimeSetOvertime == '23:30:00'}">selected="selected"</c:if> >23:30:00</option>
                    </select>
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">结束时间:</label>
                <div class="col-sm-7">
                    <select class=" form-control" id="endTimeSetOvertime" name="endTimeSetOvertime">
                        <option value="00:00:00" <c:if test="${endTimeSetOvertime == '00:00:00'}">selected="selected"</c:if> >00:00:00</option>
                        <option value="00:30:00" <c:if test="${endTimeSetOvertime == '00:30:00'}">selected="selected"</c:if> >00:30:00</option>
                        <option value="01:00:00" <c:if test="${endTimeSetOvertime == '01:00:00'}">selected="selected"</c:if> >01:00:00</option>
                        <option value="01:30:00" <c:if test="${endTimeSetOvertime == '01:30:00'}">selected="selected"</c:if> >01:30:00</option>
                        <option value="02:00:00" <c:if test="${endTimeSetOvertime == '02:00:00'}">selected="selected"</c:if> >02:00:00</option>
                        <option value="02:30:00" <c:if test="${endTimeSetOvertime == '02:30:00'}">selected="selected"</c:if> >02:30:00</option>
                        <option value="03:00:00" <c:if test="${endTimeSetOvertime == '03:00:00'}">selected="selected"</c:if> >03:00:00</option>
                        <option value="03:30:00" <c:if test="${endTimeSetOvertime == '03:30:00'}">selected="selected"</c:if> >03:30:00</option>
                        <option value="04:00:00" <c:if test="${endTimeSetOvertime == '04:00:00'}">selected="selected"</c:if> >04:00:00</option>
                        <option value="04:30:00" <c:if test="${endTimeSetOvertime == '04:30:00'}">selected="selected"</c:if> >04:30:00</option>
                        <option value="05:00:00" <c:if test="${endTimeSetOvertime == '05:00:00'}">selected="selected"</c:if> >05:00:00</option>
                        <option value="05:30:00" <c:if test="${endTimeSetOvertime == '05:30:00'}">selected="selected"</c:if> >05:30:00</option>
                        <option value="06:00:00" <c:if test="${endTimeSetOvertime == '06:00:00'}">selected="selected"</c:if> >06:00:00</option>
                        <option value="06:30:00" <c:if test="${endTimeSetOvertime == '06:30:00'}">selected="selected"</c:if> >06:30:00</option>
                        <option value="07:00:00" <c:if test="${endTimeSetOvertime == '07:00:00'}">selected="selected"</c:if> >07:00:00</option>
                        <option value="07:30:00" <c:if test="${endTimeSetOvertime == '07:30:00'}">selected="selected"</c:if> >07:30:00</option>
                        <option value="08:00:00" <c:if test="${endTimeSetOvertime == '08:00:00'}">selected="selected"</c:if> >08:00:00</option>
                        <option value="08:30:00" <c:if test="${endTimeSetOvertime == '08:30:00'}">selected="selected"</c:if> >08:30:00</option>
                        <option value="09:00:00" <c:if test="${endTimeSetOvertime == '09:00:00'}">selected="selected"</c:if> >09:00:00</option>
                        <option value="09:30:00" <c:if test="${endTimeSetOvertime == '09:30:00'}">selected="selected"</c:if> >09:30:00</option>
                        <option value="10:00:00" <c:if test="${endTimeSetOvertime == '10:00:00'}">selected="selected"</c:if> >10:00:00</option>
                        <option value="10:30:00" <c:if test="${endTimeSetOvertime == '10:30:00'}">selected="selected"</c:if> >10:30:00</option>
                        <option value="11:00:00" <c:if test="${endTimeSetOvertime == '11:00:00'}">selected="selected"</c:if> >11:00:00</option>
                        <option value="11:30:00" <c:if test="${endTimeSetOvertime == '11:30:00'}">selected="selected"</c:if> >11:30:00</option>
                        <option value="12:00:00" <c:if test="${endTimeSetOvertime == '12:00:00'}">selected="selected"</c:if> >12:00:00</option>
                        <option value="12:30:00" <c:if test="${endTimeSetOvertime == '12:30:00'}">selected="selected"</c:if> >12:30:00</option>
                        <option value="13:00:00" <c:if test="${endTimeSetOvertime == '13:00:00'}">selected="selected"</c:if> >13:00:00</option>
                        <option value="13:30:00" <c:if test="${endTimeSetOvertime == '13:30:00'}">selected="selected"</c:if> >13:30:00</option>
                        <option value="14:00:00" <c:if test="${endTimeSetOvertime == '14:00:00'}">selected="selected"</c:if> >14:00:00</option>
                        <option value="14:30:00" <c:if test="${endTimeSetOvertime == '14:30:00'}">selected="selected"</c:if> >14:30:00</option>
                        <option value="15:00:00" <c:if test="${endTimeSetOvertime == '15:00:00'}">selected="selected"</c:if> >15:00:00</option>
                        <option value="15:30:00" <c:if test="${endTimeSetOvertime == '15:30:00'}">selected="selected"</c:if> >15:30:00</option>
                        <option value="16:00:00" <c:if test="${endTimeSetOvertime == '16:00:00'}">selected="selected"</c:if> >16:00:00</option>
                        <option value="16:30:00" <c:if test="${endTimeSetOvertime == '16:30:00'}">selected="selected"</c:if> >16:30:00</option>
                        <option value="17:00:00" <c:if test="${endTimeSetOvertime == '17:00:00'}">selected="selected"</c:if> >17:00:00</option>
                        <option value="17:30:00" <c:if test="${endTimeSetOvertime == '17:30:00'}">selected="selected"</c:if> >17:30:00</option>
                        <option value="18:00:00" <c:if test="${endTimeSetOvertime == '18:00:00'}">selected="selected"</c:if> >18:00:00</option>
                        <option value="18:30:00" <c:if test="${endTimeSetOvertime == '18:30:00'}">selected="selected"</c:if> >18:30:00</option>
                        <option value="19:00:00" <c:if test="${endTimeSetOvertime == '19:00:00'}">selected="selected"</c:if> >19:00:00</option>
                        <option value="19:30:00" <c:if test="${endTimeSetOvertime == '19:30:00'}">selected="selected"</c:if> >19:30:00</option>
                        <option value="20:00:00" <c:if test="${endTimeSetOvertime == '20:00:00'}">selected="selected"</c:if> >20:00:00</option>
                        <option value="20:30:00" <c:if test="${endTimeSetOvertime == '20:30:00'}">selected="selected"</c:if> >20:30:00</option>
                        <option value="21:00:00" <c:if test="${endTimeSetOvertime == '21:00:00'}">selected="selected"</c:if> >21:00:00</option>
                        <option value="21:30:00" <c:if test="${endTimeSetOvertime == '21:30:00'}">selected="selected"</c:if> >21:30:00</option>
                        <option value="22:00:00" <c:if test="${endTimeSetOvertime == '22:00:00'}">selected="selected"</c:if> >22:00:00</option>
                        <option value="22:30:00" <c:if test="${endTimeSetOvertime == '22:30:00'}">selected="selected"</c:if> >22:30:00</option>
                        <option value="23:00:00" <c:if test="${endTimeSetOvertime == '23:00:00'}">selected="selected"</c:if> >23:00:00</option>
                        <option value="23:30:00" <c:if test="${endTimeSetOvertime == '23:30:00'}">selected="selected"</c:if> >23:30:00</option>
                    </select>
                </div>
            </div>
            <div class="form-group draggable">
                <label for class="col-sm-3">备注:</label>
                <div class="col-sm-7">
                    <textarea  name="remarkSetOvertime" id="remarkSetOvertime" value="${remarkSetOvertime}" class="form-control" placeholder="请输入备注" ></textarea>
                </div>
            </div>
            <div class="form-group col-sm-12 text-center"  >
                <button type="button" class="btn btn-primary" id="subDataFormSet">确定</button>
                <a class="btn btn-white" onclick="cancelmodel()">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
<link href="${url }css/plugins/iCheck/custom.css" rel="stylesheet">
<script src="${url }js/plugins/fullcalendar/moment.min.js"></script>
<script src="${url }js/jquery.validate.min.js"></script>
<script src="${url }js/plugins/iCheck/icheck.min.js"></script>
<script src="${url }js/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
<script src="${url }js/plugins/fullcalendar/locale-all.js"></script>
<script>

    var startAll,endAll;
    var checkFlag=false;
    $(document).ready(function() {
        var initialLocaleCode = 'zh-cn';
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            height:$("body").height(),
            locale: initialLocaleCode,
            navLinks: true, // can click day/week names to navigate views
            selectable: true,
            selectHelper: true,
            //allDaySlot:false,
            editable:true,
            select: function(start, end) {//选中日期后触发的时间
                startAll=start;
                endAll=end;
                var start1 = new Date(start);
                var year = start1.getFullYear();
                var mon = dateAdd0((start1.getMonth()+1));
                var day = dateAdd0(start1.getDate());
                var hours = dateAdd0(start1.getHours()-8);
                var min = dateAdd0(start1.getMinutes());
                var sec = dateAdd0(start1.getSeconds());

                var end1 = new Date(end);
                var hourse = dateAdd0(end1.getHours()-8);
                var mine = dateAdd0(end1.getMinutes());
                var sece = dateAdd0(end1.getSeconds());
                $("#myModel #effectDate").val(year+"-"+mon+"-"+day);
                $("#myModel #startTime").val(hours+":"+min+":"+sec);
                $("#myModel #endTime").val(hourse+":"+mine+":"+sece);

                $("#start").val(start);
                $("#end").val(end);

                if($("#myModel #startTime").val()=="00:00:00"&&$("#myModel #endTime").val()=="00:00:00"){
                    checkFlag=true;
                    $("#myModel #startTime").val($("#startTimeSetHidden").val()).change();
                    $("#myModel #endTime").val($("#endTimeSetHidden").val()).change();
                } else{
                    checkFlag=false;
                }
                $("#myModel #remark").val($("#remarkSetHidden").val());

                $("#myModel").show();
            },
            eventLimit: true, // allow "more" link when too many events
            eventClick: function(calEvent, jsEvent, view) {//点击已经存在的事件，触发的方法
                startAll=calEvent.start;
                endAll=calEvent.end;
                var start1 = new Date(calEvent.start);
                var hours = dateAdd0(start1.getHours()-8) ;
                var min = dateAdd0(start1.getMinutes());
                var sec = dateAdd0(start1.getSeconds());

                var end1 = new Date(calEvent.end);
                var hourse = dateAdd0(end1.getHours()-8);
                var mine = dateAdd0(end1.getMinutes());
                var sece = dateAdd0(end1.getSeconds());
                $("#myModel #effectDate").val(startAll._i.split("T")[0]).change();
                $("#myModel #startTime").val(hours+":"+min+":"+sec).change();
                $("#myModel #endTime").val(hourse+":"+mine+":"+sece).change();

                $("#myModel #title").val(calEvent.title);
                $("#myModel #id").val(calEvent.id);
                $("#myModel #remark").val(calEvent.remark);

                if(calEvent.type=="1"){
                    $("#myModel #typeCheck").prop("checked","checked");
                }
                $("#myModel #type").val(calEvent.type);
                $("#myModel #id").val(calEvent.id);
                $("#delDataForm").show();
                $("#myModel").show();
            },
            events:function(start, end, timezone, callback){
                //prev上一月, next下一月等事件时调用
                var start1 = new Date(start);
                var year = start1.getFullYear();
                var mon = dateAdd0((start1.getMonth()+1));
                var day = dateAdd0(start1.getDate());
                start1 = year+"-"+mon+"-"+day;
                var end1 = new Date(end);
                var year1 = end1.getFullYear();
                var mon1 = dateAdd0((end1.getMonth()+1));
                var day1 = dateAdd0(end1.getDate());
                end1 = year1+"-"+mon1+"-"+day1;
                $.ajax({
                    url : '${url }/admin/calendar/getCalendar',
                    type:'post',
                    data:{start1:start1,end1:end1},
                    success:function(result) {
                        var event=[];
                        if(result!=null&&result!=""){
                            result = eval("("+result+")");
                            $.each(result,function(i){
                                var effectDate = result[i].effectDate;
                                var title = result[i].title;
                                var startTime = result[i].startTime;
                                var endTime = result[i].endTime;
                                var type = result[i].type;
                                var id = result[i].id;
                                var remark = result[i].remark;
                                event.push({
                                    id:id,
                                    title:title,
                                    start:effectDate+"T"+startTime,
                                    end:effectDate+"T"+endTime,
                                    type:type,
                                    remark:remark
                                });
                            });
                        }
                        callback(event);
                    },error:function(){
                       // alert(1);
                    }
                });
            }
        });


        $("#subDataForm").click(function(){
            if($("#calendarForm").valid()){
                var eventData;
                var title = $("#title").val();
                var effectDate = $("#effectDate").val();
                var start = $("#startTime").val();
                var end = $("#endTime").val();

                var remark = $("#remark").val();

                var type = "2";
                if($("#typeCheck").is(":checked")){
                    type = "1";
                } else{
                    type = "2";
                }
                $("#type").val(type);
                var id = $("#calendarForm #id").val();
                if(id==undefined||id==null||id==""){
                    $.ajax({
                        url : '${url }/admin/calendar/addCalendar',
                        type:'post',
                        data:$("#calendarForm").serialize(),
                        success:function(result) {
                            if(result>0){
                                cancelmodel();
                                layer.alert("添加成功!",function(){
                                    window.location.href="${url}admin/calendar";
                                });
                            } else{
                                layer.alert("添加失败!",function(){
                                    window.location.href="${url}admin/calendar";
                                });
                            }
                        }
                    });
                } else{
                    $.ajax({
                        url : '${url }/admin/calendar/updateCalendar',
                        type:'post',
                        data:$("#calendarForm").serialize(),
                        success:function(result) {
                            if(result>0){
                                cancelmodel();
                                layer.alert("修改成功!",function(){
                                    window.location.href="${url}admin/calendar";
                                });
                            } else{
                                layer.alert("修改失败!",function(){
                                    window.location.href="${url}admin/calendar";
                                });
                            }
                        }
                    });
                }
                eventData = {
                    id:id,
                    title: title,
                    start: startAll,
                    end: endAll,
                    remark: remark,
                    type: type,
                    state: state,
                    isEnable:isEnable
                };
                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
                $('#calendar').fullCalendar('unselect');
            }

        });

        $("#delDataForm").click(function(){
            $.ajax({
                url : '${url }/admin/calendar/deleteCalendar',
                type:'post',
                data:{id:$("#calendarForm #id").val()},
                success:function(result) {
                    if(result>0){
                        layer.alert("删除成功!",function(){
                            window.location.href="${url}admin/calendar";
                        });
                    } else{
                        layer.alert("删除失败!",function(){
                            window.location.href="${url}admin/calendar";
                        });
                    }
                }
            });
        });

        $('.fc-header-toolbar .fc-left').append('<button type="button" class="fc-button fc-state-default fc-corner-left fc-corner-right" onclick="setCalendar()">设置</button>');

        $("#typeCheck").change(function(){
            if(checkFlag){
                if($(this).is(":checked")){
                    $("#myModel #startTime").val($("#startTimeSetOvertimeHidden").val()).change();
                    $("#myModel #endTime").val($("#endTimeSetOvertimeHidden").val()).change();
                    $("#myModel #remark").val($("#remarkSetOvertimeHidden").val());
                } else{
                    $("#myModel #startTime").val($("#startTimeSetHidden").val()).change();
                    $("#myModel #endTime").val($("#endTimeSetHidden").val()).change();
                    $("#myModel #remark").val($("#remarkSetHidden").val());
                }
            }
        });

        //添加默认时间设置
        $("#subDataFormSet").click(function(){
            var idSet = $("#calendarSetForm #idSet").val();
            var startTimeSet = $("#calendarSetForm #startTimeSet").val();
            var endTimeSet = $("#calendarSetForm #endTimeSet").val();
            var remarkSet = $("#calendarSetForm #remarkSet").val();
            var idSetOvertime = $("#calendarSetForm #idSetOvertime").val();
            var startTimeSetOvertime = $("#calendarSetForm #startTimeSetOvertime").val();
            var endTimeSetOvertime = $("#calendarSetForm #endTimeSetOvertime").val();
            var remarkSetOvertime = $("#calendarSetForm #remarkSetOvertime").val();
            $.ajax({
                url : '${url }/admin/calendar/CalendarSetConfig',
                type:'post',
                data:{idSet:idSet,startTimeSet:startTimeSet,endTimeSet:endTimeSet,remarkSet:remarkSet,idSetOvertime:idSetOvertime,startTimeSetOvertime:startTimeSetOvertime,endTimeSetOvertime:endTimeSetOvertime,remarkSetOvertime:remarkSetOvertime},
                success:function(result){
                    if(result>0){
                        $("#startTimeSetOvertimeHidden").val(startTimeSet);
                        $("#endTimeSetOvertimeHidden").val(endTimeSet);
                        $("#remarkSetOvertimeHidden").val(remarkSet);
                        $("#startTimeSetHidden").val(startTimeSetOvertime);
                        $("#endTimeSetHidden").val(endTimeSetOvertime);
                        $("#remarkSetHidden").val(remarkSetOvertime);
                        cancelmodel();
                        layer.alert("操作成功!");
                    } else{
                        layer.alert("操作失败!");
                    }
                }
            });
        });
    });

    function cancelmodel(){
        $(".model").hide();
        $("#delDataForm").hide();
        $("#calendarForm input").val("");
        $("#calendarForm textarea").val("");
        $("#calendarForm input[type='checkbox']").removeAttr("checked");
    }

    function dateAdd0(val){
        if(val<0){
            val=val+24;
        }
        if(val<10){
            val = "0"+""+val;
        }
        return val;
    }

    $("#calendarForm").validate({
        rules:{
            title:{
                required:true
            }
        },
        //如果验证控件没有message，将调用默认的信息
        messages:{
            title:{
                required:"请输入标题 "
            }
        }
    });

    function setCalendar(){
        $("#setModel").show();
    }

</script>
</html>