package com.woshou.mgmt.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.woshou.common.entity.Page;
import com.woshou.common.message.CommonMessage;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.dao.TabShipperDao;
import com.woshou.mgmt.entity.TabShipper;
import com.woshou.mgmt.service.TabShipperService;

@Service("tabShipperService")
public class TabShipperServiceImpl implements TabShipperService {
	private final static Logger LOG = Logger.getLogger(TabShipperServiceImpl.class);
	@Autowired
    private TabShipperDao tabShipperDao;
	
	public List<TabShipper> getAllTabShippers(){
		return tabShipperDao.queryByList(null);
	}

	@Override
	public TabShipper queryById(int id) {
		return tabShipperDao.queryById(id);
	}

	@Override
	public Page<TabShipper> getByPage(TabShipper tabShipper,Page<TabShipper> page) {
		page.setOrderBy("id desc");
		tabShipper.setPage(page);
		List<TabShipper> list = tabShipperDao.queryByList(tabShipper);
		page.setList(list);
		return page;
	}

	@Override
	public ResultData<Boolean> create(TabShipper tabShipper) {
		LOG.info("[create]is start" + tabShipper);
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		TabShipper oldTabShipper = tabShipperDao.queryByName(tabShipper.getName());
		if(oldTabShipper!=null){
			resultData.setCode(CommonMessage.ERROR);
			resultData.setMsg("发货单位名称已经存在");
			LOG.info("[create]is fail by msg:" + resultData.getMsg());
			return resultData;
		}
		int r = tabShipperDao.add(tabShipper);
		resultData.setData(r > 0);
		LOG.info("[create]is end");
		return resultData;
	}
	@Override
	public ResultData<Boolean> modify(TabShipper tabShipper) {
		LOG.info("[modify]is start" + tabShipper);
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		TabShipper oldTabShipper = tabShipperDao.queryByName(tabShipper.getName());
		if(oldTabShipper!=null && !oldTabShipper.getId().equals(tabShipper.getId())){
			resultData.setCode(CommonMessage.ERROR);
			resultData.setMsg("发货单位名称已经存在");
			LOG.info("[modify]is fail by msg:" + resultData.getMsg());
			return resultData;
		}
		int r = tabShipperDao.update(tabShipper);
		resultData.setData(r > 0);
		LOG.info("[modify]is end");
		return resultData;
	}

	@Override
	public ResultData<Boolean> remove(int id) {
		LOG.info("[remove]is start id:" + id);
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		int r = tabShipperDao.delete(id);
		resultData.setData(r > 0);
		LOG.info("[remove]is end");
		return resultData;
	}

	@Override
	public int setShipperMoney(int shipperId, String money) {
		return tabShipperDao.setShipperMoney(shipperId, money);
	}
}
