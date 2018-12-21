/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zzjg.web;

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
import com.thinkgem.jeesite.modules.zzjg.entity.EcppStrformationCopyCopy;
import com.thinkgem.jeesite.modules.zzjg.service.EcppStrformationCopyCopyService;

/**
 * 组织机构Controller
 * @author nan
 * @version 2018-03-31
 */
@Controller
@RequestMapping(value = "${adminPath}/zzjg/ecppStrformationCopyCopy")
public class EcppStrformationCopyCopyController extends BaseController {

	@Autowired
	private EcppStrformationCopyCopyService ecppStrformationCopyCopyService;
	
	@ModelAttribute
	public EcppStrformationCopyCopy get(@RequestParam(required=false) String id) {
		EcppStrformationCopyCopy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ecppStrformationCopyCopyService.get(id);
		}
		if (entity == null){
			entity = new EcppStrformationCopyCopy();
		}
		return entity;
	}
	
	@RequiresPermissions("zzjg:ecppStrformationCopyCopy:view")
	@RequestMapping(value = {"list", ""})
	public String list(EcppStrformationCopyCopy ecppStrformationCopyCopy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EcppStrformationCopyCopy> page = ecppStrformationCopyCopyService.findPage(new Page<EcppStrformationCopyCopy>(request, response), ecppStrformationCopyCopy); 
		model.addAttribute("page", page);
		return "modules/zzjg/ecppStrformationCopyCopyList";
	}

	@RequiresPermissions("zzjg:ecppStrformationCopyCopy:view")
	@RequestMapping(value = "form")
	public String form(EcppStrformationCopyCopy ecppStrformationCopyCopy, Model model) {
		ecppStrformationCopyCopy.setStatus("1");
		ecppStrformationCopyCopyService.save(ecppStrformationCopyCopy);
		model.addAttribute("ecppStrformationCopyCopy", ecppStrformationCopyCopy);
		return "modules/zzjg/ecppStrformationCopyCopyForm";
	}

	@RequiresPermissions("zzjg:ecppStrformationCopyCopy:edit")
	@RequestMapping(value = "save")
	public String save(EcppStrformationCopyCopy ecppStrformationCopyCopy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ecppStrformationCopyCopy)){
			return form(ecppStrformationCopyCopy, model);
		}
		ecppStrformationCopyCopyService.save(ecppStrformationCopyCopy);
		addMessage(redirectAttributes, "保存组织机构成功");
		return "redirect:"+Global.getAdminPath()+"/zzjg/ecppStrformationCopyCopy/?repage";
	}
	
	@RequiresPermissions("zzjg:ecppStrformationCopyCopy:edit")
	@RequestMapping(value = "delete")
	public String delete(EcppStrformationCopyCopy ecppStrformationCopyCopy, RedirectAttributes redirectAttributes) {
		ecppStrformationCopyCopyService.delete(ecppStrformationCopyCopy);
		addMessage(redirectAttributes, "删除组织机构成功");
		return "redirect:"+Global.getAdminPath()+"/zzjg/ecppStrformationCopyCopy/?repage";
	}

}