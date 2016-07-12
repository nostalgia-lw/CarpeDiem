package com.carpe.system.service.impl;

import com.carpe.system.dao.OrganizationDao;
import com.carpe.system.dao.UserDao;
import com.carpe.system.entity.Organization;
import com.carpe.system.entity.User;
import com.carpe.system.service.OrganizationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 组织机构业务实现
 * Created by wrj on 2016-07-11
 */
@Service
public class OrganizationServiceImpl implements OrganizationService {
    @Resource
    private OrganizationDao organizationDao;
    @Resource
    private UserDao userDao;
    @Override
    public void saveOrganization(Organization organization) {
        organizationDao.save(organization);
    }
    public void  testSaveOrganization(){
        Organization organization = new Organization();
        organization.setName("组织机构测试");
        organization.setDescription("组织机构描述");
        organization.setPid(0l);
        organizationDao.save(organization);
        List<User> list =new ArrayList<>();
        for(int i=0;i<3;i++){
            User user =new User();
            user.setName("用户姓名");
            user.setPinyin("yonghuxingming");
            user.setLoginName("32683683");
            user.setOrganization(organization);
            //user.setSex(String.valueOf(100/0));
            userDao.save(user);
            list.add(user);
        }
       organization.setUserList(list);

    }
    @Override
    public  void getOrganization(){
        Organization organization =organizationDao.getById(1l);
        System.out.println(organization.getUserList().size());
    }


}
