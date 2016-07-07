package com.carpe.system.dao;

/**
 *
 * Created by wrj on 2016-07-06.
 */
public interface UserDao {
    void saveObject(Object object);
    void updateObject(Object object);
    void  saveOrUpdateOjbect(Object object);
    Object getObject(Long id);
}
