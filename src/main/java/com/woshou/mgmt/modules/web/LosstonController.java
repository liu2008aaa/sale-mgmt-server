package com.woshou.mgmt.modules.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.woshou.common.message.ResultData;
import com.woshou.mgmt.common.config.Global;
import com.woshou.mgmt.common.utils.StringUtils;
import com.woshou.mgmt.common.web.BaseController;
import com.woshou.mgmt.entity.TabLosston;
import com.woshou.mgmt.entity.TabOrderform;
import com.woshou.mgmt.service.TabLosstonService;
import com.woshou.mgmt.service.TabOrderformService;

/**
 * 亏吨
 * 
 * @author Liuqc
 * @version 2015-03-18
 */
@Controller
@RequestMapping(value = "${adminPath}/losston")
public class LosstonController extends BaseController {
	@Autowired
	private TabOrderformService tabOrderformService;
	@Autowired
	private TabLosstonService tabLosstonService;
	@ModelAttribute
	public TabLosston get(@RequestParam(required = false) String id,@RequestParam(required = false) String orderId) {
		TabLosston entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = tabLosstonService.queryId(Integer.parseInt(id));
		}
		if (entity == null && StringUtils.isNotBlank(orderId)) {
			entity = tabLosstonService.getByOrderId(Integer.parseInt(orderId));
		}
		if (entity == null) {
			entity = new TabLosston();
		}
		return entity;
	}	

	@RequestMapping(value = "form")
	public String view(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("orderId");
		int orederId = Integer.parseInt(id);
		TabOrderform tabOrderform = tabOrderformService.queryId(orederId);
		request.setAttribute("tabOrderform",tabOrderform);
		//查亏吨
		TabLosston tabLosston = tabLosstonService.getByOrderId(orederId);
		request.setAttribute("tabLosston",tabLosston);
		return "modules/losston/form";
	}	

	@RequestMapping(value = "save")
	public String save(TabLosston tabLosston, Model model, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		TabOrderform tabOrderform = tabOrderformService.queryId(tabLosston.getOrderid());
		if(tabOrderform == null){
			addMessage(redirectAttributes, "原发货单已不存在");
			return "redirect:" + Global.getAdminPath() + "/order/list?action=losston";
		}
		if(tabOrderform.getStatus() == 3){
			addMessage(redirectAttributes, "订单已计算，不能修改");
			return "redirect:" + Global.getAdminPath() + "/order/list?action=losston";
		}
		ResultData<Boolean> resultData = new ResultData<Boolean>();
		int r = 0;
		if(tabLosston.getId()!=null && tabLosston.getId() > 0){
			r = tabLosstonService.modify(tabLosston);
		}else{
			r = tabLosstonService.create(tabLosston);
		}
		resultData.setData(r == 1);
		addMessage(redirectAttributes, resultData.getMsg());
		return "redirect:" + Global.getAdminPath() + "/order/list?action=losston";
	}
}