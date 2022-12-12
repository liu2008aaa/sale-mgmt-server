package com.woshou.mgmt.modules.web;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.woshou.common.entity.Page;
import com.woshou.common.exception.PlatformException;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.common.config.Global;
import com.woshou.mgmt.common.utils.StringUtils;
import com.woshou.mgmt.common.web.BaseController;
import com.woshou.mgmt.dto.CostStaResult;
import com.woshou.mgmt.entity.TabAccounts;
import com.woshou.mgmt.entity.TabLosston;
import com.woshou.mgmt.entity.TabOrderform;
import com.woshou.mgmt.entity.TabShipper;
import com.woshou.mgmt.export.ExportAccountsHelper;
import com.woshou.mgmt.service.TabAccountsService;
import com.woshou.mgmt.service.TabLosstonService;
import com.woshou.mgmt.service.TabOrderformService;
import com.woshou.mgmt.service.TabShipperService;

/**
 * 结算
 * 
 * @author Liuqc
 * @version 2015-03-18
 */
@Controller
@RequestMapping(value = "${adminPath}/account")
public class AccountController extends BaseController {
	@Autowired
	private TabOrderformService tabOrderformService;
	@Autowired
	private TabAccountsService tabAccountsService;
	@Autowired
	private TabShipperService tabShipperService;
	@Autowired
	private TabLosstonService tabLosstonService;
	@ModelAttribute
	public TabAccounts get(@RequestParam(required = false) String id,@RequestParam(required = false) String orderId) {
		TabAccounts entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = tabAccountsService.queryId(Integer.parseInt(id));
		}
		if (entity== null && StringUtils.isNotBlank(orderId)) {
			entity = tabAccountsService.getByOrderId(Integer.parseInt(orderId));
		}
		if (entity == null) {
			entity = new TabAccounts();
		}
		return entity;
	}	

	@RequestMapping(value = "form")
	public String view(int orderId,HttpServletRequest request, HttpServletResponse response, Model model) {
		TabOrderform tabOrderform = tabOrderformService.queryId(orderId);
		request.setAttribute("tabOrderform",tabOrderform);
		TabShipper tabShipper = tabShipperService.queryById(tabOrderform.getShipperid());
		request.setAttribute("tabShipper",tabShipper);
		//查记录
		TabAccounts tabAccounts = tabAccountsService.getByOrderId(orderId);
		request.setAttribute("tabAccounts",tabAccounts);
		String type = request.getParameter("type");
		//查亏吨
		if(type!=null && "2".equals(type)){
			TabLosston tabLosston = tabLosstonService.getByOrderId(orderId);
			request.setAttribute("tabLosston",tabLosston);
		}
		return "modules/account/form" + type;
	}	

	@RequestMapping(value = "save")
	public String save(TabAccounts tabAccounts, Model model, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		ResultData<Boolean> resultData = null;
		String msg = null;
		try {
			resultData = tabAccountsService.toBalanceAccountsForSend(tabAccounts,request.getParameter("type"));
			msg = resultData.getMsg();
		} catch (PlatformException e) {
			msg = e.getMessage();
		}
		addMessage(redirectAttributes, msg);
		return "redirect:" + Global.getAdminPath() + "/order/list?action=account";
	}
	@RequestMapping(value = { "list", "" })
	public String list(TabAccounts tabAccounts, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IllegalAccessException, InvocationTargetException {
		//货运类型
		if(tabAccounts!=null){
			if(tabAccounts.getVecturatype()!=null && tabAccounts.getVecturatype() == -1){
				tabAccounts.setVecturatype(null);
			}
		}
		String type = request.getParameter("type");//1:发货单位，2：司机
		String action = request.getParameter("action");//2：打印
		//1：打印当前页。2：打印全部
		String act = request.getParameter("act");
		if(act == null){
			act = "1";
		}
		Page<TabAccounts> page = new Page<TabAccounts>(request,response);
		page.setPageSize(10);
		List<TabAccounts> list = null;
		CostStaResult costStaResult = new CostStaResult();
		if(act.equals("1")){//条件查询
			page = tabAccountsService.getByPage(tabAccounts, page);
			list = page.getList();
			if(list!=null && list.size() > 0){
				costStaResult =	getCostStaResult(list,tabAccounts);
			}
		}else if(act.equals("2")){//查所有
			list = tabAccountsService.queryAll(tabAccounts);
			page.setList(list);
			if(list!=null && list.size() > 0){
				costStaResult =	getCostStaResult(list,tabAccounts);
			}
		}
		//导出
		String export = request.getParameter("export");
		if(export!=null && "1".equals(export)){
			try {
				if("1".equals(type)){
					ExportAccountsHelper.export1(page.getList(), costStaResult, response);
				}else if("2".equals(type)){
					ExportAccountsHelper.export2(page.getList(), costStaResult, response);
				}
				return null;
			} catch (IOException e) {
				addMessage(redirectAttributes, "导出失败！失败信息：" + e.getMessage());
			}
		}
		//数据
		model.addAttribute("page", page);
		model.addAttribute("tabAccounts", tabAccounts);
		model.addAttribute("costStaResult", costStaResult);
		if(action!=null && "2".equals(action)){
			return "modules/account/print" + type;
		}
		return "modules/account/list" + type;
	}
	private CostStaResult getCostStaResult(List<TabAccounts> list,TabAccounts tabAccounts){
		return tabAccountsService.countForAll(tabAccounts);
//		CostStaResult costStaResult = new CostStaResult();
//		costStaResult.setCount(list.size());
//		for(TabAccounts tabAccounts : list){
//			String snw = tabAccounts.getSnw();//总发货净重
//			costStaResult.setTotalSnw((string2BigDecimal(costStaResult.getTotalSnw()).add(string2BigDecimal(snw))).toString());
//			String rnw = tabAccounts.getRnw();//总收货净重
//			costStaResult.setTotalRnw((string2BigDecimal(costStaResult.getTotalRnw()).add(string2BigDecimal(rnw))).toString());
//			String shippercost = tabAccounts.getShippercost();//发货单位总运费
//			costStaResult.setTotalShipperCost((costStaResult.getTotalShipperCost().add(string2BigDecimal(shippercost))));
//			String chauffeurCost = tabAccounts.getChauffeurcost();//司机总运费
//			costStaResult.setTotalChauffeurCost((costStaResult.getTotalChauffeurCost().add(string2BigDecimal(chauffeurCost))));
//			String losston = tabAccounts.getLosston();//总亏吨
//			costStaResult.setTotalLosston((string2BigDecimal(costStaResult.getTotalLosston()).add(string2BigDecimal(losston))).toString());
//			String beyonds = tabAccounts.getBeyonds();//总超亏吨数
//			costStaResult.setTotalBeyonds((string2BigDecimal(costStaResult.getTotalBeyonds()).add(string2BigDecimal(beyonds))).toString());
//		}
//		return costStaResult;
	}
	
	private BigDecimal string2BigDecimal(String value){
		if(value == null){
			return BigDecimal.ZERO;
		}
		return new BigDecimal(value);
	}
}