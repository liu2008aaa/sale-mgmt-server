package com.woshou.mgmt.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.woshou.common.entity.Page;
import com.woshou.common.exception.PlatformException;
import com.woshou.common.message.CommonMessage;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.dao.TabAccountsDao;
import com.woshou.mgmt.dto.CostStaResult;
import com.woshou.mgmt.entity.TabAccounts;
import com.woshou.mgmt.entity.TabLosston;
import com.woshou.mgmt.entity.TabOrderform;
import com.woshou.mgmt.service.TabAccountsService;
import com.woshou.mgmt.service.TabLosstonService;
import com.woshou.mgmt.service.TabOrderformService;
import com.woshou.mgmt.service.TabShipperService;

@Service("tabAccountsService")
public class TabAccountsServiceImpl implements TabAccountsService {
	private final static Logger LOG = Logger.getLogger(TabAccountsServiceImpl.class);
	@Autowired
    private TabAccountsDao tabAccountsDao;
	@Autowired
	private TabOrderformService tabOrderformService;
	@Autowired
	private TabShipperService tabShipperService;
	@Autowired
	private TabLosstonService tabLosstonService;
	@Override
	public TabAccounts queryId(int id) {
		return tabAccountsDao.queryById(id);
	}
	@Override
	public TabAccounts getByOrderId(int orderId) {
		return tabAccountsDao.getByOrderId(orderId);
	}
	@Override
	public int modify(TabAccounts tabAccounts) {
		return tabAccountsDao.update(tabAccounts);
	}
	@Override
	public int create(TabAccounts tabAccounts) {
		return tabAccountsDao.add(tabAccounts);
	}
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	@Override
	public ResultData<Boolean> toBalanceAccountsForSend(TabAccounts tabAccounts,String type)throws PlatformException {
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		boolean isModify = false;
		int oldId = 0;
		if(tabAccounts.getId()!=null && tabAccounts.getId() > 0){
			oldId = tabAccounts.getId();
			isModify = true;
		}
		TabOrderform tabOrderform = tabOrderformService.queryId(tabAccounts.getOrderid());
		if(tabOrderform == null){
			resultData.setCode(CommonMessage.ERROR);
			resultData.setMsg("原发货单已不存在");
			return resultData;
		}
		//
		if(tabOrderform.getStatus() == 1 || tabOrderform.getStatus() == 0){
			resultData.setCode(CommonMessage.ERROR);
			resultData.setMsg("订单还未收货，不能结算");
			return resultData;
		}
		//取亏吨数据
		TabLosston tabLosston = tabLosstonService.getByOrderId(tabOrderform.getId());
		if(tabLosston == null){
			resultData.setCode(CommonMessage.ERROR);
			resultData.setMsg("此订单亏吨还未计算");
			return resultData;
		}
		//封装结算信息
		tabAccounts = makeTabAccounts(tabAccounts,tabOrderform,tabLosston);
		//已结算
		tabAccounts.setStatus(2);
		int r = 0;
		if(isModify){
			tabAccounts.setId(oldId);
			r = this.modify(tabAccounts);
		}else{
			tabAccounts.setId(null);
			r = this.create(tabAccounts);
		}
		if(r == 0){
			LOG.info("save tabAccounts is fail");
		}
		//更新订单状态为已结算
		r = tabOrderformService.setOrderOverStatus(tabOrderform.getId());
		if(r == 0){
			LOG.info("setOrderOverStatus is fail orderId:" + tabOrderform.getId());
			throw new PlatformException(CommonMessage.ERROR);
		}
		//与发货单位结算时，更新账户余额
		if(type != null && "1".equals(type)){
			//更新帐户余额
			r = tabShipperService.setShipperMoney(tabOrderform.getShipperid(), tabAccounts.getMoney());
			if(r == 0){
				LOG.info("setShipperMoney is fail Shipperid:" + tabOrderform.getShipperid() + ",money:" + tabAccounts.getMoney());
				throw new PlatformException(CommonMessage.ERROR);
			}
		}
		resultData.setData(r == 1);
		return resultData;
	}

	private TabAccounts makeTabAccounts(TabAccounts tabAccounts,TabOrderform tabOrderform,TabLosston tabLosston){
		try{
			org.apache.commons.beanutils.BeanUtils.copyProperties(tabAccounts, tabOrderform);
			if(tabLosston!=null){
				org.apache.commons.beanutils.BeanUtils.copyProperties(tabAccounts,  tabLosston);
				//煤型单价
				tabAccounts.setCoaltypeprice(tabLosston.getPrice());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return tabAccounts;
	}
	@Override
	public Page<TabAccounts> getByPage(TabAccounts tabAccounts,Page<TabAccounts> page) {
		tabAccounts.setPage(page);
		List<TabAccounts> list = tabAccountsDao.queryByList(tabAccounts);
		page.setList(list);
		return page;
	}
	@Override
	public List<TabAccounts> queryAll(TabAccounts tabAccounts) {
		tabAccounts.setPage(null);
		return tabAccountsDao.queryByList(tabAccounts);
	}
	@Override
	public CostStaResult countForAll(TabAccounts oldTabAccounts) {
		TabAccounts tabAccounts = null;
		if(oldTabAccounts!=null){
			tabAccounts = new TabAccounts();
			try {
				BeanUtils.copyProperties(tabAccounts, oldTabAccounts);
			} catch (Exception e) {
			}
			tabAccounts.setPage(null);
		}
		return tabAccountsDao.countForAll(tabAccounts);
	}
}
