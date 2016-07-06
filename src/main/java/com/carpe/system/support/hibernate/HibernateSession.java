package com.carpe.system.support.hibernate;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 创建hibernateSession
 * Created by wrj on 2016-07-06.
 */
public abstract class HibernateSession {
    @Autowired
    private SessionFactory sessionFactory;


    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    /**
     * 获取Hibernate会话
     *
     * @return Hibernate会话
     */
    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }
}
