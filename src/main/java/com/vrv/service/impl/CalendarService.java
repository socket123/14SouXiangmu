package com.vrv.service.impl;

import com.vrv.entity.Calendar;
import com.vrv.mapper.CalendarMapper;
import com.vrv.service.BaseService;
import com.vrv.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by LXX on 2017-05-23.
 */
@Service
public class CalendarService  extends BaseService<Calendar> {

    @Autowired
    CalendarMapper calendarMapper;

    public List<Calendar> selectByDate(String start,String end){return calendarMapper.selectByDate(start,end);}

    public List<Calendar> selectByAll(Calendar calendar){return calendarMapper.selectByAll(calendar);}

    public int deleteByType(String type){return calendarMapper.deleteByType(type);}

    public List<Calendar> selectByTimeNow(){
        String date = DateUtil.getNowDate("yyyy-MM-dd HH:mm:ss");
        String effectDate = date.substring(0,10);
        String startTime = date.substring(11,19);

        return calendarMapper.selectByTime(effectDate,startTime);
    }

    public List<Calendar> selectAllwork(){return calendarMapper.selectAllwork();}
}
