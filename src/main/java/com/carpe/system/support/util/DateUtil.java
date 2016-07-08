package com.carpe.system.support.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期Util
 * 
 * @author hdc
 * 
 */
public class DateUtil {
	public static void main(String[] args) throws ParseException {
		/*
		 * System.out.println(getNextMonday(2));
		 * System.out.println(getNextSunday(2));
		 */
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(df.format(monthFirstDay()));
		System.out.println(df.format(monthLastDay()));
		// System.out.println(dateFomartJs(12));
	}

	/**
	 * 计算当期时间加上N天之后的日期
	 * 
	 * @param day
	 *            N天
	 * @return N天后的日期
	 * @throws ParseException
	 *             异常
	 */
	public static Date dateFomartJs(int day) {
		try {
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			String dd = fmt.format(date);
			Date df = fmt.parse(dd);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(df);
			calendar.add(Calendar.DAY_OF_MONTH, day);
			return calendar.getTime();
		} catch (Exception e) {
			return null;
		}
	}



	/**
	 * 计算传入参数时间加上N个月之后的日期
	 * 
	 * @param date
	 *            当前时间
	 * @param moth
	 *            月数
	 * @return 结果
	 */
	public static Date dateAddMoth(Date date, int moth) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, moth);
		return calendar.getTime();
	}
	/**
	 * 计算当期时间加上N天之后的日期
	 *
	 * @param date
	 *            当期日期
	 * @param day
	 *            N天
	 * @return N天后的日期
	 * @throws ParseException
	 *             异常
	 */
	public static Date dateAddDay(Date date, int day){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, day);
		return calendar.getTime();
	}
	/**
	 * 计算当期时间减去N天之后的日期
	 * 
	 * @param date
	 *            当期日期
	 * @param day
	 *            N天
	 * @return N天后的日期
	 * @throws ParseException
	 *             异常
	 */
	public static Date dateDelDay(Date date, int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, 0 - day);
		return calendar.getTime();
	}

	/**
	 * 计算两个日期之间相差的天数
	 * 
	 * @param smdate
	 *            较小的时间
	 * @param bdate
	 *            较大的时间
	 * @return 相差天数
	 * @throws ParseException
	 */
	public static int daysBetween(Date smdate, Date bdate) throws ParseException {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		smdate = sdf.parse(sdf.format(smdate));
		bdate = sdf.parse(sdf.format(bdate));
		Calendar cal = Calendar.getInstance();
		cal.setTime(smdate);
		long time1 = cal.getTimeInMillis();
		cal.setTime(bdate);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);

		return Integer.parseInt(String.valueOf(between_days));
	}

	/**
	 * 字符串的日期格式的计算
	 */
	public static int daysBetweenString(String smdate, String bdate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(smdate));
		long time1 = cal.getTimeInMillis();
		cal.setTime(sdf.parse(bdate));
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);

		return Integer.parseInt(String.valueOf(between_days));
	}

	/**
	 * 获取当前日期下周一的日期
	 * 
	 * @return 下周一日期
	 */
	public static String getNextMonday(Integer num) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.WEEK_OF_YEAR, num);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String monday = df.format(cal.getTime());
		return monday;
	}

	/**
	 * 获取当前日期下周日的日期
	 * 
	 * @return 下周日期
	 */
	public static String getNextSunday(Integer num) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.WEEK_OF_YEAR, num + 1);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String sunday = df.format(cal.getTime());
		return sunday;
	}

	/**
	 * 日期转换为字符串
	 * 
	 * @param date
	 *            日期
	 * @param format
	 *            格式
	 * @return
	 */
	public static String dateToString(Date date, String format) {
		if(null!=date) {
			SimpleDateFormat df = new SimpleDateFormat(format);
			return df.format(date);
		}else{
			return "";
		}
	}

	/**
	 * 字符串转换为日期
	 * 
	 * @param dateStr
	 *            日期
	 * @param format
	 *            格式
	 * @return
	 */
	public static Date stringToDate(String dateStr, String format) {
		Date date = new Date();
		try {
			SimpleDateFormat df = new SimpleDateFormat(format);
			date = df.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 获取当月第一天
	 * @author tanghom<tanghom@qq.com>
	 * @return 当月第一天
	 */
	public static Date monthFirstDay() {
		Calendar cal = Calendar.getInstance();// 获取当前日期
		cal.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		return cal.getTime();
	}

	/**
	 * 获取当月最后一天
	 * @author tanghom<tanghom@qq.com>
	 * @return 当月最后一天
	 */
	public static Date monthLastDay() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		return cal.getTime();
	}
	/**
	 * 返回当前时间　格式：yyyy-MM-dd hh:mm:ss
	 *
	 * @return String
	 */
	public static String fromDateH() {
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return format1.format(new Date());
	}

	/**
	 * 返回当前时间　格式：yyyy-MM-dd
	 *
	 * @return String
	 */
	public static String fromDateY() {
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		return format1.format(new Date());
	}

	public static String fromDateP(String pattern) {
		DateFormat format1 = new SimpleDateFormat(pattern);
		return format1.format(new Date());
	}
}
