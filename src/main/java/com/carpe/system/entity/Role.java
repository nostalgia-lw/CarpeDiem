package com.carpe.system.entity;

import com.carpe.system.support.entity.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by wrj on 2016-07-08
 *角色
 */
@Entity
@Table(name="s_role")
public class Role extends BaseEntity {

    private static final long serialVersionUID = 3957597646437317628L;
    /**
     * 名称
     */
    @Column(name = "name", length = 30)
    private String name;
    /**
     * 唯一标识
     */
    @Column(name = "role_key", length = 30)
    private String key;
    /**
     * 描述
     */
    @Column(name = "description", length = 200)
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
