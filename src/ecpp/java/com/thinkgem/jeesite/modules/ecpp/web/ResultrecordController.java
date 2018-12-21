/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.ecpp.entity.Progressrecord;
import com.thinkgem.jeesite.modules.ecpp.entity.Resultrecord;
import com.thinkgem.jeesite.modules.ecpp.service.ProgressrecordService;
import com.thinkgem.jeesite.modules.ecpp.service.ResultrecordService;

/**
 * 提升情况信息及小组建议Controller
 * @author zxt
 * @version 2018-03-22
 */
@Controller
@RequestMapping(value = "${adminPath}/ecpp/resultrecord")
public class ResultrecordController extends BaseController {

	@Autowired
	private ResultrecordService resultrecordService;
	@Autowired
	private ProgressrecordService progressrecordService;
	
	@ModelAttribute
	public Resultrecord get(@RequestParam(required=false) String id) {
		Resultrecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = resultrecordService.get(id);
		}
		if (entity == null){
			entity = new Resultrecord();
		}
		return entity;
	}
	
	@RequiresPermissions("ecpp:resultrecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(Resultrecord resultrecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Resultrecord> page = resultrecordService.findPage(new Page<Resultrecord>(request, response), resultrecord); 
		model.addAttribute("page", page);
		return "modules/ecpp/resultrecordList";
	}

    /**
     * 改革小组建议  ajax
     * @param resultrecord
     * @param request
     * @param response
     * @param model
     * @return
     */
	@RequiresPermissions("user")
	@RequestMapping(value = "getAdvice")
	public String getAdvice(Resultrecord resultrecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		resultrecord.setUnit(user.getOffice());
        resultrecord.setStatus("2");
		List<Resultrecord> resultrecordslist = resultrecordService.findListGroupPlanId(resultrecord);
		return renderString(response,resultrecordslist);
	}

	@RequiresPermissions("ecpp:resultrecord:view")
	@RequestMapping(value = "form")
	public String form(Resultrecord resultrecord, Model model) {
		String changeId = resultrecord.getAttribute4();
		Progressrecord progressrecord = new Progressrecord();
		List<Progressrecord> proPressLists = Lists.newArrayList();
		if (!changeId.equals(null) && !changeId.equals("")) {
			progressrecord.setAttribute4(changeId);
			proPressLists = this.progressrecordService.findList(progressrecord);
		}
		
		model.addAttribute("proPressLists", proPressLists);
		model.addAttribute("resultrecord", resultrecord);
		return "modules/ecpp/resultrecordForm";
	}

	@RequiresPermissions("ecpp:resultrecord:edit")
	@RequestMapping(value = "save")
	public String save(Resultrecord resultrecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, resultrecord)){
			return form(resultrecord, model);
		}
		resultrecordService.save(resultrecord);
		addMessage(redirectAttributes, "保存提升情况信息及小组建议成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/resultrecord/?repage";
	}
	
	@RequiresPermissions("ecpp:resultrecord:edit")
	@RequestMapping(value = "delete")
	public String delete(Resultrecord resultrecord, RedirectAttributes redirectAttributes) {
		resultrecordService.delete(resultrecord);
		addMessage(redirectAttributes, "删除提升情况信息及小组建议成功");
		return "redirect:"+Global.getAdminPath()+"/ecpp/resultrecord/?repage";
	}

}