package com.woshou.mgmt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.woshou.common.dao.BaseDao;
import com.woshou.mgmt.common.persistence.annotation.MyBatisDao;
import com.woshou.mgmt.dto.OrderStaResult;
import com.woshou.mgmt.entity.TabOrderform;
@MyBatisDao
public interface TabOrderformDao extends BaseDao<TabOrderform> {
	/**
	 * 收货
	 * @param rnw
	 * @param losston
	 * @return
	 */
	int shouHuo(@Param("id")int id,@Param("rnw")String rnw,@Param("losston")String losston);
	/**
	 * 设置结算状态
	 * 
	 * @param orderId
	 * @return
	 */
	int setOrderOverStatus(@Param("orderId")int orderId);
	
	List<TabOrderform> queryAll();
	
	/**
	 * 统计所有订单
	 * 
	 * @return
	 */
	OrderStaResult countForAllOrder(TabOrderform tabOrderform);
	/**
	 * 查询当天记录最新编号
	 * 
	 * @return
	 */
	int getNextIndexByCurrentDay();
}
