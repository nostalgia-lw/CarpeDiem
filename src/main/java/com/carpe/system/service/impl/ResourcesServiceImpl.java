package com.carpe.system.service.impl;

import com.carpe.system.dao.ResourcesDao;
import com.carpe.system.dao.RoleDao;
import com.carpe.system.dao.UserDao;
import com.carpe.system.entity.Resources;
import com.carpe.system.entity.Role;
import com.carpe.system.entity.User;
import com.carpe.system.service.ResourcesService;
import com.carpe.system.support.tag.pagination.Pagination;
import com.carpe.system.support.util.CommonUtils;
import com.carpe.system.support.util.tree.SelectTreeUtil;
import com.carpe.system.support.util.tree.TreeObject;
import com.carpe.system.support.util.tree.TreeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ResourcesServiceImpl implements ResourcesService {
	@Autowired
	private ResourcesDao resourcesDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Override
	public List<TreeObject> queryResourcesTree() {
		StringBuffer sb = new StringBuffer("from Resources r where 1=1");
		List<Resources> resources = resourcesDao.findList(sb.toString());
		
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (Resources res : resources) {
			TreeObject ts = new TreeObject();
			ts.setId(res.getId().intValue());
			ts.setName(res.getName());
			ts.setParentId(res.getPid().intValue());
			ts.setResUrl(res.getUrl());
			ts.setIcon(res.getIcon());
			ts.setResKey(res.getKey());
			ts.setIshide(res.getIsHide());
			list.add(ts);
		}
		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0);
		return ns;
	}

	@Override
	public Resources getById(Long id) {
		return resourcesDao.getById(id);
	}

	@Override
	public List<TreeObject> queryResourcesTreeByUserId(Long userId) {
		List<Resources> resources = new ArrayList<Resources>();
		if(1L==userId){
			resources = resourcesDao.queryAllResources();
		}else{
			User user = userDao.getById(userId);
			List<Role> roles = user.getRoleList();
			for (Role role : roles) {
				/*List<Resources> ress = role.getResources();
				for (Resources res : ress) {
					if(!resources.contains(res)){   //查看新集合中是否有指定的元素，如果没有则加入
						resources.add(res);
					}
				}*/
			}
		}
		
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (Resources res : resources) {
			TreeObject ts = new TreeObject();
			ts.setId(res.getId().intValue());
			ts.setName(res.getName());
			ts.setParentId(res.getPid().intValue());
			ts.setResUrl(res.getUrl());
			ts.setResKey(res.getKey());
			ts.setIcon(res.getIcon());
			list.add(ts);
		}
		TreeUtil treeUtil = new TreeUtil();
		List<TreeObject> ns = treeUtil.getChildTreeObjects(list, 0);
		return ns;
	}

	@Override
	public List<Resources> queryResourcesByRoleId(Long roleId) {
		Role role = roleDao.getById(roleId);
		return null;
	}

	@Override
	public void update(Resources resources) {
		User loger = CommonUtils.getUserSession();
		resources.setUpdaterId(loger.getId());
		resources.setUpdaterName(loger.getName());
		resources.setUpdateTime(new Date());
		resourcesDao.update(resources);
		
	}

	@Override
	public void save(Resources resources) {
		User loger = CommonUtils.getUserSession();
		resources.setCreaterId(loger.getId());
		resources.setCreaterName(loger.getName());
		resources.setCreateTime(new Date());
		resourcesDao.save(resources);
		
	}

	@Override
	public Pagination<Resources> queryPageResources(Long curIndex, String name, Long pid) {
		Map<String, Object> params = new HashMap<String, Object>();
		StringBuffer sb = new StringBuffer("from Resources s where s.isHide = 1 ");
		if (null!=pid) {
			sb.append(" and s.pid = :pid ");
			params.put("pid", pid);
		}
		String countString = "select count(s.id) "+sb.toString();
		Pagination<Resources> page = new Pagination<Resources>();
		page.setCurIndex(curIndex);
		page = resourcesDao.findPagination(sb.append(" order by s.sort ").toString(),countString, page.getCurIndex(), page.getPageSize(), params);
		return page;
	}
	
	@Override
	public Resources getResourcesByKey(String key) {
		Resources res = resourcesDao.getResourcesByKey(key);
		return res;
	}

	@Override
	public Resources getResourcesByName(String name) {
		Resources res = resourcesDao.getResourcesByName(name);
		return res;
	}

	@Override
	public List<TreeObject> findToSelectTree() {
		List<Resources> res = resourcesDao.queryAllResources();
		List<TreeObject> list = new ArrayList<TreeObject>();
		for (Resources r : res) {
			TreeObject ts = new TreeObject();
			ts.setId(r.getId().intValue());
			ts.setName(r.getName());
			ts.setParentId(r.getPid().intValue());
			list.add(ts);
		}
		SelectTreeUtil selectTreeUtil = new SelectTreeUtil();
		List<TreeObject> tree = selectTreeUtil.listToTree(list, 0);
		return tree;
	}

	@Override
	public void delete(Resources resources) {
		resourcesDao.delete(resources);
	}

	@Override
	public List<Resources> queryAllResources() {
		StringBuffer sb = new StringBuffer("from Resources r where r.isHide=1");
		List<Resources> res = resourcesDao.findList(sb.toString());
		return res;
	}
}
