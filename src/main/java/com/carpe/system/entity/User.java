package com.carpe.system.entity;

import com.carpe.system.support.entity.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 用户
 * Created by wrj on 2016-07-06.
 */
@Entity
@Table(name="s_user")
public class User extends BaseEntity {
    /**
     * 登录帐号
     */
    @Column(name = "login_name", length = 30)
    private String loginName;
    /**
     * 登录密码
     */
    @Column(name = "login_pwd", length = 128)
    private String loginPwd;
    /**
     * 姓名
     */
    @Column(name = "name", length = 30)
    private String name;
    /**
     * 姓名拼音
     */
    @Column(name = "pinyin", length = 30)
    private String pinyin;
    /**
     * 性别
     */
    @Column(name = "sex", length = 10)
    private String sex;
}
