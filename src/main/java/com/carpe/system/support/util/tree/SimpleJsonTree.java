package com.carpe.system.support.util.tree;

/**
 * 简单json tree 
 * 	[{"id":1,"pId":0,"name":"工商注册"},{"id":2,"pId":0,"name":"融资贷款"}]
 * @author tanghom <tanghom@qq.com> 2015-11-18
 */
public class SimpleJsonTree {

	private Integer id;
	private Integer pId;
	private String name;
	private Boolean open = false;
	private String icon;
	private Integer type; // 0 部门 1 个人
	
	public SimpleJsonTree(Integer id, Integer pId, String name) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
	}
	public SimpleJsonTree(Integer id, Integer pId, String name,Boolean open) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.open = open;
	}
	
	
	public SimpleJsonTree(Integer id, Integer pId, String name, Boolean open,
			String icon) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.open = open;
		this.icon = icon;
	}

	public SimpleJsonTree(Integer id, Integer pId, String name, Boolean open, String icon, Integer type) {
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.open = open;
		this.icon = icon;
		this.type = type;
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
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getpId() {
		return pId;
	}
	public void setpId(Integer pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Boolean getOpen() {
		return open;
	}
	public void setOpen(Boolean open) {
		this.open = open;
	}

	


	
}
