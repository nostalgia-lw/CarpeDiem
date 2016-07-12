package com.carpe.system.entity;

import com.carpe.system.support.entity.BaseEntity;
import org.hibernate.annotations.*;
import org.hibernate.annotations.CascadeType;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.List;

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
    @ManyToOne(fetch = FetchType.LAZY,optional = false)
    @Cascade(value = CascadeType.SAVE_UPDATE)
    @JoinColumn(name = "organnization_id")
    private Organization organization;
    /**
     * 用户所属角色
     */
    @ManyToMany()
    @Cascade(CascadeType.SAVE_UPDATE)
    @JoinTable(name="s_user_role",joinColumns = {@JoinColumn(name="user_id")},inverseJoinColumns = {@JoinColumn(name="role_id")})
    private List<Role> roleList;

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

    public List<Role> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Role> roleList) {
        this.roleList = roleList;
    }
}
