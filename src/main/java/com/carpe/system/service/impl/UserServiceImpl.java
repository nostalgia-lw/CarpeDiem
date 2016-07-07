package com.carpe.system.service.impl;

import com.carpe.system.dao.UserDao;
import com.carpe.system.entity.User;
import com.carpe.system.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by wrj on 2016-07-06.
 */
@Service
public class UserServiceImpl implements UserService  {
    private  static Logger logger =Logger.getLogger(UserServiceImpl.class);
    @Resource
    private UserDao userDao;
    @Override
    public void saveObject(User user)  {
       userDao.saveObject(user);
    }

    @Override
    public void updateObject(User user) {
        userDao.updateObject(user);
    }
}
