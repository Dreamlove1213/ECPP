/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecppwork.web;

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
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogramme;
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogrammeCopy;
import com.thinkgem.jeesite.modules.ecppwork.service.EcppWorkprogrammeCopyService;
import com.thinkgem.jeesite.modules.ecppwork.service.EcppWorkprogrammeService;

/**
 * 查看工作计划Controller
 * @author nan
 * @version 2018-03-31
 */
@Controller
@RequestMapping(value = "${adminPath}/ecppwork/ecppWorkprogrammeCopy")
public class EcppWorkprogrammeCopyController extends BaseController {

	@Autowired
	private EcppWorkprogrammeCopyService ecppWorkprogrammeCopyService;
	@Autowired
	private EcppWorkprogrammeService ecppWorkprogrammeService;
	
	@ModelAttribute
	public EcppWorkprogrammeCopy get(@RequestParam(required=false) String id) {
		EcppWorkprogrammeCopy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ecppWorkprogrammeCopyService.get(id);
		}
		if (entity == null){
			entity = new EcppWorkprogrammeCopy();
		}
		return entity;
	}
	
	@RequiresPermissions("ecppwork:ecppWorkprogrammeCopy:view")
	@RequestMapping(value = {"list", ""})
	public String list(EcppWorkprogrammeCopy ecppWorkprogrammeCopy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EcppWorkprogrammeCopy> page = ecppWorkprogrammeCopyService.findPage(new Page<EcppWorkprogrammeCopy>(request, response), ecppWorkprogrammeCopy); 
		model.addAttribute("page", page);
		return "modules/ecppwork/ecppWorkprogrammeCopyList";
	}

	@RequiresPermissions("ecppwork:ecppWorkprogrammeCopy:view")
	@RequestMapping(value = "form")
	public String form(EcppWorkprogrammeCopy ecppWorkprogrammeCopy, Model model) {
		ecppWorkprogrammeCopy.setStatus("1");
		ecppWorkprogrammeCopyService.save(ecppWorkprogrammeCopy);
		model.addAttribute("ecppWorkprogrammeCopy", ecppWorkprogrammeCopy);
		return "modules/ecppwork/ecppWorkprogrammeCopyForm";
	}

	@RequiresPermissions("ecppwork:ecppWorkprogrammeCopy:edit")
	@RequestMapping(value = "save")
	public String save(EcppWorkprogrammeCopy ecppWorkprogrammeCopy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ecppWorkprogrammeCopy)){
			return form(ecppWorkprogrammeCopy, model);
		}
		ecppWorkprogrammeCopyService.save(ecppWorkprogrammeCopy);
		addMessage(redirectAttributes, "保存工作计划成功");
		return "redirect:"+Global.getAdminPath()+"/ecppwork/ecppWorkprogrammeCopy/?repage";
	}
	
	@RequiresPermissions("ecppwork:ecppWorkprogrammeCopy:edit")
	@RequestMapping(value = "delete")
	public String delete(EcppWorkprogrammeCopy ecppWorkprogrammeCopy, RedirectAttributes redirectAttributes) {
		ecppWorkprogrammeCopyService.delete(ecppWorkprogrammeCopy);
		EcppWorkprogramme ecppWorkprogramme = new EcppWorkprogramme();
		ecppWorkprogramme.setUnit(ecppWorkprogrammeCopy.getUnit());
		this.ecppWorkprogrammeService.delete(ecppWorkprogramme);
		addMessage(redirectAttributes, "删除工作计划成功");
		return "redirect:"+Global.getAdminPath()+"/ecppwork/ecppWorkprogrammeCopy/?repage";
	}

}