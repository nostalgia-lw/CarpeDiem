package com.carpe.system.service.impl;

import com.carpe.system.dao.UserDao;
import com.carpe.system.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by wrj on 2016-07-06.
 */
@Service
public class UserServeceImpl implements UserService {
    @Resource
    private UserDao userDao;
    @Override
    public void saveObject(Object object) {
        userDao.saveObject(object);
    }
}
