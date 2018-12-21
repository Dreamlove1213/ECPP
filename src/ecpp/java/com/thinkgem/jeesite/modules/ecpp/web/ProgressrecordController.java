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
import com.thinkgem.jeesite.modules.ecpp.entity.Progressrecord;
import com.thinkgem.jeesite.modules.ecpp.service.ProgressrecordService;

/**
 * 改进项进度记录Controller
 * @author zxt
 * @version 2018-03-22
 */
@Controller
@RequestMapping(value = "${adminPath}/ecpp/progressrecord")
public class ProgressrecordController extends BaseController {

	@Autowired
	private ProgressrecordService progressrecordService;
	
	@ModelAttribute
	public Progressrecord get(@RequestParam(required=false) String id) {
		Progressrecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = progressrecordService.get(id);
		}
		if (entity == null){
			entity = new Progressrecord();
		}
		return entity;
	}
	
	@RequiresPermissions("ecpp:progressrecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(Progressrecord progressrecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Progressrecord> page = progressrecordService.findPage(new Page<Progressrecord>(request, response), progressrecord); 
		model.addAttribute("page", page);
		return "modules/ecpp/progressrecordList";
	}

	@RequiresPermissions("ecpp:progressrecord:view")
	@RequestMapping(value = "form")
	public String form(Progressrecord progressrecord, Model model) {
		model.addAttribute("progressrecord", progressrecord);
		return "modules/ecpp/progressrecordForm";
	}

	@RequiresPermissions("ecpp:progressrecord:edit")
	@RequestMapping(value = "save")
	public String save(Progressrecord progressrecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, progressrecord)){
			return form(progressrecord, model);
		}
		progressrecordService.save(progressrecord);
		addMessage(redirectAttributes, "保存进度记录成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/progressrecord/?repage";
	}
	
	@RequiresPermissions("ecpp:progressrecord:edit")
	@RequestMapping(value = "delete")
	public String delete(Progressrecord progressrecord, RedirectAttributes redirectAttributes) {
		progressrecordService.delete(progressrecord);
		addMessage(redirectAttributes, "删除进度记录成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/progressrecord/?repage";
	}

}