package com.carpe.system.service;

import com.carpe.system.entity.User;

/**
 * 用户业务接口
 * Created by wrj on 2016-07-06.
 */
public interface UserService {
    void  saveObject(User user) throws NumberFormatException;
    void  updateObject(User user);
    void  testSave();
     void getObject();
    public void deleteObject();

}
