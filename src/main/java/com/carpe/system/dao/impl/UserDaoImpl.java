package com.carpe.system.dao.impl;

import com.carpe.system.dao.UserDao;
import com.carpe.system.entity.User;
import com.carpe.system.support.dao.impl.BaseDaoImpl;
import org.hibernate.Query;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wrj on 2016-07-06.
 */
@Repository
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {
    @Override
    public User getUserByloginName(String loginName) {
        StringBuffer hql = new StringBuffer("from User u where u.loginName = ?");
        User user = super.get(hql.toString(), loginName);
        return user;
    }

    @Override
    public List<User> findList() {
        String hql = "from User u where u.locked = "+User.NORMAL;
        return super.findList(hql);
    }

    @Override
    public List<User> getUsersByOrgIds(String orgIds) {
        String hql = " from User u where u.organization.id in("+orgIds+")";
        List<User> users = (List<User>) super.getSession().createQuery(hql).list();
        return users;
    }

    @Override
    public List getBySql(String sql) {
        Query query = getSession().createSQLQuery(sql);
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        return query.list();
    }

    @Override
    public Long getByCountSql(String sql) {
        return Long.parseLong(getSession().createSQLQuery(sql).uniqueResult().toString());
    }
    @Override
    public Object getUsersByOrgIdsReturnIds(String orgIds) {
        String hql = " select GROUP_CONCAT(u.id) from s_user u where u.org_id in("+orgIds+")";
        return getSession().createSQLQuery(hql).uniqueResult();
    }
}
