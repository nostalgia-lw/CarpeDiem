package com.carpe.system.service;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by wrj on 2016-07-07.
 */
public class LogServiceTest {
    private ApplicationContext context=null;
    private LogService logService =null;
    {
        context = new ClassPathXmlApplicationContext("spring-application-context.xml");
        logService =context.getBean(LogService.class);
    }
    @Test
    public void saveLog() throws Exception {

    }

}