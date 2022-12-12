package com.woshou.mgmt.modules.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.woshou.common.entity.Page;
import com.woshou.common.message.ResultData;
import com.woshou.mgmt.common.config.Global;
import com.woshou.mgmt.common.utils.StringUtils;
import com.woshou.mgmt.common.web.BaseController;
import com.woshou.mgmt.dto.OrderStaResult;
import com.woshou.mgmt.entity.TabOrderform;
import com.woshou.mgmt.entity.TabShipper;
import com.woshou.mgmt.export.ExportOrderHelper;
import com.woshou.mgmt.service.TabOrderformService;
import com.woshou.mgmt.service.TabShipperService;

/**
 * 产品管理 Controller
 * 
 * @author Liuqc
 * @version 2015-03-18
 */
@Controller
@RequestMapping(value = "${adminPath}/order")
public class OrderFormController extends BaseController {
	@Autowired
	private TabOrderformService tabOrderformService;
	@Autowired
	private TabShipperService tabShipperService;
	@ModelAttribute
	public TabOrderform get(@RequestParam(required = false) String id) {
		TabOrderform entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = tabOrderformService.queryId(Integer.parseInt(id));
		}
		if (entity == null) {
			entity = new TabOrderform();
		}
		return entity;
	}	

	@RequestMapping(value = { "list", "" })
	public String list(TabOrderform tabOrderform, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
		//货运类型
		if(tabOrderform!=null){
			if(tabOrderform.getVecturatype()!=null && tabOrderform.getVecturatype() == -1){
				tabOrderform.setVecturatype(null);
			}
		}
		//1：打印当前页。2：打印全部
		String act = request.getParameter("act");
		if(act == null){
			act = "1";
		}
		List<TabOrderform> list = null;
		OrderStaResult orderStaResult = new OrderStaResult();
		Page<TabOrderform> page = new Page<TabOrderform>(request,response);
		page.setPageSize(10);
		if(act.equals("1")){//条件查询
			page = tabOrderformService.getByPage(tabOrderform, page);
			list = page.getList();
	        if(list!=null && list.size() > 0){
	        		orderStaResult = getOrderStaResult(tabOrderform);
	        }
		}else if(act.equals("2")){//查所有
			list = tabOrderformService.queryAll(tabOrderform);
			page.setList(list);
			if(list!=null && list.size() > 0){
				orderStaResult = getOrderStaResult(tabOrderform);
			}
		}
		//导出
		String export = request.getParameter("export");
		if(export!=null && "1".equals(export)){
			try {
				ExportOrderHelper.export(page.getList(), orderStaResult, response);
				return null;
			} catch (IOException e) {
				addMessage(redirectAttributes, "导出失败！失败信息：" + e.getMessage());
			}
		}
		//数据
		model.addAttribute("page", page);
		model.addAttribute("tabOrderform", tabOrderform);
		model.addAttribute("orderStaResult", orderStaResult);
		model.addAttribute("action", request.getParameter("action"));
		String print = request.getParameter("print");
		if(print!=null && "1".equals(print)){
			return "modules/order/orderListPrint";
		}
		return "modules/order/orderList";
	}
	//汇总
	private OrderStaResult getOrderStaResult(TabOrderform tabOrderform){
		return tabOrderformService.countForAllOrder(tabOrderform);
//		OrderStaResult orderStaResult = new OrderStaResult();
//		orderStaResult.setCount(list.size());
//		
//		for(TabOrderform tabOrderform : list){
//			String lastSnw = orderStaResult.getTotalSnw();
//			String currentSnw = tabOrderform.getSnw();
//			BigDecimal lastSnwValue = BigDecimal.ZERO;
//			if(currentSnw!=null){
//				if(lastSnw != null){
//					lastSnwValue = new BigDecimal(lastSnw);
//				}
//				lastSnwValue = lastSnwValue.add(new BigDecimal(currentSnw));
//			}
//			orderStaResult.setTotalSnw(lastSnwValue.toString());
//		}
//		return orderStaResult;
	}

	@RequestMapping(value = "view")
	public String view(int id,HttpServletRequest request, HttpServletResponse response, Model model) {
		TabOrderform tabOrderform = tabOrderformService.queryId(id);
		request.setAttribute("tabOrderform",tabOrderform);
		request.setAttribute("action",request.getParameter("action"));
		return "modules/order/orderView";
	}	
	
	@RequestMapping(value = "report")
	public String report(int id,HttpServletRequest request, HttpServletResponse response, Model model) {
		TabOrderform tabOrderform = tabOrderformService.queryId(id);
		request.setAttribute("tabOrderform",tabOrderform);
		return "modules/order/orderViewReport";
	}	
	@RequestMapping(value = "form")
	public String form(TabOrderform tabOrderform,Model model, HttpServletRequest request) {
		model.addAttribute("action", request.getParameter("action"));
		return "modules/order/orderForm";
	}

	@RequestMapping(value = "save")
	public String save(TabOrderform tabOrderform, Model model, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		ResultData<Boolean> resultData = null;
		TabShipper tabShipper = tabShipperService.queryById(tabOrderform.getShipperid());
		tabOrderform.setShippername(tabShipper.getName());
		if(tabOrderform.getId()!=null && tabOrderform.getId() > 0){
			resultData = tabOrderformService.modify(tabOrderform);
		}else{
			tabOrderform.setStatus(1);//已发货
			resultData = tabOrderformService.create(tabOrderform);
		}
		addMessage(redirectAttributes, resultData.getMsg());
		return "redirect:" + Global.getAdminPath() + "/order/list";
	}
	/**
	 * 收货
	 * 
	 * @param tabOrderform
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "shouHuo")
	public String shouHuo(TabOrderform tabOrderform, Model model, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		ResultData<Boolean> resultData = tabOrderformService.shouHuo(tabOrderform);
		addMessage(redirectAttributes, resultData.getMsg());
		return "redirect:" + Global.getAdminPath() + "/order/list?action=" + request.getParameter("action");
	}
	
	@RequestMapping(value = "doRemove")
	@ResponseBody
	public ResultData<Boolean> doRemove(int id, Model model, HttpServletRequest request,RedirectAttributes redirectAttributes) {
		ResultData<Boolean> resultData = tabOrderformService.remove(id);
		return resultData;
	}
}