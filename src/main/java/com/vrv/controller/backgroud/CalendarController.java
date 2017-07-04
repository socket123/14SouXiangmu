package com.vrv.controller.backgroud;

import com.vrv.entity.Calendar;
import com.vrv.service.impl.CalendarService;
import com.vrv.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * Created by LXX on 2017-05-22.
 */
@Controller
@RequestMapping("/admin/calendar")
public class CalendarController {
    @Autowired
    CalendarService calendarService;

    @RequestMapping(value = "")
    public String list(ModelMap modelMap) {
        List<Calendar> CalendarL = calendarService.selectAllwork();
        if(null != CalendarL && !CalendarL.isEmpty()){
            for(int i = 0;i < CalendarL.size();i++){
                Calendar calendar = CalendarL.get(i);
                if(String.valueOf(calendar.getType()).equals("2")){//正常上班
                    modelMap.put("idSet", calendar.getId());
                    modelMap.put("startTimeSet",calendar.getStartTime());
                    modelMap.put("endTimeSet",calendar.getEndTime());
                    modelMap.put("remarkSet",calendar.getRemark());
                } else if(String.valueOf(calendar.getType()).equals("1")){//加班时间
                    modelMap.put("idSetOvertime", calendar.getId());
                    modelMap.put("startTimeSetOvertime",calendar.getStartTime());
                    modelMap.put("endTimeSetOvertime",calendar.getEndTime());
                    modelMap.put("remarkSetOvertime",calendar.getRemark());
                }
            }
        }
        return "backgroud/calendar";
    }

    /*获得日程内容*/
    @RequestMapping(value = "getCalendar", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getCalendar(ModelMap modelMap,String start1,String end1) {
        StringBuilder restr = new StringBuilder();
        List<Calendar> CalendarList = calendarService.selectByDate(start1,end1);
        if(CalendarList!=null && !CalendarList.isEmpty()){
            int length = CalendarList.size();
            restr.append("[");
            for(int i =0;i<length;i++){
                Calendar CalendarEach = CalendarList.get(i);
                restr.append("{");
                restr.append("\"id\":\""+CalendarEach.getId()+"\",");
                restr.append("\"title\":\""+CalendarEach.getTitle()+"\",");
                restr.append("\"type\":\""+CalendarEach.getType()+"\",");
                restr.append("\"state\":\""+CalendarEach.getState()+"\",");
                restr.append("\"startTime\":\""+CalendarEach.getStartTime()+"\",");
                restr.append("\"endTime\":\""+CalendarEach.getEndTime()+"\",");
                restr.append("\"effectDate\":\""+CalendarEach.getEffectDate()+"\",");
                restr.append("\"remark\":\""+CalendarEach.getRemark()+"\"");
                restr.append("},");
            }
            restr.append("]");
        }
        return restr.toString();
    }
    /*添加日程*/
    @RequestMapping(value = "addCalendar", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String addCalendar(Calendar calendar) {
        calendar.setCreateTime(new Date());
        calendar.setState("2");
        Integer i = calendarService.insert(calendar);
        return String.valueOf(i);
    }
    /*修改日程*/
    @RequestMapping(value = "updateCalendar", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String updateCalendar(Calendar calendar) {
        calendar.setState("2");
        Integer i = calendarService.update(calendar);
        return String.valueOf(i);
    }
    /*删除日程*/
    @RequestMapping(value = "deleteCalendar")
    @ResponseBody
    public String deleteCalendar(ModelMap modelMap,Integer id){
        Integer i = calendarService.delete(id);
        return String.valueOf(i);
    }
    /*设置默认时间*/
    @RequestMapping(value = "CalendarSetConfig", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String CalendarSetConfig(Integer idSet,String startTimeSet,String endTimeSet,String remarkSet,Integer idSetOvertime,String startTimeSetOvertime,String endTimeSetOvertime,String remarkSetOvertime) {
        Calendar calendar = new Calendar();
        Calendar calendarov = new Calendar();
        Integer i;
        Integer j;
        try {
            calendar.setStartTime(startTimeSet);
            calendar.setEndTime(endTimeSet);
            calendar.setRemark(remarkSet);
            calendar.setType("2");
            calendar.setState("1");

            if (null == idSet) {
                calendar.setCreateTime(new Date());
                i = calendarService.insert(calendar);
            } else {
                calendar.setId(idSet);
                i = calendarService.update(calendar);
            }

            calendarov.setStartTime(startTimeSetOvertime);
            calendarov.setEndTime(endTimeSetOvertime);
            calendarov.setRemark(remarkSetOvertime);
            calendarov.setType("1");
            calendarov.setState("1");
            if (null == idSetOvertime) {
                calendarov.setCreateTime(new Date());
                j = calendarService.insert(calendarov);
            } else {
                calendarov.setId(idSetOvertime);
                j = calendarService.update(calendarov);
            }
            if (i > 0 && j > 0) {
                i=1;
            } else {
                i=0;
            }
        }catch (Exception e){
            i=0;
        }
        return String.valueOf(i);
    }

}
