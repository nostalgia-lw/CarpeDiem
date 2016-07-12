package com.carpe.system.service.impl;

import com.carpe.system.dao.RoleDao;
import com.carpe.system.entity.Organization;
import com.carpe.system.entity.Role;
import com.carpe.system.entity.User;
import com.carpe.system.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 角色业务实现
 * Created by wrj on 2016-07-12
 */
@Service
public class RoleServiceImpl implements RoleService {
     @Resource
     private RoleDao roleDao;
    @Override
    public void saveManyToMany() {
        Role role = new Role();
        role.setName("超级管理员");
        role.setDescription("系统管理员负责对系统的一个维护以及权限的分配");
        role.setKey("root");
        List<User> userList = new ArrayList<>();
        for (int i=0;i<5;i++){
            User user  =new User();
            Organization organization = new Organization();
            user.setName("角色测试");
            user.setOrganization(organization);
            user.setPinyin("jueseceshi");
            userList.add(user);
        }
        role.setUserList(userList);
        roleDao.save(role);
    }
}
