package com.carpe.system.aop;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * 记录执行时间
 * Created by wrj on 2016-07-11
 */
@Aspect
@Component
public class RunTimeAspect {
    private Logger log =Logger.getLogger(RunTimeAspect.class);

    @Pointcut("execution(* com.carpe.system.service.*.*(..))")
    public void  businessPoint(){}

    /**
     * 记录运行时间
     */
    @Around(value ="businessPoint()")
    public Object recordAroundRunTime(ProceedingJoinPoint pjp){
        long start = System.currentTimeMillis();
        Object data = null;
        try {
             data =  pjp.proceed();
            long end = System.currentTimeMillis();
            if(log.isInfoEnabled()){
                log.info("[LOG-INFO] around " + pjp.toString() + "\tUse time : " + (end - start) + " ms!");
            }
        } catch (Throwable e) {
            long end = System.currentTimeMillis();
            if(log.isInfoEnabled()){
                log.info("[LOG-INFO] around " + pjp.toString() + "\tUse time : " + (end - start) + " ms with exception : " + e.getMessage());
            }
        }
        return data;
    }

}
