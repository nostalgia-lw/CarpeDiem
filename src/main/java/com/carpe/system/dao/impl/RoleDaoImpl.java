package com.carpe.system.dao.impl;

import com.carpe.system.dao.RoleDao;
import com.carpe.system.entity.Role;
import com.carpe.system.support.dao.impl.BaseDaoImpl;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 角色数据接口实现
 * Created by wrj on 2016-07-08
 */
@Repository
public class RoleDaoImpl extends BaseDaoImpl<Role> implements RoleDao {
    @Override
    public List<Role> queryRolesById(Long[] ids) {
        StringBuffer sb = new StringBuffer("from Role r where r.id in(:ids)");
        List<Role> roles = (List<Role>) getSession().createQuery(sb.toString()).setParameterList("ids", ids).list();
        return roles;
    }

    @Override
    public Role getRoleByName(String name) {
        StringBuffer hql = new StringBuffer("from Role a where a.name = ?");
        Role role = super.get(hql.toString(),name);
        return role;
    }

    @Override
    public Role getRoleByKey(String key) {
        StringBuffer hql = new StringBuffer("from Role a where a.key = ?");
        Role role = super.get(hql.toString(),key);
        return role;
    }
}
