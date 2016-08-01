package com.carpe.system.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by wrj on 2016-07-08
 * 机构组织
 */
@Entity
@Table(name = "s_organization")
public class Organization implements Serializable {
    private static final long serialVersionUID = 7184999613986021558L;
    @Id
    @Column(name = "id", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;// ID
    /**
     * 名称
     */
    @Column(name = "name", length = 50)
    private String name;
    /**
     * 上级ID
     */
    @Column(name = "pid")
    private Long pid=0L;

    /**
     * 是否隐藏
     */
    @Column(name = "is_hide")
    private Boolean isHide;
    /**
     * 描述
     */
    @Column(name = "description", length = 255)
    private String description;
    /**
     * 岗位/部门
     */
    @Column(name="type",length = 2)
    private Integer type;

    /**
     * 排序
     */
    @Column(name = "sort", length = 4)
    private Integer sort;
    /**
     * 对应的用户
     */
    @OneToMany(cascade =CascadeType.ALL ,mappedBy = "organization")
    private List<User> userList;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Boolean getHide() {
        return isHide;
    }

    public void setHide(Boolean hide) {
        isHide = hide;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }
}
