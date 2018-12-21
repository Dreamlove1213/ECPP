/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zzjg.web;

import java.util.List;

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
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.zzjg.entity.EcppStrformationCopy;
import com.thinkgem.jeesite.modules.zzjg.service.EcppStrformationCopyService;

/**
 * 组织机构Controller
 * @author nan
 * @version 2018-03-29
 */
@Controller
@RequestMapping(value = "${adminPath}/zzjg/ecppStrformationCopy")
public class EcppStrformationCopyController extends BaseController {

	@Autowired
	private EcppStrformationCopyService ecppStrformationCopyService;
	
	@ModelAttribute
	public EcppStrformationCopy get(@RequestParam(required=false) String id) {
		EcppStrformationCopy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ecppStrformationCopyService.get(id);
		}
		if (entity == null){
			entity = new EcppStrformationCopy();
		}
		return entity;
	}
	
	@RequiresPermissions("zzjg:ecppStrformationCopy:view")
	@RequestMapping(value = {"list", ""})
	public String list(EcppStrformationCopy ecppStrformationCopy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EcppStrformationCopy> page = ecppStrformationCopyService.findPage(new Page<EcppStrformationCopy>(request, response), ecppStrformationCopy); 
		model.addAttribute("page", page);
		return "modules/zzjg/ecppStrformationCopyList";
	}

	@RequiresPermissions("zzjg:ecppStrformationCopy:view")
	@RequestMapping(value = "form")
	public String form(EcppStrformationCopy ecppStrformationCopy, Model model) {
		model.addAttribute("ecppStrformationCopy", ecppStrformationCopy);
		return "modules/zzjg/ecppStrformationCopyForm";
	}
	
	@RequiresPermissions("zzjg:ecppStrformationCopy:view")
	@RequestMapping(value = "forms")
	public String forms(EcppStrformationCopy ecppStrformationCopy, Model model) {
		ecppStrformationCopy.setUnit(UserUtils.getUser().getOffice());
		List<EcppStrformationCopy> ecppStrformationCopylist = ecppStrformationCopyService.findList(ecppStrformationCopy);
		if(ecppStrformationCopylist!=null){
			if(ecppStrformationCopylist.size()>0){
				//System.out.println("-----"+ecppStrformationCopylist.size());
				EcppStrformationCopy ecppStrformationCopys=ecppStrformationCopylist.get(0);
				model.addAttribute("ecppStrformationCopy", ecppStrformationCopys);
				return "modules/zzjg/ecppStrformationCopyFormck";
			}else{
				model.addAttribute("ecppStrformationCopy", ecppStrformationCopy);
				return "modules/zzjg/ecppStrformationCopyForm";
			}
		}else{
			model.addAttribute("ecppStrformationCopy", ecppStrformationCopy);
			return "modules/zzjg/ecppStrformationCopyForm";
		}
		
	}
	@RequiresPermissions("zzjg:ecppStrformationCopy:view")
	@RequestMapping(value = "formck")
	public String formck(EcppStrformationCopy ecppStrformationCopy, Model model) {
		model.addAttribute("ecppStrformationCopy", ecppStrformationCopy);
		return "modules/zzjg/ecppStrformationCopyForm";
	}
	
	@RequiresPermissions("zzjg:ecppStrformationCopy:edit")
	@RequestMapping(value = "save")
	public String save(EcppStrformationCopy ecppStrformationCopy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ecppStrformationCopy)){
			return form(ecppStrformationCopy, model);
		}
		ecppStrformationCopy.setUnit(UserUtils.getUser().getOffice());
		ecppStrformationCopyService.save(ecppStrformationCopy);
		if("0".equals(ecppStrformationCopy.getStatuss())){
			ecppStrformationCopyService.saves(ecppStrformationCopy);
		}
		String msg = "";
		if("3".equals(ecppStrformationCopy.getStatuss())){
			//保存
			msg = "保存成功！";
		}else{
			//提交
			msg = "提交成功！";
		}
		model.addAttribute("ecppStrformationCopy", ecppStrformationCopy);
		addMessage(redirectAttributes, msg);
		//return "modules/zzjg/ecppStrformationCopyFormck";
		/*addMessage(redirectAttributes, "保存组织机构成功");*/
		return "redirect:"+Global.getAdminPath()+"/zzjg/ecppStrformationCopy/forms?id="+ecppStrformationCopy.getId();
	}

	@RequiresPermissions("zzjg:ecppStrformationCopy:edit")
	@RequestMapping(value = "save1")
	public String save1(EcppStrformationCopy ecppStrformationCopy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ecppStrformationCopy)){
			return form(ecppStrformationCopy, model);
		}
		ecppStrformationCopy.setUnit(UserUtils.getUser().getOffice());
		ecppStrformationCopyService.save(ecppStrformationCopy);
		addMessage(redirectAttributes, "保存组织机构成功");
		return "redirect:"+Global.getAdminPath()+"/zzjg/ecppStrformationCopy/?repage";
	}
	
	@RequiresPermissions("zzjg:ecppStrformationCopy:edit")
	@RequestMapping(value = "delete")
	public String delete(EcppStrformationCopy ecppStrformationCopy, RedirectAttributes redirectAttributes) {
		ecppStrformationCopyService.delete(ecppStrformationCopy);
		addMessage(redirectAttributes, "删除组织机构成功");
		return "redirect:"+Global.getAdminPath()+"/zzjg/ecppStrformationCopy/?repage";
	}

}