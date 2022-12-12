package com.woshou.mgmt.service;

import com.woshou.mgmt.entity.TabLosston;
/**
 * 亏吨相关
 * 
 * @author liuqc
 *
 */
public interface TabLosstonService {
	/**
	 * 根据订单号查询
	 * 
	 * @param orderId
	 * @return
	 */
	TabLosston getByOrderId(int orderId);

	TabLosston queryId(int id);
	
	int create(TabLosston tabLosston);
	
	int modify(TabLosston tabLosston);
}
