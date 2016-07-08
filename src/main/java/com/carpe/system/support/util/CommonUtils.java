package com.carpe.system.support.util;

import com.cddgg.system.entity.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 公共
 * 
 * @author tanghom <tanghom@qq.com> 2015-11-18
 */
public class CommonUtils {
	/**
	 * 获取登录账号Subject对象
	 * 
	 * @author 汤宏
	 * @return Object 返回是Object..需要转型为(Account)Object
	 */
	public static User getSubjectUserSession() {
		Session session = SecurityUtils.getSubject().getSession();
		User user = (User) session.getAttribute(CommonKey.USER_SESSION);
		return user;
	}

	/**
	 * 获取用户session
	 * 
	 * @return
	 */
	public static User getUserSession() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		User user = (User) request.getSession().getAttribute(CommonKey.USER_SESSION);
		return user;
	}

	/**
	 * 判断是否POST提交，是POST返回true，不是POST提交返回false
	 * 
	 * @return 是POST返回true，不是POST提交返回false
	 */
	public static Boolean isPost() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		if ("POST".equals(request.getMethod())) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * AJAX提交返回信息
	 * 
	 * @param status
	 *            是否成功，true成功，false 异常
	 * @param info
	 *            返回信息提示
	 * @param data
	 *            数据json
	 * @return 返回信息
	 */
	public static String msgCallback(Boolean status, String info, String url, String data) {
		Map<String, Object> callback = new HashMap<String, Object>();
		callback.put("status", status);
		callback.put("info", info);
		callback.put("url", url);
		callback.put("data", data);
		return JsonUtil.toJSONString(callback);
	}

	/**
	 * String转换double
	 * 
	 * @param dataStr
	 * @return double
	 */
	public static double convertSourData(String dataStr) throws Exception {
		if (dataStr != null && !"".equals(dataStr)) {
			return Double.valueOf(dataStr);
		}
		throw new NumberFormatException("convert error!");
	}

	/**
	 * 使用率计算
	 * 
	 * @return
	 */
	public static String fromUsage(long free, long total) {
		Double d = new BigDecimal(free * 100 / total).setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
		return String.valueOf(d);
	}

	/**
	 * 保留两个小数
	 * 
	 * @return
	 */
	public static String formatDouble(Double b) {
		BigDecimal bg = new BigDecimal(b);
		return bg.setScale(2, BigDecimal.ROUND_HALF_UP).toString();
	}



	/**
	 * 用来去掉List中空值和相同项的。
	 * 
	 * @param list
	 * @return
	 */
	public static List<String> removeSameItem(List<String> list) {
		List<String> difList = new ArrayList<String>();
		for (String t : list) {
			if (t != null && !difList.contains(t)) {
				difList.add(t);
			}
		}
		return difList;
	}

	/**
	 * 返回用户的IP地址
	 * 
	 * @param request
	 * @return
	 */
	public static String toIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 传入原图名称，，获得一个以时间格式的新名称
	 *
	 * @param fileName
	 *            　原图名称
	 * @return
	 */
	public static String generateFileName(String fileName) {
		DateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String formatDate = format.format(new Date());
		int random = new Random().nextInt(10000);
		int position = fileName.lastIndexOf(".");
		String extension = fileName.substring(position);
		return formatDate + random + extension;
	}

	/**
	 * List<Long>转数据库查询字符串
	 * @param list
	 * @return
	 */
	public static String ListToString(List<Long> list) {
		StringBuffer str = new StringBuffer();
		for (int i = 0; i < list.size(); i++) {
			if (i < list.size() - 1) {
				str.append(list.get(i) + ",");
			} else {
				str.append(list.get(i) + "");
			}
		}
		return str.toString();
	}
}
