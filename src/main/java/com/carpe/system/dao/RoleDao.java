package com.carpe.system.dao;

import com.carpe.system.entity.Role;
import com.carpe.system.support.dao.BaseDao;

import java.util.List;

/**
 * 角色数据接口
 * Created by wrj on 2016-07-08
 */
public interface RoleDao extends BaseDao<Role> {
    /**
     * 根据Key查询角色
     * @param key
     * @return
     */
    public Role getRoleByKey(String key);
    /**
     * 根据name查询角色
     * @param name
     * @return
     */

    public Role getRoleByName(String name);
    /**
     * 根据角色ID集合查询角色集合
     * @param ids
     * @return
     */
    public List<Role> queryRolesById(Long[] ids);
}
