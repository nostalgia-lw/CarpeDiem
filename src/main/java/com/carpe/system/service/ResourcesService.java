package com.carpe.system.service;


import com.carpe.system.entity.Resources;
import com.carpe.system.support.tag.pagination.Pagination;
import com.carpe.system.support.util.tree.TreeObject;

import java.util.List;

/**
 * 菜单，资源管理逻辑层
 * @author tanghom <tanghom@qq.com> 2015-11-18
 *
 */
public interface ResourcesService {
	
	/**
	 * 获取所有菜单，返回tree
	 * @return
	 */
	public List<TreeObject> queryResourcesTree();
	/**
	 * 根据ID查询
	 * @param id
	 * @return
	 */
	public Resources getById(Long id);
	/**
	 * 更新菜单
	 * @param resources
	 */
	public void update(Resources resources);
	
	/**
	 * 新增菜单
	 * @param resources
	 */
	public void save(Resources resources);
	/**
	 * 删除菜单
	 * @param resources
	 */
	public void delete(Resources resources);
	/**
	 * 根据ID查询
	 */
	public List<TreeObject> queryResourcesTreeByUserId(Long userId);
	/**
	 * 根据角色ID查询菜单
	 * @param roleId
	 * @return
	 */
	public List<Resources> queryResourcesByRoleId(Long roleId);
	
	
	/**
	 * 查询分页
	 * @return
	 */
	public Pagination<Resources> queryPageResources(Long curIndex, String name, Long pid);
	
	/**
	 * 根据KEY查询
	 * @param key
	 * @return
	 */
	public Resources getResourcesByKey(String key);
	
	/**
	 * 根据name查询
	 * @param name
	 * @return
	 */
	public Resources getResourcesByName(String name);
	
	/**
	 * 查询返回下拉选择框
	 * @return
	 */
	public List<TreeObject> findToSelectTree();

	/**
	 * 查询所有菜单
	 * @return
     */
	public List<Resources> queryAllResources();
}
