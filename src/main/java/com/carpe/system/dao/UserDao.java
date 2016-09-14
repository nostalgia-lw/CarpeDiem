package com.carpe.system.dao;

import com.carpe.system.entity.User;
import com.carpe.system.support.dao.BaseDao;

import java.util.List;

/**
 *
 * Created by wrj on 2016-07-06.
 */
public interface UserDao extends BaseDao<User> {
    /**
     * 根据登录名查询用户
     * @param loginName
     * @return
     */
    User getUserByloginName(String loginName);

    /**
     * 查询所有用户
     * @return
     */
    List<User> findList();
    /**
     * 根据部门查询员工
     * @param orgIds
     * @return
     */
    List<User> getUsersByOrgIds(String orgIds);

    /**
     * 根据部门查询员工
     * @param orgIds
     * @return
     */
    Object getUsersByOrgIdsReturnIds(String orgIds);
    /**
     *
     * @param sql
     * @return
     */
    List getBySql(String sql);
    /**
     * 统计
     * @param sql
     * @return
     */
    Long getByCountSql(String sql);

}
