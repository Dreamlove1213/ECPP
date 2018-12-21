/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.stion.web;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.stion.dao.StrformationitemDao;
import com.thinkgem.jeesite.modules.stion.entity.Strformation;
import com.thinkgem.jeesite.modules.stion.entity.Strformationitem;
import com.thinkgem.jeesite.modules.stion.service.StrformationService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 新建通讯录Controller
 * @author awei
 * @version 2018-05-12
 */
@Controller
@RequestMapping(value = "${adminPath}/stion/strformation")
public class StrformationController extends BaseController {

	@Autowired
	private StrformationService strformationService;
	
	@Autowired
	private StrformationitemDao strformationitemDao;
	
	@ModelAttribute
	public Strformation get(@RequestParam(required=false) String id) {
		Strformation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = strformationService.get(id);
		}
		if (entity == null){
			entity = new Strformation();
		}
		return entity;
	}
	
	@RequiresPermissions("stion:strformation:view")
	@RequestMapping(value = {"list", ""})
	public String list(Strformation strformation, HttpServletRequest request, HttpServletResponse response, Model model) {
		strformation.setStatus(DictUtils.STATUS_STION_YES);
		Page<Strformation> page = strformationService.findPage(new Page<Strformation>(request, response), strformation); 
		model.addAttribute("page", page);
		return "modules/ecpp/stion/strformationList";
	}

	@RequiresPermissions("stion:strformation:edit")
	@RequestMapping(value = "form")
	public String form(Strformation strformation,String id, Model model,HttpServletRequest request, HttpServletResponse response) {
		model.addAttribute("strformation", strformation);
		return "modules/ecpp/stion/strformation_formwriter";
	}

	@RequiresPermissions("stion:strformation:edit")
	@RequestMapping(value = "save")
	public String save(Strformation strformation, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		if (!beanValidator(model, strformation)){
			return form(strformation, adminPath, model,request,response);
		}
		if(strformation.getStatus() != null && !"".equals(strformation.getStatus()) && "1".equals(strformation.getStatus())){	//只有提交的时候验证
			boolean df = this.checkMobileNumbernumXX(strformation.getDianhua());	//电话
			boolean email = this.checkEmail(strformation.getYouxiang());
			if(!df){
				addMessage(redirectAttributes, "请输入正确的电话！");
				return "redirect:"+Global.getAdminPath()+"/stion/strformation/form?id="+strformation.getId();
			}
			if(!email){
				addMessage(redirectAttributes, "请输入正确邮箱！");
				return "redirect:"+Global.getAdminPath()+"/stion/strformation/form?id="+strformation.getId();
			}
			if(strformation.getStrformationitemList().size() == 0){
				addMessage(redirectAttributes, "最少添加一条联络人信息！");
				return "redirect:"+Global.getAdminPath()+"/stion/strformation/form?id="+strformation.getId();
			}
			
			if(strformation.getStrformationitemList().size() != 0){
				
					for (int i = 0; i < strformation.getStrformationitemList().size(); i++) {
						Strformationitem  s= strformation.getStrformationitemList().get(i);
						if(s != null && !"".equals(s) && s.getDianhua() != null && !"".equals(s.getDianhua())){
							
							boolean s1dianhua = this.checkMobileNumbernumXX(s.getDianhua());	//电话
							boolean s1shouji = this.checkMobileNumber11(s.getShouji());	//手机
							boolean s2email = this.checkEmail(s.getYouxiang());
							if(!s1dianhua){
								addMessage(redirectAttributes, "请输入正确的电话！");
								return "redirect:"+Global.getAdminPath()+"/stion/strformation/form?id="+strformation.getId();
							}
							if(!s1shouji){
								addMessage(redirectAttributes, "请输入正确的手机号！");
								return "redirect:"+Global.getAdminPath()+"/stion/strformation/form?id="+strformation.getId();
							}
							if(!s2email){
								addMessage(redirectAttributes, "请输入正确邮箱！");
								return "redirect:"+Global.getAdminPath()+"/stion/strformation/form?id="+strformation.getId();
							}
						}
					}
			}
		}
		strformation.setUnit(UserUtils.getUser().getOffice());
		strformationService.save(strformation);
		String status = strformation.getStatus();
		if (status.equals(DictUtils.STATUS_STION_NO)) {
			addMessage(redirectAttributes, "保存通讯录成功");
		}else if (status.equals(DictUtils.STATUS_STION_YES)) {
			addMessage(redirectAttributes, "提交通讯录成功");
		}
		return "redirect:"+Global.getAdminPath()+"/stion/strformation/formWriterOrShow?repage";
	}
	
	@RequiresPermissions("stion:strformation:edit")
	@RequestMapping(value = "delete")
	public String delete(Strformation strformation, RedirectAttributes redirectAttributes) {
		strformationService.delete(strformation);
		addMessage(redirectAttributes, "删除新建通讯录成功");
		return "redirect:"+Global.getAdminPath()+"/stion/strformation/?repage";
	}

	/**
	 * stion-1-1:通讯录显示
	 * @param strformation
	 * @param model
	 * @return
	 */
	@RequiresPermissions("stioneors:strformation:view")
	@RequestMapping(value = "formWriterOrShow")
	public String formWriterOrShow(Strformation strformation, Model model, @RequestParam(required=false, defaultValue="false") boolean todo) {
		model.addAttribute("todo", todo);
		if (StringUtils.isBlank(strformation.getId())) {
			strformation.setUnit(UserUtils.getUser().getOffice());
			List<Strformation> strformationList = strformationService.findList(strformation);
			if (strformationList.size() > 0) {
				strformation = strformationList.get(0);
				strformation.setStrformationitemList(strformationitemDao.findList(new Strformationitem(strformation)));
				model.addAttribute("strformation", strformation);
				return "modules/ecpp/stion/strformation_formshow";
			}else {
				return "modules/ecpp/stion/strformation_formwriter";
			}
		}else {
			model.addAttribute("strformation", strformation);
			return "modules/ecpp/stion/strformation_formshow";
		}
	}
	
	/**
	 * stion-1-2:查看通讯录
	 * @param strformation
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("stionlist:strformation:view")
	@RequestMapping(value = {"stionList"})
	public String stionList(Strformation strformation, HttpServletRequest request, HttpServletResponse response, Model model) {
		strformation.setStatus(DictUtils.STATUS_STION_YES);
		Page<Strformation> page = strformationService.findPage(new Page<Strformation>(request, response), strformation); 
		model.addAttribute("page", page);
		return "modules/ecpp/stion/strformationList";
	}

	/**
	 * 导出通讯录数据
	 * @param strformation
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "export", method= RequestMethod.POST)
	public String exportFile(Strformation strformation, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "通讯录数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
			List<Strformation> strformationsList = strformationService.findList(strformation);

			new ExportExcel("通讯录数据", Strformation.class).setDataList(strformationsList).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出通讯录失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/stion/strformation/stionList";
	}
	
	/**
	 * 验证邮箱
	 *
	 * @param email
	 * @return
	 */

	public boolean checkEmail(String email) {
	    boolean flag = false;
	    try {
	        String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
	        Pattern regex = Pattern.compile(check);
	        Matcher matcher = regex.matcher(email);
	        flag = matcher.matches();
	    } catch (Exception e) {
	        flag = false;
	    }
	    return flag;
	}

	/**
	 * 验证手机号码，11位数字，1开通，第二位数必须是3456789这些数字之一 *
	 * @param mobileNumber
	 * @return
	 */
	public boolean checkMobileNumber(String mobileNumber) {
	    boolean flag = false;
	    try {
	        // Pattern regex = Pattern.compile("^(((13[0-9])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8})|(0\\d{2}-\\d{8})|(0\\d{3}-\\d{7})$");
	        Pattern regex = Pattern.compile("^1[345789]\\d{9}$");
	        Matcher matcher = regex.matcher(mobileNumber);
	        flag = matcher.matches();
	    } catch (Exception e) {
	        e.printStackTrace();
	        flag = false;

	    }
	    return flag;
	}
	
	/**
	 * 验证手机号码，11位数字
	 * @param mobileNumber
	 * @return
	 */
	public boolean checkMobileNumber11(String mobileNumber) {
		boolean flag = false;
		try {
			// Pattern regex = Pattern.compile("^(((13[0-9])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8})|(0\\d{2}-\\d{8})|(0\\d{3}-\\d{7})$");
			Pattern regex = Pattern.compile("^\\d{11}$");
			Matcher matcher = regex.matcher(mobileNumber);
			flag = matcher.matches();
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
			
		}
		return flag;
	}
	
	/**
	 * 验证手机号码，11位数字，1开通，第二位数必须是3456789这些数字之一 *
	 * @param mobileNumber
	 * @return
	 */
	public boolean checkMobileNumbernum(String mobileNumber) {
		boolean flag = false;
		try {
			// Pattern regex = Pattern.compile("^(((13[0-9])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8})|(0\\d{2}-\\d{8})|(0\\d{3}-\\d{7})$");
			//Pattern regex = Pattern.compile("^1[345789]\\d{9}$");
			Pattern regex = Pattern.compile("^\\d+$");
			Matcher matcher = regex.matcher(mobileNumber);
			flag = matcher.matches();
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
			
		}
		return flag;
	}
	
	/**
	 * 验证手机号码，xxx-xxxxxxxxx xxxx-xxxxxxxxx
	 * @param mobileNumber
	 * @return
	 */
	public boolean checkMobileNumbernumXX(String mobileNumber) {
		boolean flag = false;
		try {
			Pattern regex = Pattern.compile("^(0\\d{2}-\\d{7,8})|(0\\d{3}-\\d{7,8})$");
			//Pattern regex = Pattern.compile("^1[345789]\\d{9}$");
			//Pattern regex = Pattern.compile("^\\d+$");
			Matcher matcher = regex.matcher(mobileNumber);
			flag = matcher.matches();
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
			
		}
		return flag;
	}
	
}