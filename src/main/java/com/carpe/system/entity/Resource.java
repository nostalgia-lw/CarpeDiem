package com.carpe.system.entity;

import com.carpe.system.support.entity.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by wrj on 2016-07-08
 */
@Entity
@Table(name="s_resource")
public class Resource extends BaseEntity {
    private static final long serialVersionUID = -5613371163678556783L;
    /**
     * 名称
     */
    @Column(name = "name", length = 50)
    private String name;
    /**
     * 唯一标识
     */
    @Column(name = "res_key", length = 50)
    private String key;
    /**
     * 地址
     */
    @Column(name = "url", length = 200)
    private String url;
    /**
     * 上级ID
     */
    @Column(name = "pid")
    private Long pid;

    /**
     * 类型（目录，菜单，按钮/操作）
     */
    @Column(name = "type", length = 4)
    private Integer type;
    /**
     * 图标
     */
    @Column(name = "icon", length = 50)
    private String icon;
    /**
     * 是否隐藏
     */
    @Column(name = "is_hide")
    private Integer isHide;
    /**
     * 描述
     */
    @Column(name = "description", length = 255)
    private String description;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getIsHide() {
        return isHide;
    }

    public void setIsHide(Integer isHide) {
        this.isHide = isHide;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
