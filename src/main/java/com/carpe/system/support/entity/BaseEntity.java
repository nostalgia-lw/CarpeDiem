package com.carpe.system.support.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

/**
 * 实体父类
 * Created by wrj on 2016-07-06.
 */
@MappedSuperclass
public abstract class BaseEntity implements Serializable {

    private static final long serialVersionUID = 154137003015781641L;
    /**
     * ID
     */
    @Column(name = "id", unique = true, nullable = false)
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    /**
     * uuid
     */
    @Column(name="uu_id",length = 50)
    private String uuId = UUID.randomUUID().toString();
    /**
     * 创建时间
     */
    @Column(name = "create_time", columnDefinition = "datetime")
    private Date createTime;
    /**
     * 创建人ID
     */
    @Column(name = "creater_id")
    private Long createrId;
    /**
     * 创建人姓名
     */
    @Column(name = "creater_name")
    private String createrName;

    /**
     * 更新时间
     */
    @Column(name = "update_time", columnDefinition = "datetime")
    private Date updateTime;
    /**
     * 修改人ID
     */
    @Column(name = "updater_id")
    private Long updaterId;
    /**
     * 修改人姓名
     */
    @Column(name = "updater_name")
    private String updaterName;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUuId() {
        return uuId;
    }

    public void setUuId(String uuId) {
        this.uuId = uuId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getCreaterId() {
        return createrId;
    }

    public void setCreaterId(Long createrId) {
        this.createrId = createrId;
    }

    public String getCreaterName() {
        return createrName;
    }

    public void setCreaterName(String createrName) {
        this.createrName = createrName;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getUpdaterId() {
        return updaterId;
    }

    public void setUpdaterId(Long updaterId) {
        this.updaterId = updaterId;
    }

    public String getUpdaterName() {
        return updaterName;
    }

    public void setUpdaterName(String updaterName) {
        this.updaterName = updaterName;
    }
}
