package common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CommonMethod {
	/**
	 * 
	 * @param pTime
	 * @return根据日期查询周几
	 * @throws Exception
	 */
	public static int dayForWeek(String pTime) throws Exception {  
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
		 Calendar c = Calendar.getInstance();  
		 c.setTime(format.parse(pTime));  
		 int dayForWeek = 0;  
		 if(c.get(Calendar.DAY_OF_WEEK) == 1){  
		  dayForWeek = 7;  
		 }else{  
		  dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;  
		 }  
		 return dayForWeek;  
	}
	
	
	public static int getTimeDistanceBeforeToday(String date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int returnStr=0;
		try {
			int days = daysBetween(sdf.parse(date), new Date());
			if(days>=90){
				returnStr=90;
			}else if(days>=30){
				returnStr=30;
			}else if(days>=15){
				returnStr=15;
			}else if(days>=7){
				returnStr=7;
			}else if(days>=3){
				returnStr=3;
			}else if(days==2){
				returnStr=2;
			}else if(days==1){
				returnStr=1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnStr;
	}
	
	
	public static int daysBetween(Date smdate,Date bdate)  
    {    
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        long between_days=0;
        try {
        	smdate=sdf.parse(sdf.format(smdate));  
            bdate=sdf.parse(sdf.format(bdate));  
            Calendar cal = Calendar.getInstance();    
            cal.setTime(smdate);    
            long time1 = cal.getTimeInMillis();                 
            cal.setTime(bdate);    
            long time2 = cal.getTimeInMillis();
            between_days=(time2-time1)/(1000*3600*24); 
		} catch (Exception e) {
			e.printStackTrace();
		}
            
       return Integer.parseInt(String.valueOf(between_days));           
    }
}
