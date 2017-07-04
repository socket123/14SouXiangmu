package com.vrv.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

/**
 * <Description> <br>
 * 日期处理工具类
 * 
 * @author Administrator<br>
 * @CreateDate 2015年10月28日 <br>
 */
public class DateUtil {
    private final static Logger log = Logger.getLogger(DateUtil.class);

    /**
     * 时间样式
     */
    public static final String DATE_STYLE_DD = "yyyy-MM-dd";

    /**
     * 时间样式
     */
    public static final String DATE_STYLE_DDSS = "yyyy-MM-dd HH:mm:ss";

    /**
     * 将unix时间戳转换成date
     * 
     * @param time
     * @return
     */
    public static String unix2Time(String time) {
        Long timestamp = Long.parseLong(time);
        if (time.length() <= 10) {
            timestamp = timestamp * 1000;
        }
        String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(timestamp));
        return date;
    }

    /**
     * 将date转换成unix时间戳
     * 
     * @param dateString
     * @return
     * @throws Exception
     */
    public static long date2Unix(String dateString) throws Exception {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Date date = df.parse(dateString);
        long time = date.getTime();
        return time / 1000;
    }

    /**
     * 获取系统当前时间 14位 dateStyle:yyyyMMddHHmmss
     * 
     * @return
     */
    public static String getSystemTime(String dateStyle) {
        String time = "";
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat(dateStyle);
        time = format.format(date);
        // Long result = Long.valueOf(time);
        return time;
    }

    /**
     * 过滤时间字符串中的特殊字符
     * 
     * @param time
     * @return
     * @throws ParseException
     */
    public static Long filterTime(String time) {
        if (time != null) {
            if (time.length() > 19) {
                time = time.substring(0, 19);
            }
            time = time.replaceAll("/", "").replaceAll("-", "").replaceAll(":", "")
                    .replaceAll(" ", "").trim();
        }
        Long result = Long.valueOf(time);
        return result;
    }

    /**
     * 返回不同的随机数 重复几率亿亿分之1
     * 
     * @return
     */
    public static String random() {
        String str = Math.random() + "";
        return str.substring(3, str.length() - 1);
    }

    /**
     * 将字符串转换成DATE对象 （可以自定义格式）的
     * 
     * @param sdate
     * @param dateStyle 格式：默认yyyy-MM-dd HH:mm:ss
     * @return
     * @throws YfsdException
     */
    public static Date string2Date(String sdate, String dateStyle) {
        if (StringUtils.isEmpty(dateStyle)) {
            dateStyle = DATE_STYLE_DDSS;
        }
        Date date = null;
        try {
            if (sdate == null || sdate.length() == 0) {
                return null;
            } else {
                SimpleDateFormat adf = new SimpleDateFormat(dateStyle);
                date = adf.parse(sdate);
            }
        } catch (Exception e) {
            log.error("日期转换异常", e);
        }
        return date;
    }

    /**
     * Description: <br>
     * 获取当前时间
     * 
     * @param dateStyle格式，默认yyyy-MM-dd hh:mm:ss
     * @return <br>
     */
    public static String getNowDate(String dateStyle) {
        Date dateTime = new Date();
        if (StringUtils.isEmpty(dateStyle)) {
            dateStyle = DATE_STYLE_DDSS;
        }
        SimpleDateFormat format = new SimpleDateFormat(dateStyle);
        String strTime = format.format(dateTime);
        return strTime;
    }

    /**
     * 从实体中取出年度日期信息
     * 
     * @param result
     * @return
     */
    public static String getYearMonth(Object result) {
        if (result instanceof java.util.Date) {
            Date tmp = (java.util.Date) result;
            int month = tmp.getMonth();
            month++;
            return (tmp.getYear() + 1900) + "" + month;
        } else if (result instanceof java.lang.String) {
            String tmp = (String) result;
            if (tmp != null && tmp.length() > 7) {
                return tmp.substring(0, 4) + tmp.substring(5, 7);
            } else {
                tmp = DateUtil.getNowDate("yyyy-MM-dd HH:mm:ss");
                return tmp.substring(0, 4) + tmp.substring(5, 7);
            }
        } else {
            String tmp = DateUtil.getNowDate("yyyy-MM-dd HH:mm:ss");
            if (tmp != null && tmp.length() > 7) {
                return tmp.substring(0, 4) + tmp.substring(5, 7);
            } else {
                tmp = DateUtil.getNowDate("yyyy-MM-dd HH:mm:ss");
                return tmp.substring(0, 4) + tmp.substring(5, 7);
            }
        }
    }

    /**
     * 返回指定日期的月份
     * 
     * @param date
     * @return
     */
    public static String getMonth(Date date) {
        int month = date.getMonth();
        month++;
        return String.valueOf(month);
    }

    /**
     * 通过时间日期对象获得时间日期字符串
     * 
     * @param date 时间日期对象
     * @return 获得的时间日期字符串
     */
    public static String date2String(Date date) {
        String mDateTime = "";
        try {
            if (date != null) {
                DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                mDateTime = formatter.format(date);
            }
        } catch (Exception ex) {
            log.error("日期转换异常", ex);
        }
        return mDateTime;
    }

    /**
     * 通过时间日期对象获得时间日期字符串
     * 
     * @param date 时间日期对象
     * @return 获得的时间日期字符串
     */
    public static String date2String(Date date, String dateStyle) {
        String mDateTime = "";
        try {
            if (date != null) {
                DateFormat formatter = new SimpleDateFormat(dateStyle);
                mDateTime = formatter.format(date);
            }
        } catch (Exception ex) {
            log.error("日期转换异常", ex);
        }
        return mDateTime;
    }

    /**
     * 返回两个日期相隔分数 （无顺序问题）
     * 
     * @param beginDate
     * @param endDate
     * @return 分数
     */
    public static int getBetweenMinuts(Date beginDate, Date endDate) {
        long beginTime = beginDate.getTime();
        long endTime = endDate.getTime();
        long betseconds = 0;
        if (beginDate.after(endDate)) {
            betseconds = (long) ((beginTime - endTime) / (1000 * 60));
        } else {
            betseconds = (long) ((endTime - beginTime) / (1000 * 60));
        }
        return new Long(betseconds).intValue();
    }

    /**
     * 返回两个日期相隔天数 （无顺序问题）
     * 
     * @param beginDate
     * @param endDate
     * @return 天数
     */
    public static int getBetweenDays(Date beginDate, Date endDate) {
        long beginTime = beginDate.getTime();
        long endTime = endDate.getTime();
        long betseconds = 0;
        if (beginDate.after(endDate)) {
            betseconds = (long) ((beginTime - endTime) / (1000 * 60) / 60 / 24);
        } else {
            betseconds = (long) ((endTime - beginTime) / (1000 * 60) / 60 / 24);
        }
        return new Long(betseconds).intValue();
    }

    /**
     * 得到int型的年份
     * 
     * @param date
     * @return
     */
    public static int getIntYear() {
        int year = 0;
        GregorianCalendar g = new GregorianCalendar();
        year = g.get(Calendar.YEAR);
        return year;
    }

    /**
     * 得到int型的月
     * 
     * @param date
     * @return
     */
    public static int getIntMonth() {
        int year = 0;
        GregorianCalendar g = new GregorianCalendar();
        year = g.get(Calendar.MONTH) + 1;
        return year;
    }

    /**
     * 得到int型的日
     * 
     * @param date
     * @return
     */
    public static int getIntDay() {
        int year = 0;
        GregorianCalendar g = new GregorianCalendar();
        year = g.get(Calendar.DAY_OF_MONTH);
        return year;
    }

    /**
     * 得到int型的日
     * 
     * @param date
     * @return
     */
    public static int getIntWeek() {
        int year = 0;
        GregorianCalendar g = new GregorianCalendar();
        year = g.get(Calendar.DAY_OF_WEEK) - 1;
        return year;
    }

    public static void main(String[] args) throws ParseException {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    	System.out.println(getBetweenMinuts(new Date(), sdf.parse("2016-11-30 14:44:22")));
        System.out.println(getIntWeek());
    }

    /**
     * Description: <br>
     * 获取date日期的前N天/月的日期
     * 
     * @param date
     * @param flag 1为日，2为月，默认为月
     * @return <br>
     */
    public static String getBeforeDate(Date date, Integer flag, Integer num) {
        Date dBefore = new Date();
        Calendar calendar = Calendar.getInstance(); // 得到日历
        calendar.setTime(date);// 把当前时间赋给日历
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 设置时间格式
        if (flag == 1) {
            calendar.add(calendar.DATE, -num); // 设置为前num日
            dBefore = calendar.getTime(); // 得到前num日的时间
        } else {
            calendar.add(calendar.MONTH, -num); // 设置为前num月
            dBefore = calendar.getTime(); // 得到前num月的时间
        }
        String defaultStartDate = sdf.format(dBefore); // 格式化前3月的时间
        return defaultStartDate;
    }

}
