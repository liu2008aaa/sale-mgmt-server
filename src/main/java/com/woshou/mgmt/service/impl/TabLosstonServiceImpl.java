package com.woshou.mgmt.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.woshou.mgmt.dao.TabLosstonDao;
import com.woshou.mgmt.entity.TabLosston;
import com.woshou.mgmt.service.TabLosstonService;

@Service("tabLosstonService")
public class TabLosstonServiceImpl implements TabLosstonService {
	private final static Logger LOG = Logger.getLogger(TabLosstonServiceImpl.class);
	@Autowired
    private TabLosstonDao tabLosstonDao;
	@Override
	public TabLosston getByOrderId(int orderId) {
		return tabLosstonDao.getByOrderId(orderId);
	}
	@Override
	public TabLosston queryId(int id) {
		return tabLosstonDao.queryById(id);
	}
	@Override
	public int create(TabLosston tabLosston) {
		return tabLosstonDao.add(tabLosston);
	}
	@Override
	public int modify(TabLosston tabLosston) {
		return tabLosstonDao.update(tabLosston);
	}
}
