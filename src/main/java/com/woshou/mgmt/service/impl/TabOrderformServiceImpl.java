package com.woshou.mgmt.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.woshou.base.util.DateTool;
import com.woshou.common.entity.Page;
import com.woshou.common.message.CommonMessage;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.dao.TabOrderformDao;
import com.woshou.mgmt.dto.OrderStaResult;
import com.woshou.mgmt.entity.TabOrderform;
import com.woshou.mgmt.service.TabOrderformService;

@Service("tabOrderformService")
public class TabOrderformServiceImpl implements TabOrderformService {
	private final static Logger LOG = Logger.getLogger(TabOrderformServiceImpl.class);
	@Autowired
    private TabOrderformDao tabOrderformDao;
	@Override
	public TabOrderform queryId(int id) {
		return tabOrderformDao.queryById(id);
	}
	@Override
	public Page<TabOrderform> getByPage(TabOrderform tabOrderform,
			Page<TabOrderform> page) {
		page.setOrderBy("id desc");
		tabOrderform.setPage(page);
		List<TabOrderform> list = tabOrderformDao.queryByList(tabOrderform);
		page.setList(list);
		return page;
	}
	@Override
	public ResultData<Boolean> create(TabOrderform orderform) {
		LOG.info("[create]is start" + orderform);
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		//获取当天下一个编号
		int index = tabOrderformDao.getNextIndexByCurrentDay();
		String indexStr = String.valueOf(index);
		LOG.info("[create]indexStr:" + indexStr);
		int len = indexStr.length();
		if(len == 1){
			indexStr = "00" + index;
		}else if(len == 2){
			indexStr = "0" + index;
		}
		String dateStr = DateTool.getDate(new Date(),DateTool.sdfShort);
		LOG.info("[create]dateStr:" + dateStr);
		//编号
		String dataIndex = dateStr + indexStr;
		LOG.info("[create]dataIndex:" + dataIndex);
		orderform.setDataIndex(dataIndex);
		int r = tabOrderformDao.add(orderform);
		resultData.setData(r > 0);
		LOG.info("[create]is end");
		return resultData;
	}
	@Override
	public ResultData<Boolean> modify(TabOrderform orderform) {
		LOG.info("[modify]is start" + orderform);
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		TabOrderform oldOrderform = tabOrderformDao.queryById(orderform.getId());
		if(oldOrderform!=null && oldOrderform.getStatus() == 3){
			resultData.setCode(CommonMessage.ERROR);
			resultData.setMsg("订单已计算，不能修改");
			LOG.info("[modify]is fail by msg:" + resultData.getMsg());
			return resultData;
		}
		int r = tabOrderformDao.updateBySelective(orderform);
		resultData.setData(r > 0);
		LOG.info("[modify]is end");
		return resultData;
	}
	@Override
	public ResultData<Boolean> remove(int id) {
		LOG.info("[remove]is start id:" + id);
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		int r = tabOrderformDao.delete(id);
		resultData.setData(r > 0);
		LOG.info("[remove]is end");
		return resultData;
	}
	@Override
	public ResultData<Boolean> shouHuo(TabOrderform tabOrderform) {
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		TabOrderform oldOrderform = tabOrderformDao.queryById(tabOrderform.getId());
		if(oldOrderform!=null && oldOrderform.getStatus() == 3){
			resultData.setCode(CommonMessage.ERROR);
			resultData.setMsg("订单已计算，不能修改");
			LOG.info("[modify]is fail by msg:" + resultData.getMsg());
			return resultData;
		}
		int r = tabOrderformDao.shouHuo(tabOrderform.getId(),tabOrderform.getRnw(),tabOrderform.getLosston());
		resultData.setData(r > 0);
		return resultData;
	}
	@Override
	public int setOrderOverStatus(int orderId) {
		return tabOrderformDao.setOrderOverStatus(orderId);
	}
	@Override
	public List<TabOrderform> queryAll(TabOrderform tabOrderform) {
		tabOrderform.setPage(null);
		return tabOrderformDao.queryByList(tabOrderform);
	}
	@Override
	public OrderStaResult countForAllOrder(TabOrderform oldTabOrderform) {
		TabOrderform tabOrderform = null;
		if(oldTabOrderform != null){
			tabOrderform = new  TabOrderform();
			try {
				BeanUtils.copyProperties(tabOrderform,oldTabOrderform );
			} catch (Exception e) {
				LOG.error(e);
			}
			tabOrderform.setPage(null);
		}
		return tabOrderformDao.countForAllOrder(tabOrderform);
	}
}

