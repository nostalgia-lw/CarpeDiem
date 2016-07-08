package com.carpe.system.entity;

import com.carpe.system.support.entity.BaseEntity;

import javax.persistence.*;

/**
 * 用户
 * Created by wrj on 2016-07-06.
 */
@Entity
@Table(name="s_user")
public class User extends BaseEntity {
    private static final long serialVersionUID = 2274756067777579057L;
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
    /**
     * 用户所属部门
     */
    @ManyToOne(cascade = CascadeType.REFRESH,fetch = FetchType.LAZY )
    @JoinColumn(name = "organnization_id")
    private Organization organization;

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPinyin() {
        return pinyin;
    }

    public void setPinyin(String pinyin) {
        this.pinyin = pinyin;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }
}
