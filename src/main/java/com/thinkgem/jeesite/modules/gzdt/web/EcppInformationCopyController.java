/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gzdt.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.Encodes;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gzdt.entity.EcppInformationCopy;
import com.thinkgem.jeesite.modules.gzdt.service.EcppInformationCopyService;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 工作动态Controller
 * @author nan
 * @version 2018-04-03
 */
@Controller
@RequestMapping(value = "${adminPath}/gzdt/ecppInformationCopy")
public class EcppInformationCopyController extends BaseController {

	@Autowired
	private EcppInformationCopyService ecppInformationCopyService;
	// 文件保存目录相对路径
	private String basePath = "userfiles";
	
	@ModelAttribute
	public EcppInformationCopy get(@RequestParam(required=false) String id) {
		EcppInformationCopy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ecppInformationCopyService.get(id);
		}
		if (entity == null){
			entity = new EcppInformationCopy();
		}
		return entity;
	}
	
	@RequiresPermissions("gzdt:ecppInformationCopy:view")
	@RequestMapping(value = {"list", ""})
	public String list(EcppInformationCopy ecppInformationCopy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EcppInformationCopy> page = ecppInformationCopyService.findPage(new Page<EcppInformationCopy>(request, response), ecppInformationCopy); 
		model.addAttribute("page", page);
		return "modules/gzdt/ecppInformationCopyList";
	}
	
	@RequestMapping(value = "list1")
	public String list1(EcppInformationCopy ecppInformationCopy, HttpServletRequest request, HttpServletResponse response, Model model) {
		//获取用户角色，判断是否有删除操作权限
		Boolean isAllowDel = false;
		User user = UserUtils.getUser();
		if (user != null && user.getRoleList() != null) {
			List<Role> roleList = user.getRoleList();
			for (int i = 0; i < roleList.size(); i++) {
				String roleName = roleList.get(i).getEnname();
				if (roleName != null && roleName.equals("reform")) {	// 若用户属于改革办小组，则有删除操作权限
					isAllowDel = true;
				} 
			}
		}
		
		ecppInformationCopy.setStatus("1");
		Page<EcppInformationCopy> page = ecppInformationCopyService.findPage(new Page<EcppInformationCopy>(request, response), ecppInformationCopy); 
		model.addAttribute("page", page);
		model.addAttribute("isAllowDel", isAllowDel);
		return "modules/gzdt/ecppInformationCopyCheckList";
	}
	
	@RequiresPermissions("gzdt:ecppInformationCopy:view")
	@RequestMapping(value = "form")
	public String form(EcppInformationCopy ecppInformationCopy, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<EcppInformationCopy> page = ecppInformationCopyService.findPage(new Page<EcppInformationCopy>(request, response), ecppInformationCopy); 
//		model.addAttribute("page", page);
		model.addAttribute("ecppInformationCopy", ecppInformationCopy);
		return "modules/gzdt/ecppInformationCopyForm";
	}
	
	@RequestMapping(value = "form1")
	public String form1(EcppInformationCopy ecppInformationCopy, Model model) {
		model.addAttribute("ecppInformationCopy", ecppInformationCopy);
		return "modules/gzdt/ecppInformationCopyCheck";
	}

	/**
	 * 统计工作动态浏览数量
	 * @param ecppInformationCopy
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajaxCount")
	public void ajaxCount(EcppInformationCopy ecppInformationCopy, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(ecppInformationCopy.getAttribute4() == null || "".equals(ecppInformationCopy.getAttribute4())){
			Integer count = 0;
			count = count+1;
			ecppInformationCopy.setAttribute4(String.valueOf(count));
		}else{
			Integer count = Integer.valueOf(ecppInformationCopy.getAttribute4());
			count = count+1;
			ecppInformationCopy.setAttribute4(String.valueOf(count));
		}
		ecppInformationCopyService.save(ecppInformationCopy);
	}

	@RequiresPermissions("gzdt:ecppInformationCopy:edit")
	@RequestMapping(value = "save")
	public String save(EcppInformationCopy ecppInformationCopy, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		if (!beanValidator(model, ecppInformationCopy)){
			return form(ecppInformationCopy, request, response, model);
		}
		String str = Encodes.unescapeHtml(ecppInformationCopy.getInformationcontent());
		ecppInformationCopy.setInformationcontent(str);
		ecppInformationCopy.setUnit(UserUtils.getUser().getOffice());
		ecppInformationCopyService.save(ecppInformationCopy);
		addMessage(redirectAttributes, "操作成功！");
		return "redirect:"+Global.getAdminPath()+"/gzdt/ecppInformationCopy/list";
	}
	
	@RequiresPermissions("gzdt:ecppInformationCopy:edit")
	@RequestMapping(value = "delete")
	public String delete(EcppInformationCopy ecppInformationCopy, RedirectAttributes redirectAttributes) {
		ecppInformationCopyService.delete(ecppInformationCopy);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/gzdt/ecppInformationCopy/form";
	}

	/**
	 * 工作动态删除
	 * @param ecppInformationCopy
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("gzdt:ecppInformationCopy:edit")
	@RequestMapping(value = "deleteecppinfo")
	public String deleteecppinfo(EcppInformationCopy ecppInformationCopy, RedirectAttributes redirectAttributes) {
		ecppInformationCopyService.delete(ecppInformationCopy);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/gzdt/ecppInformationCopy/list1";
	}
	
	@RequiresPermissions("gzdt:ecppInformationCopy:edit")
	@RequestMapping(value = "deleteVie")
	public String deleteVie(EcppInformationCopy ecppInformationCopy, RedirectAttributes redirectAttributes) {
		ecppInformationCopyService.delete(ecppInformationCopy);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/gzdt/ecppInformationCopy/list";
	}
	
	
	/*
	 * @param id 文件上传目录，每条信息单独拥有一个id命名的文件夹
	 */
	@RequestMapping(value = "fileUpload")
	public String fileUpload(MultipartHttpServletRequest request,HttpServletResponse response,String id) throws IOException  {
		
		String test = "userFile";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String ymd = sdf.format(new Date());		 		
		
		String newUrl = request.getSession().getServletContext().getRealPath("/") + basePath + "/";
		newUrl += ymd + "/";
	        
		//String fileDir = "E:/ECPP_FILES/" + test + "/";    //文件上传目录，每条信息单独拥有一个id命名的文件夹,用于之后读取
		//|/userfiles/a742831c480f4eb49faaddd9159c8565/files/ecppwork/ecppWorkprogramme/2018/05/banner_img_01_01.jpg
		File tempfile = new File(newUrl);
		if (!tempfile.exists()) {
			tempfile.mkdirs();
		}
		String filePath = "";
		List <MultipartFile> files = request.getFiles("file");
		for(MultipartFile file :files){
//		System.out.println("fileName："+file.getOriginalFilename());
	        try {
	            //获取输出流
	            OutputStream os=new FileOutputStream(newUrl+file.getOriginalFilename());
	            //获取输入流 CommonsMultipartFile 中可以直接得到文件的流
	            InputStream is=file.getInputStream();
	            byte[] bts = new byte[102400];
	            //一个一个字节的读取并写入
	            while(is.read(bts)!=-1)
	            {
	                os.write(bts);
	            }
	           os.flush();
	           os.close();
	           is.close();
	          
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        }
	        filePath += basePath+"/"+ymd+"/"+file.getOriginalFilename()+"|";
		}
		System.out.println(filePath);
		return renderString(response, filePath);
	}

}