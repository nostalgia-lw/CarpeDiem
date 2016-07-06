package com.carpe.system.dao.impl;

import com.carpe.system.dao.UserDao;
import com.carpe.system.support.hibernate.HibernateSession;
import org.springframework.stereotype.Repository;

/**
 * Created by wrj on 2016-07-06.
 */
@Repository
public class UserDaoImpl extends HibernateSession implements UserDao {

    @Override
    public Object saveObject(Object object) {
        return getSession().save(object) ;
    }


}
