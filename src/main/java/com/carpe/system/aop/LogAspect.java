package com.carpe.system.aop;

import com.carpe.system.entity.Log;
import com.carpe.system.service.LogService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

import javax.annotation.Resource;
import java.lang.reflect.Method;

/**
 * Created by wrj on 2016-07-07.
 * 日志
 */
@Aspect
public class LogAspect {
    @Resource
    private LogService logService;

    /**
     * 添加业务方法逻辑切入点
     */
    @Pointcut("execution(* com.carpe.system.service.impl.UserServeceImpl.save*(..))")
    public  void  insertService(){}

    /**
     * 修改业务方法逻辑切入点
     */
    @Pointcut("execution(* com.carpe.system.service.impl.UserServeceImpl.update*(..))")
    public  void  updateService(){}

    /**
     * 删除业务方法逻辑切入点
     */
    @Pointcut("execution(* com.carpe.system.service.impl.UserServeceImpl.delete*(..))")
    public  void  deleteService(){}

    /**
     * 后置通知,插入数据记录日志
     * @param joinPoint
     */
    @AfterReturning(value="insertService()")
    public void  saveService(JoinPoint joinPoint){
         String methodName =joinPoint.getSignature().getName();
        //获取操作内容
        String opContent = getActionContent(joinPoint.getArgs(), methodName);
        Log log  =new Log();
        log.setDescription(opContent);
        logService.saveLog(log);
    }

    /**
     * 后置通知,修改数据记录日志
     * @param joinPoint
     */
    @AfterReturning(value="updateService()")
    public void  updateServiceLog(JoinPoint joinPoint){
        String methodName =joinPoint.getSignature().getName();
        //获取操作内容
        String opContent = getActionContent(joinPoint.getArgs(), methodName);
        Log log  =new Log();
        log.setDescription(opContent);
        logService.saveLog(log);
    }
    public  String  getActionContent(Object[] args,String mName){
        if(args==null){
            return  null;
        }
        StringBuffer sb = new StringBuffer();
        sb.append(mName);
        String className =null;
        int index =1;
        for (Object info:args){
            //获取对象类型
            className = info.getClass().getName();
            className = className.substring(className.lastIndexOf(".") + 1);
            sb.append("[参数" + index + "，类型：" + className + "，值：");
            // 获取对象的所有方法
            Method[] methods = info.getClass().getDeclaredMethods();
            // 遍历方法，判断get方法
            for (Method method : methods) {

                String methodName = method.getName();
                // 判断是不是get方法
                if (methodName.indexOf("get") == -1) {// 不是get方法
                    continue;// 不处理
                }

                Object rsValue = null;
                try {

                    // 调用get方法，获取返回值
                    rsValue = method.invoke(info);

                    if (rsValue == null) {//没有返回值
                        continue;
                    }

                } catch (Exception e) {
                    continue;
                }

                //将值加入内容中
                sb.append("(" + methodName + " : " + rsValue + ")");
            }

            sb.append("]");

            index++;
        }
        return  sb.toString();
    }

}
