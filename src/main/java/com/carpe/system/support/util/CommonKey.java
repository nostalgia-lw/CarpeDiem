package com.carpe.system.support.util;


/**
 * 公共
 * 
 * @author tanghom <tanghom@qq.com> 2015-11-18
 */
public class CommonKey {
	// 页面路径
	public static final String WEB_PATH = "WEB-INF/jsp";
	// UserSession
	public static final String USER_SESSION = "userSession";
	//UserSessionId
	public static final String USER_SESSION_ID = "userSessionId";
	// webscoketUserSession
	public static final String WEBSOCKET_USER_SESSION = "webscoketUserSession";

	
	//数据字典cache
	public static final String CACHE_KEY_DICTIONARY = "cacheKeyDictionary";
	
	//下载路径
	public static final String FILE_PATH = "http://172.16.23.65:1013/";

	// 部门用户JSON缓存
	public static final String CACHE_ORG_USER_JSON = "CACHE_ORG_USER_JSON";
	//部门缓存
	public static final String CACHE_ORG_JSON = "CACHE_ORG_JSON";
   //用户状态_禁用
	public  static  final  Byte USER_DISABLED_BYTE =0;
	//用户默认状态_启动
	public  static  final  Byte USER_NO_DISABLED_BYTE =1;
}
