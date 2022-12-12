package com.woshou.mgmt.service;

import java.util.List;

import com.woshou.common.entity.Page;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.dto.OrderStaResult;
import com.woshou.mgmt.entity.TabOrderform;

public interface TabOrderformService {

	TabOrderform queryId(int id);
	
	List<TabOrderform> queryAll(TabOrderform tabOrderform);

	Page<TabOrderform> getByPage(TabOrderform tabOrderform,
			Page<TabOrderform> page);
	
	ResultData<Boolean> create(TabOrderform orderform);
	
	ResultData<Boolean> modify(TabOrderform orderform);
	
	ResultData<Boolean> remove(int id);

	ResultData<Boolean> shouHuo(TabOrderform tabOrderform);
	/**
	 * 设置结算状态
	 * 
	 * @param orderId
	 * @return
	 */
	int setOrderOverStatus(int orderId);
	/**
	 * 统计所有订单
	 * 
	 * @return
	 */
	OrderStaResult countForAllOrder(TabOrderform tabOrderform);
}
