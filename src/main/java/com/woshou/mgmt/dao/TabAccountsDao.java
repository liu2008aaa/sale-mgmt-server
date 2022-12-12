package com.woshou.mgmt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.woshou.common.dao.BaseDao;
import com.woshou.mgmt.common.persistence.annotation.MyBatisDao;
import com.woshou.mgmt.dto.CostStaResult;
import com.woshou.mgmt.entity.TabAccounts;
@MyBatisDao
public interface TabAccountsDao extends BaseDao<TabAccounts> {
	TabAccounts getByOrderId(@Param("orderId")int orderId);
	List<TabAccounts> queryAll();
	/**
	 * 统计
	 * 
	 * @param tabAccounts
	 * @return
	 */
	CostStaResult countForAll(TabAccounts tabAccounts);
}
