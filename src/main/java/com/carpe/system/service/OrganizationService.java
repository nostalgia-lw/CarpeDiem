package com.carpe.system.service;

import com.carpe.system.entity.Organization;

/**
 * 组织机构业务接口
 * Created by wrj on 2016-07-11
 */
public interface OrganizationService {
    void saveOrganization(Organization organization);
    public void  testSaveOrganization();
    public  void getOrganization();
}
