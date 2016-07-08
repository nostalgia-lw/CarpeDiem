package com.carpe.system.support.util;

/**
 * 日志对象
 * @author ll
 *
 */
public class LoggerUtils {
    /**
     * log对象
     */
    private static org.apache.log4j.Logger log = org.apache.log4j.Logger.getRootLogger();
    /**
     * 日志信息
     * @param message 输出信息
     */
    final public static void info(Object message) {
        log.info(message);
    }
    /**
     * 调试信息
     * @param message 输出信息
     */
    final public static void debug(Object message) {
        log.debug(message);
    }
    /**
     * 错误信息
     * @param message 输出信息
     */
    final public static void error(Object message) {
        log.error(message);
    }
    /**
     * 警告信息
     * @param message 输出信息
     */
    final public static void warn(Object message) {
        log.warn(message);
    }
    /**
     * 严重错误信息
     * @param message 输出信息
     */
    final public static void fatal(Object message) {
        log.fatal(message);
    }

}
