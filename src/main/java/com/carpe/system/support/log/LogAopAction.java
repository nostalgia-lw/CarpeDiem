package com.carpe.system.support.log;

import com.carpe.system.dao.LogDao;
import com.carpe.system.entity.Log;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * 切点类
 * 
 * @author tanghom
 * @since 2015-05-05 Pm 20:35
 * @version 1.0
 */
@Component
public class LogAopAction {
	// 本地异常日志记录对象
	private static final Logger logger = LoggerFactory.getLogger(LogAopAction.class);
	@Autowired
	private LogDao logDao;

	// Controller层切点
	@Pointcut("@annotation(com.cddgg.system.support.log.SystemLog)")
	public void controllerAspect() {
	}

	/**
	 * 操作异常记录
	 * 
	 * @descript
	 * @param point
	 * @param e
	 * @author tanghom
	 * @date 2015年5月5日
	 * @version 1.0
	 */
	@AfterThrowing(pointcut = "controllerAspect()", throwing = "e")
	public void doAfterThrowing(JoinPoint point, Throwable e) throws Exception {
		Map<String,Object> map  =getControllerMethodDescription(point);
		Log log =new Log();
		log.setMethods(map.get("methods") + "");
		log.setDescription(map.get("description")+"");
		logDao.saveLog(log);

	}

	/**
	 * 前置通知 用于拦截Controller层记录用户的操作
	 * 
	 * @param point
	 *            切点
	 */
	@Around("controllerAspect()")
	public Object doController(ProceedingJoinPoint point) {

		return null;
	}

	/**
	 * 获取注解中对方法的描述信息 用于Controller层注解
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map<String, Object> getControllerMethodDescription(JoinPoint joinPoint) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					map.put("methods", method.getAnnotation(SystemLog.class).methods());
					String de = method.getAnnotation(SystemLog.class).description();
					if (de==null || de.trim().length()==0)
						de = "执行成功!";
					map.put("description", de);
				}
			}
		}
		return map;
	}
}
