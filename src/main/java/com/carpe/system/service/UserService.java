package com.carpe.system.service;

import com.carpe.system.entity.User;

/**
 * Created by wrj on 2016-07-06.
 */
public interface UserService {
    void  saveObject(User user) throws NumberFormatException;
    void  updateObject(User user);

}
