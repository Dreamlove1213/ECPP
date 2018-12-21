/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.selfevluate.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.config.service.EcppConfigService;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.selfevluate.entity.Selfevluate;
import com.thinkgem.jeesite.modules.selfevluate.service.SelfevluateService;

import java.util.Map;

/**
 * 自评报告Controller
 * @author zxt
 * @version 2018-06-18
 */
@Controller
@RequestMapping(value = "${adminPath}/selfevluate/selfevluate")
public class SelfevluateController extends BaseController {

	@Autowired
	private SelfevluateService selfevluateService;
	@Autowired
	private EcppConfigService ecppConfigService;
	
	@ModelAttribute
	public Selfevluate get(@RequestParam(required=false) String id) {
		Selfevluate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = selfevluateService.get(id);
		}
		if (entity == null){
			entity = new Selfevluate();
		}
		return entity;
	}
	
	@RequiresPermissions("selfevluate:selfevluate:view")
	@RequestMapping(value = {"list", ""})
	public String list(Selfevluate selfevluate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Selfevluate> page = selfevluateService.findPage(new Page<Selfevluate>(request, response), selfevluate); 
		model.addAttribute("page", page);
		return "modules/selfevluate/selfevluateList";
	}

	@RequiresPermissions("selfevluate:selfevluate:view")
	@RequestMapping(value = "form")
	public String form(Selfevluate selfevluate, Model model) {
		model.addAttribute("selfevluate", selfevluate);
		return "modules/selfevluate/selfevluateForm";
	}

	//@RequiresPermissions("selfevluate:selfevluate:edit")
	@RequiresPermissions("user")
	@RequestMapping(value = "save")
	public String save(Selfevluate selfevluate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, selfevluate)){
			return form(selfevluate, model);
		}
		//判断是否满足填报要求
		Map<String,String> map = ecppConfigService.isReport(4);
		if("0".equals(map.get("isReport"))){
			addMessage(redirectAttributes, map.get("msg"));
			return "redirect:"+Global.getAdminPath()+"/ecpp/planinformation/u4List";
		}
		//手动获取当前用户所在的机构
		Office office = new Office();
		office.setId(UserUtils.getUser().getOffice().getId());
		selfevluate.setUnit(office);
		selfevluateService.save(selfevluate);
		addMessage(redirectAttributes, "保存自评报告成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/planinformation/u4List";
	}
	
	@RequiresPermissions("selfevluate:selfevluate:edit")
	@RequestMapping(value = "delete")
	public String delete(Selfevluate selfevluate, RedirectAttributes redirectAttributes) {
		selfevluateService.delete(selfevluate);
		addMessage(redirectAttributes, "删除自评报告成功");
		return "redirect:"+Global.getAdminPath()+"/selfevluate/selfevluate/?repage";
	}

}