package com.carpe.system.support.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期计算demo
 * @author LL007
 *
 */
public class DateJs {
    public static void main(String[] args) throws ParseException {
        System.out.println(minuteFomartJs(new Date(),20));

    }
    /**
     * 计算当期时间加上N天之后的日期
     * @param date 当期日期
     * @param day N天
     * @return N天后的日期
     * @throws ParseException 异常
     */
public  static String dateFomartJs(Date date,int day) throws ParseException{
    SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
    String dd=fmt.format(date);
    Date df=fmt.parse(dd);
    Calendar  calendar = Calendar.getInstance();
    calendar.setTime(df);
    calendar.add(Calendar.DAY_OF_MONTH,day);  
    String T = fmt.format(calendar.getTime() ) ;
    System.out.println(T);
    return T;
}
    /**
     * 计算传入参数时间加上N个月之后的日期
     * @param date 当前时间
     * @param moth 月数
     * @return 结果
     */
public  static String dataAddMoth(Date date,int moth){
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(date);
    calendar.add(Calendar.MONTH, moth);
    System.out.println(fmt.format(calendar.getTime()));
    String T =fmt.format(calendar.getTime());
    return T;
 }
        /**
         * 计算当期时间减去N天之后的日期
         * @param date 当期日期
         * @param day N天
         * @return N天后的日期
         * @throws ParseException 异常
         */
        public static  String dateDelDay(Date date,int day) throws ParseException{
        SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
        String dd=fmt.format(date);
        Date df=fmt.parse(dd);
        Calendar  calendar = Calendar.getInstance();
        calendar.setTime(df);
        calendar.add(Calendar.DAY_OF_MONTH,0-day);  
        String T = fmt.format(calendar.getTime() ) ;
        System.out.println(T);
        return T;
       }
        /**  
         * 计算两个日期之间相差的天数  
         * @param smdate 较小的时间 
         * @param bdate  较大的时间 
         * @return 相差天数 
         * @throws ParseException  
         */    
        public static int daysBetween(Date smdate,Date bdate) throws ParseException    
        {    
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
            smdate=sdf.parse(sdf.format(smdate));  
            bdate=sdf.parse(sdf.format(bdate));  
            Calendar cal = Calendar.getInstance();    
            cal.setTime(smdate);    
            long time1 = cal.getTimeInMillis();                 
            cal.setTime(bdate);    
            long time2 = cal.getTimeInMillis();         
            long between_days=(time2-time1)/(1000*3600*24);  
                
           return Integer.parseInt(String.valueOf(between_days));           
        }    
        /** 
    *字符串的日期格式的计算 
    */  
    public static int daysBetweenString(String smdate,String bdate) throws ParseException{  
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(sdf.parse(smdate));    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(sdf.parse(bdate));    
        long time2 = cal.getTimeInMillis();         
        long between_days=(time2-time1)/(1000*3600*24);  
            
       return Integer.parseInt(String.valueOf(between_days));     
    }  
    /**
     * 计算当期时间加上N分钟后的时间
     * @param date 当期日期
     * @param day N天
     * @return N天后的日期
     * @throws ParseException 异常
     */
public  static String minuteFomartJs(Date date,int minute) throws ParseException{
    SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String dd=fmt.format(date);
    Date df=fmt.parse(dd);
    Calendar  calendar = Calendar.getInstance();
    calendar.setTime(df);
    calendar.add(Calendar.MINUTE, minute);
    String T = fmt.format(calendar.getTime() ) ;
    System.out.println(T);
    return T;
}
}
