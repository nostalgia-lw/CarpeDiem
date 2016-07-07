package com.carpe.system.proxy;


import com.carpe.system.service.UserService;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * 动态代理创建日志
 * Created by wrj on 16-7-7.
 */
public class ProxyLog {
    //目标代理对象
    private UserService target;

    public ProxyLog(UserService target) {
        this.target = target;
    }

    public  UserService getUserService(){
        UserService proxy =null;
        //代理的加载器
        ClassLoader loader =target.getClass().getClassLoader();
        //代理类的方法
        Class [] interfaces = new  Class[]{UserService.class};
        //调用代理对象中的方法调用
        InvocationHandler invocation = new InvocationHandler() {
            @Override
            public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                //执行代理方法
                method.invoke(target,args);
                return 0;
            }
        };
        proxy = (UserService) Proxy.newProxyInstance(loader,interfaces,invocation);
        return  proxy;
    }
}

