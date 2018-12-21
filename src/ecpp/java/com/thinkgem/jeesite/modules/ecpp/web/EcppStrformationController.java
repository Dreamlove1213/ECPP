/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.ecpp.entity.EcppStrformation;
import com.thinkgem.jeesite.modules.ecpp.service.EcppStrformationService;

/**
 * 组建机构Controller
 * @author lin
 * @version 2018-03-27
 */
@Controller
@RequestMapping(value = "${adminPath}/ecpp/ecppStrformation")
public class EcppStrformationController extends BaseController {

	@Autowired
	private EcppStrformationService ecppStrformationService;
	
	@ModelAttribute
	public EcppStrformation get(@RequestParam(required=false) String id) {
		EcppStrformation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ecppStrformationService.get(id);
		}
		if (entity == null){
			entity = new EcppStrformation();
		}
		return entity;
	}
	
	@RequiresPermissions("ecpp:ecppStrformation:view")
	@RequestMapping(value = {"list", ""})
	public String list(EcppStrformation ecppStrformation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EcppStrformation> page = ecppStrformationService.findPage(new Page<EcppStrformation>(request, response), ecppStrformation); 
		model.addAttribute("page", page);
		return "modules/ecpp/ecppStrformationList";
	}

	@RequiresPermissions("ecpp:ecppStrformation:view")
	@RequestMapping(value = "form")
	public String form(EcppStrformation ecppStrformation, Model model) {
		model.addAttribute("ecppStrformation", ecppStrformation);
		return "modules/ecpp/ecppStrformationForm";
	}

	@RequiresPermissions("ecpp:ecppStrformation:edit")
	@RequestMapping(value = "save")
	public String save(EcppStrformation ecppStrformation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ecppStrformation)){
			return form(ecppStrformation, model);
		}
		ecppStrformationService.save(ecppStrformation);
		addMessage(redirectAttributes, "保存组建机构成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/ecppStrformation/?repage";
	}
	
	@RequiresPermissions("ecpp:ecppStrformation:edit")
	@RequestMapping(value = "delete")
	public String delete(EcppStrformation ecppStrformation, RedirectAttributes redirectAttributes) {
		ecppStrformationService.delete(ecppStrformation);
		addMessage(redirectAttributes, "删除组建机构成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/ecppStrformation/?repage";
	}

}