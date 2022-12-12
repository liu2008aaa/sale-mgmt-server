package com.woshou.mgmt.service;

import java.util.List;

import com.woshou.common.entity.Page;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.entity.TabShipper;

public interface TabShipperService {

	List<TabShipper> getAllTabShippers();
	
	TabShipper queryById(int id);

	Page<TabShipper> getByPage(TabShipper tabShipper, Page<TabShipper> page);
	
	ResultData<Boolean> create(TabShipper tabShipper);
	
	ResultData<Boolean> modify(TabShipper tabShipper);
	
	ResultData<Boolean> remove(int id);
	/**
	 * 设置余额
	 * 
	 * @param shipperId
	 * @param money
	 * @return
	 */
	int setShipperMoney(int shipperId,String money);
}
