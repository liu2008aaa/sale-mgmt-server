package com.woshou.mgmt.service;

import java.util.List;

import com.woshou.common.entity.Page;
import com.woshou.common.exception.PlatformException;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.dto.CostStaResult;
import com.woshou.mgmt.entity.TabAccounts;

public interface TabAccountsService {

	TabAccounts queryId(int id);

	TabAccounts getByOrderId(int orderId);

	int modify(TabAccounts tabAccounts);

	int create(TabAccounts tabAccounts);
	/**
	 * 与发货单位结算
	 * @param tabAccounts
	 * @return
	 */
	ResultData<Boolean> toBalanceAccountsForSend(TabAccounts tabAccounts,String type)throws PlatformException;
	/**
	 * 统计查询
	 * 
	 * @param tabAccounts
	 * @param page
	 * @return
	 */
	Page<TabAccounts> getByPage(TabAccounts tabAccounts,Page<TabAccounts> page);
	
	List<TabAccounts> queryAll(TabAccounts tabAccounts);
	/**
	 * 统计
	 * 
	 * @param tabAccounts
	 * @return
	 */
	CostStaResult countForAll(TabAccounts tabAccounts);
}
