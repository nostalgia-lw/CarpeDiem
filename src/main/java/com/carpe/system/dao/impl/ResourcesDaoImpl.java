package com.carpe.system.dao.impl;

import com.carpe.system.dao.ResourcesDao;
import com.carpe.system.entity.Resources;
import com.carpe.system.support.dao.impl.BaseDaoImpl;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ResourcesDaoImpl extends BaseDaoImpl<Resources> implements ResourcesDao {
	@Override
	public List<Resources> queryAllResources() {
		StringBuffer sb = new StringBuffer("from Resources r where r.isHide=1 ");
		List<Resources> res = super.findList(sb.toString());
		return res;
	}

	@Override
	public List<Resources> queryResourcesById(Long[] ids) {
		StringBuffer sb = new StringBuffer("from Resources r where r.id in(:ids)");
		List<Resources> res = (List<Resources>) getSession().createQuery(sb.toString()).setParameterList("ids", ids).list();
		return res;
	}

	@Override
	public Resources getResourcesByKey(String key) {
		StringBuffer hql = new StringBuffer("from Resources a where a.key = ?");
		Resources res = super.get(hql.toString(),key);
		return res;
	}

	@Override
	public Resources getResourcesByName(String name) {
		StringBuffer hql = new StringBuffer("from Resources a where a.name = ?");
		Resources res = super.get(hql.toString(),name);
		return res;
	}

}
