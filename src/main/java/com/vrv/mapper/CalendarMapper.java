package com.vrv.mapper;

import com.vrv.entity.Calendar;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CalendarMapper extends BaseDao<Calendar>  {
    int deleteByPrimaryKey(Integer id);

    int insert(Calendar record);

    int insertSelective(Calendar record);

    Calendar selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Calendar record);

    int updateByPrimaryKey(Calendar record);

    List<Calendar> selectByDate(@Param("startTime") String start,@Param("endTime") String end);

    List<Calendar> selectByAll(Calendar calendar);

    int deleteByType(String type);

    List<Calendar> selectByTime(@Param("effectDate") String effectDate,@Param("startTime") String startTime);

    List<Calendar> selectAllwork();
}