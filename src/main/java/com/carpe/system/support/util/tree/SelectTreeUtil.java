package com.carpe.system.support.util.tree;

import java.util.ArrayList;
import java.util.List;

/**
 * 生成多层树状下拉选框的工具模型
 * 
 * @author tanghom <tanghom@qq.com> 2015-11-18
 */
public class SelectTreeUtil {

	/**
	 * 根据父节点的ID获取所有子节点
	 * 
	 * @param list
	 *            分类表
	 * @param praentId
	 *            传入的父节点ID
	 * @return String
	 */
	public List<TreeObject> listToTree(List<TreeObject> list, int praentId) {
		List<TreeObject> returnList =  recursionFn(list,praentId, 0);
		return returnList;
	}

	/**
	 * 递归列表
	 * 
	 * @author tanghom
	 * @date 2013-12-4 下午7:27:30
	 * @param list
	 * @param TreeObject
	 * @return 
	 */
	private List<TreeObject> formatTreeList = new ArrayList<TreeObject>();
	private List<TreeObject> recursionFn(List<TreeObject> list, int praentId,int level) {
			String nbsp ="";
			for (int i = 0; i < level-1; i++) {
				nbsp += "&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			if(level!=0){
				nbsp+="└─";
			}
			for (TreeObject treeObject : list) {
				if(praentId == treeObject.getParentId().intValue()){
					treeObject.setName(nbsp+treeObject.getName());
					formatTreeList.add(treeObject);
					recursionFn(list, treeObject.getId(), level+1);
				}
			}
		return formatTreeList;
	}


	// 本地模拟数据测试
	public static void main(String[] args) {

		long start = System.currentTimeMillis();
		List<TreeObject> TreeObjectList = new ArrayList<TreeObject>();
		TreeObject t1 = new TreeObject();
		t1.setId(1);
		t1.setName("t1");
		t1.setParentId(0);
		TreeObject t2 = new TreeObject();
		t2.setId(2);
		t2.setName("t2");
		t2.setParentId(1);
		TreeObject t3 = new TreeObject();
		t3.setId(3);
		t3.setName("t3");
		t3.setParentId(2);
		TreeObject t4 = new TreeObject();
		t4.setId(4);
		t4.setName("t4");
		t4.setParentId(0);
		TreeObjectList.add(t1);
		TreeObjectList.add(t2);
		TreeObjectList.add(t3);
		TreeObjectList.add(t4);
		SelectTreeUtil st = new SelectTreeUtil();
		List<TreeObject> ns = st.listToTree(TreeObjectList, 0);
		for (TreeObject m : ns) {
			System.out.println(m.getName());
		}
		long end = System.currentTimeMillis();
		System.out.println("用时:" + (end - start) + "ms");
	}

}
