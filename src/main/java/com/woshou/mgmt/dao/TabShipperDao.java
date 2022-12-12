package com.woshou.mgmt.dao;

import org.apache.ibatis.annotations.Param;

import com.woshou.common.dao.BaseDao;
import com.woshou.mgmt.common.persistence.annotation.MyBatisDao;
import com.woshou.mgmt.entity.TabShipper;
@MyBatisDao
public interface TabShipperDao extends BaseDao<TabShipper> {
	
	TabShipper queryByName(@Param("name")String name);
	/**
	 * 设置余额
	 * 
	 * @param shipperId
	 * @param money
	 * @return
	 */
	int setShipperMoney(@Param("shipperId")int shipperId,@Param("money")String money);
}
