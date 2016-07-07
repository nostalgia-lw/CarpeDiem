package com.carpe.system.dao.impl;

import com.carpe.system.dao.LogDao;
import com.carpe.system.entity.Log;
import com.carpe.system.support.hibernate.HibernateSession;
import org.springframework.stereotype.Repository;

/**
 * 日志数据接口实现
 * Created by wrj on 2016-07-07.
 */
@Repository
public class LogDaoImpl extends HibernateSession implements LogDao {

    @Override
    public void saveLog(Log log) {
        getSession().save(log);
    }
}
