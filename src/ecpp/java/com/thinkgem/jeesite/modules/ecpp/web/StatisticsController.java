/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.ecpp.entity.Statistics;
import com.thinkgem.jeesite.modules.ecpp.service.StatisticsService;

/**
 * 统计Controller
 * @author zxy
 * @version 2018-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/ecpp/statistics")
public class StatisticsController extends BaseController {

	@Autowired
	private StatisticsService statisticsService;
	
	@ModelAttribute
	public Statistics get(@RequestParam(required=false) String id) {
		Statistics entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsService.get(id);
		}
		if (entity == null){
			entity = new Statistics();
		}
		return entity;
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(Statistics statistics, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Statistics> page = statisticsService.findPage(new Page<Statistics>(request, response), statistics); 
		model.addAttribute("page", page);
		return "modules/ecpp/statisticsList";
	}

	@RequestMapping(value = "form")
	public String form(Statistics statistics, Model model) {
		model.addAttribute("statistics", statistics);
		return "modules/ecpp/statisticsForm";
	}

	@RequestMapping(value = "save")
	public String save(Statistics statistics, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statistics)){
			return form(statistics, model);
		}
		statisticsService.save(statistics);
		addMessage(redirectAttributes, "保存统计成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/statistics/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(Statistics statistics, RedirectAttributes redirectAttributes) {
		statisticsService.delete(statistics);
		addMessage(redirectAttributes, "删除统计成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/statistics/?repage";
	}

}