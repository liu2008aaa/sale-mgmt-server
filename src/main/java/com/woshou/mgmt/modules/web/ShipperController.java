package com.woshou.mgmt.modules.web;

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
import com.woshou.mgmt.common.utils.SpringContextHolder;
import com.woshou.mgmt.common.utils.StringUtils;
import com.woshou.mgmt.common.web.BaseController;
import com.woshou.mgmt.entity.TabOrderform;
import com.woshou.mgmt.entity.TabShipper;
import com.woshou.mgmt.service.TabShipperService;

/**
 * 产品管理 Controller
 * 
 * @author Liuqc
 * @version 2015-03-18
 */
@Controller
@RequestMapping(value = "${adminPath}/shipper")
public class ShipperController extends BaseController {
	@Autowired
	private TabShipperService tabShipperService;
	@ModelAttribute
	public TabShipper get(@RequestParam(required = false) String id) {
		TabShipper entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = tabShipperService.queryById(Integer.parseInt(id));
		}
		if (entity == null) {
			entity = new TabShipper();
		}
		return entity;
	}	

	@RequestMapping(value = { "list", "" })
	public String list(TabShipper tabShipper, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TabShipper> page = tabShipperService.getByPage(tabShipper, new Page<TabShipper>(request,response));
        //数据
		model.addAttribute("page", page);
		return "modules/shipper/list";
	}
	

	@RequestMapping(value = "view")
	public String view(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/order/orderView";
	}	
	
	@RequestMapping(value = "form")
	public String form(TabOrderform tabOrderform,Model model, HttpServletRequest request) {
		return "modules/shipper/form";
	}
	
	
	@RequestMapping(value = "save")
	public String save(TabShipper tabShipper, Model model, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		ResultData<Boolean> resultData = null;
		if(tabShipper.getId()!=null && tabShipper.getId() > 0){
			resultData = tabShipperService.modify(tabShipper);
		}else{
			resultData = tabShipperService.create(tabShipper);
		}
		addMessage(redirectAttributes, resultData.getMsg());
		return "redirect:" + Global.getAdminPath() + "/shipper/list";
	}
	
	@RequestMapping(value = "doRemove")
	@ResponseBody
	public ResultData<Boolean> doRemove(int id, Model model, HttpServletRequest request,RedirectAttributes redirectAttributes) {
		ResultData<Boolean> resultData = tabShipperService.remove(id);
		return resultData;
	}
	
	public static List<TabShipper> getAllTabShippers(){
		TabShipperService tabShipperService = SpringContextHolder.getBean(TabShipperService.class);
		return tabShipperService.getAllTabShippers();
	}
}