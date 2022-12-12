package com.woshou.mgmt.dao;

import org.apache.ibatis.annotations.Param;

import com.woshou.common.dao.BaseDao;
import com.woshou.mgmt.common.persistence.annotation.MyBatisDao;
import com.woshou.mgmt.entity.TabLosston;
@MyBatisDao
public interface TabLosstonDao extends BaseDao<TabLosston> {
	
	TabLosston getByOrderId(@Param("orderId")int orderId);
}
