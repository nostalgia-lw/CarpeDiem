package com.carpe.system.service.impl;

import com.carpe.system.dao.OrganizationDao;
import com.carpe.system.dao.UserDao;
import com.carpe.system.entity.Organization;
import com.carpe.system.entity.User;
import com.carpe.system.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 用户业务接口实现
 * Created by wrj on 2016-07-06.
 */
@Service
public class UserServiceImpl implements UserService  {
    private  static Logger logger =Logger.getLogger(UserServiceImpl.class);
    @Resource
    private UserDao userDao;
    @Resource
    private OrganizationDao organizationDao;

    @Override
    public void saveObject(User user)  {
       userDao.save(user);
    }

    @Override
    public void updateObject(User user) {
        userDao.update(user);
    }

    @Override
    public void testSave() {
            Organization organization = new Organization();
            organization.setName("组织机构测试3");
            organization.setDescription("组织机构描述");
            organization.setPid(0L);
           //organizationDao.save(organization);
            User user =new User();
            user.setName("测试");
            user.setSex("男");
            user.setLoginName("3025585");
            user.setPinyin("ceshi");
            user.setOrganization(organization);
            // user.setLoginPwd(String.valueOf(100/0));

            userDao.save(user);
    }
    @Override
    public  void getObject(){
        User user =userDao.getById(1L);
        Organization organization =user.getOrganization();
        System.out.print(organization.getId());

    }
    @Override
    public void deleteObject(){
        User user =userDao.getById(3l);
        userDao.delete(user);
    }
}
