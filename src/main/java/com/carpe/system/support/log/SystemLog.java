package com.carpe.system.support.log;
  
import java.lang.annotation.*;

/** 
 *自定义注解 拦截Controller 
 */  
  
@Target({ElementType.PARAMETER, ElementType.METHOD})  
@Retention(RetentionPolicy.RUNTIME)  
@Documented  
public  @interface SystemLog {  
  
	String methods()  default "";  //模块名称 系统管理-用户管理－列表页面
    String description()  default "";  //
}  
  
