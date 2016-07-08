package com.carpe.system.support.util;

import java.util.HashMap;
import java.util.Map;


/**
 * 添加用户到在线列表
 * @author liulei
 *
 */
public class SingleOnlineUser {
    /**
     * 静态在线数组
     */
    private static Map<String, String> mapOnline = new HashMap<String, String>();

    /**
     * 将用户添加到在线列表
     * @param name 用户名
     * @param sessionId sessionID
     */
    public static synchronized void addUser(String name, String sessionId) {
        if (mapOnline.containsKey(name))
            mapOnline.remove(name);    
        mapOnline.put(name, sessionId);
    }

    /**
     * 是否为合法用户
     * @param name 用户名
     * @param sessionId sessionID
     * @return true 返回值
     */
    public static boolean isValidUser(String name, String sessionId) {
        if (!mapOnline.containsKey(name))
            return false;
        
        if (!mapOnline.get(name).equals(sessionId))
            return false;

        return true;
    }
    /**
     * 给数组赋值
     * @return mapOnline
     */
    public static Map<String, String> getMapOnline() {
        return mapOnline;
    }
    /**
     * 取出在线数组
     * @param mapOnline 在线数组
     */
    public static void setMapOnline(Map<String, String> mapOnline) {
        SingleOnlineUser.mapOnline = mapOnline;
    }
    
}
