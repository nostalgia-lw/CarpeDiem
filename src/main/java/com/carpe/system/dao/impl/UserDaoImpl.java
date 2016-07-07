package com.carpe.system.dao.impl;

import com.carpe.system.dao.UserDao;
import com.carpe.system.entity.User;
import com.carpe.system.support.hibernate.HibernateSession;
import org.springframework.stereotype.Repository;

/**
 * Created by wrj on 2016-07-06.
 */
@Repository
public class UserDaoImpl extends HibernateSession implements UserDao {

    @Override
    public void saveObject(Object object) {
         getSession().save(object) ;
    }

    @Override
    public void updateObject(Object object) {
         getSession().update(object);
    }

    @Override
    public void saveOrUpdateOjbect(Object object) {
        getSession().saveOrUpdate(object);
    }

    @Override
    public Object getObject(Long id) {
        return  getSession().get(User.class,id);
    }


}
