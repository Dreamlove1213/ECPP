/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import com.thinkgem.jeesite.modules.sys.entity.*;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.security.shiro.session.SessionDAO;
import com.thinkgem.jeesite.common.servlet.ValidateCodeServlet;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.CookieUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.config.entity.EcppConfig;
import com.thinkgem.jeesite.modules.config.service.EcppConfigService;
import com.thinkgem.jeesite.modules.ecpp.entity.Information;
import com.thinkgem.jeesite.modules.ecpp.service.InformationService;
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogrammeCopy;
import com.thinkgem.jeesite.modules.ecppwork.service.EcppWorkprogrammeCopyService;
import com.thinkgem.jeesite.modules.sys.security.FormAuthenticationFilter;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.zzjg.entity.EcppStrformationCopyCopy;
import com.thinkgem.jeesite.modules.zzjg.service.EcppStrformationCopyCopyService;

/**
 * 登录Controller
 * @author ThinkGem
 * @version 2013-5-31
 */
@Controller
public class LoginController extends BaseController{
	
	@Autowired
	private SessionDAO sessionDAO;
	@Autowired
	private InformationService informationService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private EcppStrformationCopyCopyService ecppStrformationCopyCopyService;
	@Autowired
	private EcppWorkprogrammeCopyService ecppWorkprogrammeCopyService;
	@Autowired
	private EcppConfigService ecppConfigService;
	@Autowired
	private OaNotifyService oaNotifyService;
	@Autowired
	private OfficeService officeService;
	/**
	 * 管理登录
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();
		String userName = request.getParameter("username");
		String pwd = request.getParameter("password");

		if (logger.isDebugEnabled()){
			logger.debug("login, active session size: {}", sessionDAO.getActiveSessions(false).size());
		}
		
		// 如果已登录，再次访问主页，则退出原账号。
		if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex"))){
			CookieUtils.setCookie(response, "LOGINED", "false");
		}
		
		// 如果已经登录，则跳转到管理首页
		if(principal != null && !principal.isMobileLogin()){
			return "redirect:" + adminPath;
		}
		return "modules/sys/sysLogin";
	}

	/**
	 * 管理登录
	 */
	@RequestMapping(value = "${adminPath}/loginNewPage",method = RequestMethod.GET)
	public String loginNewPage(User user, HttpServletRequest request, HttpServletResponse response, Model model,ServletRequest request11, ServletResponse response11) {
		String resultPageURL = "modules/sys/sysLogin";
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			UsernamePasswordToken token = new com.thinkgem.jeesite.modules.sys.security.UsernamePasswordToken(username, password.toCharArray(), false, "", "", false);
			token.setRememberMe(true);
			Subject currentUser = SecurityUtils.getSubject();
			currentUser.login(token);
			if(currentUser.isAuthenticated()){
				resultPageURL = "redirect:" + adminPath;
			}else{
				token.clear();
			}
		}catch (Exception e){
			logger.error("[LoginController singleLogin]");
		}
		return resultPageURL;
	}

	/**
	 * 登录失败，真正登录的POST请求由Filter完成
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.POST)
	public String loginFail(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();
		// 如果已经登录，则跳转到管理首页
		if(principal != null){
			return "redirect:" + adminPath;
		}

		String username = WebUtils.getCleanParam(request, FormAuthenticationFilter.DEFAULT_USERNAME_PARAM);
		boolean rememberMe = WebUtils.isTrue(request, FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM);
		boolean mobile = WebUtils.isTrue(request, FormAuthenticationFilter.DEFAULT_MOBILE_PARAM);
		String exception = (String)request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
		String message = (String)request.getAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM);
		
		if (StringUtils.isBlank(message) || StringUtils.equals(message, "null")){
			message = "用户或密码错误, 请重试.";
		}

		model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM, rememberMe);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MOBILE_PARAM, mobile);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME, exception);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
		
		if (logger.isDebugEnabled()){
			logger.debug("login fail, active session size: {}, message: {}, exception: {}", 
					sessionDAO.getActiveSessions(false).size(), message, exception);
		}
		
		// 非授权异常，登录失败，验证码加1。
		if (!UnauthorizedException.class.getName().equals(exception)){
			model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(username, true, false));
		}
		
		// 验证失败清空验证码
		request.getSession().setAttribute(ValidateCodeServlet.VALIDATE_CODE, IdGen.uuid());
		
		// 如果是手机登录，则返回JSON字符串
		if (mobile){
	        return renderString(response, model);
		}
		//return "modules/sys/sysLogin";	//登陆失败跳转到登录页
		return "modules/sys/sysLogin3"; //登陆失败跳转为游客
	}

	/**
	 * 登录成功，进入管理首页
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "${adminPath}")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) {
		Principal principal = UserUtils.getPrincipal();

		// 登录成功后，验证码计算器清零
		isValidateCodeLogin(principal.getLoginName(), false, true);
		
		if (logger.isDebugEnabled()){
			logger.debug("show index, active session size: {}", sessionDAO.getActiveSessions(false).size());
		}
		
		// 如果已登录，再次访问主页，则退出原账号。
		if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex"))){
			String logined = CookieUtils.getCookie(request, "LOGINED");
			if (StringUtils.isBlank(logined) || "false".equals(logined)){
				CookieUtils.setCookie(response, "LOGINED", "true");
			}else if (StringUtils.equals(logined, "true")){
				UserUtils.getSubject().logout();
				return "redirect:" + adminPath + "/login";
			}
		}
		
		// 如果是手机登录，则返回JSON字符串
		if (principal.isMobileLogin()){
			if (request.getParameter("login") != null){
				return renderString(response, principal);
			}
			if (request.getParameter("index") != null){
				return "modules/sys/sysIndex";
			}
			return "redirect:" + adminPath + "/login";
		}
		
//		// 登录成功后，获取上次登录的当前站点ID
//		UserUtils.putCache("siteId", StringUtils.toLong(CookieUtils.getCookie(request, "siteId")));

//		System.out.println("==========================a");
//		try {
//			byte[] bytes = com.thinkgem.jeesite.common.utils.FileUtils.readFileToByteArray(
//					com.thinkgem.jeesite.common.utils.FileUtils.getFile("c:\\sxt.dmp"));
//			UserUtils.getSession().setAttribute("kkk", bytes);
//			UserUtils.getSession().setAttribute("kkk2", bytes);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
////		for (int i=0; i<1000000; i++){
////			//UserUtils.getSession().setAttribute("a", "a");
////			request.getSession().setAttribute("aaa", "aa");
////		}
//		System.out.println("==========================b");

		List<Role> roleList = UserUtils.getRoleList();
		int a=0;
		for(Role role:roleList){
			if("reform".equals(role.getEnname())){
				a=a+1;
			}
		}
		Information informationHository = new Information();
		if (a != 1){
			String officeId = UserUtils.getUser().getOffice().getId();
			Office o = officeService.getOne(officeId);
			informationHository.setUnit(o);
		}
		List<Information> informationListHository = informationService.findList(informationHository);
		model.addAttribute("newslisHository", informationListHository);

		List<News> newslist = new ArrayList<News>();
		if(a>0){
			//获取没有审批的提交信息
			Information informations = new Information();
			informations.setStatus("0");
			List<Information> informationList = informationService.findList(informations);
			for(Information information:informationList){
				String id=information.getId();
				String url="/ecpp/information/informationCheck?id="+id;
				String name=information.getInformationtitle();
				News news=new News();
				news.setUrl(url);
				news.setName(name);
				news.setCreateDate(information.getCreateDate());
				newslist.add(news);
			}
			//获取未看过的通讯录。
			EcppStrformationCopyCopy ecppStrformationCopyCopys=new EcppStrformationCopyCopy();
			ecppStrformationCopyCopys.setStatus("0");
			List<EcppStrformationCopyCopy> ecppStrformationCopyCopylist = ecppStrformationCopyCopyService.findList(ecppStrformationCopyCopys);
			for(EcppStrformationCopyCopy ecppStrformationCopyCopy:ecppStrformationCopyCopylist){
				String id=ecppStrformationCopyCopy.getId();
				String url="/zzjg/ecppStrformationCopyCopy/form?id="+id;
				String name="通讯录："+ecppStrformationCopyCopy.getUnit().getName();
				News news=new News();
				news.setUrl(url);
				news.setName(name);
				news.setCreateDate(ecppStrformationCopyCopy.getCreateDate());
				newslist.add(news);
			}
			//获取没有看过的工作方案
			EcppWorkprogrammeCopy ecppWorkprogrammeCopys = new EcppWorkprogrammeCopy();
			ecppWorkprogrammeCopys.setStatus("0");
			List<EcppWorkprogrammeCopy> ecppWorkprogrammeCopylist = ecppWorkprogrammeCopyService.findList(ecppWorkprogrammeCopys);
			for(EcppWorkprogrammeCopy ecppWorkprogrammeCopy:ecppWorkprogrammeCopylist){
				String id=ecppWorkprogrammeCopy.getId();
				String url="/ecppwork/ecppWorkprogrammeCopy/form?id="+id;
				String name=ecppWorkprogrammeCopy.getInformationtitle();
				News news=new News();
				news.setUrl(url);
				news.setName(name);
				news.setCreateDate(ecppWorkprogrammeCopy.getCreateDate());
				newslist.add(news);
			}
		}else{
			//获取被驳回的提交信息
			Information informations = new Information();
			informations.setStatus("2");
			informations.setAttribute4("1");
			informations.setCreateBy(UserUtils.getUser());
			List<Information> informationList = informationService.findList(informations);
			for(Information information:informationList){
				String id=information.getId();
				String url="/ecpp/information/form?id="+id;
				String name=information.getInformationtitle()+"----被驳回了";
				News news=new News();
				news.setUrl(url);
				news.setName(name);
				news.setCreateDate(information.getCreateDate());
				newslist.add(news);
			}
		}
		model.addAttribute("newslist", newslist);
		
		List<String> stringlist=new ArrayList<String>();
		EcppConfig ecppConfig=new EcppConfig();
		List<EcppConfig> ecppConfiglist = ecppConfigService.findList(ecppConfig);
		if(ecppConfiglist.size()>0){
			EcppConfig ecppConfigs=ecppConfiglist.get(0);
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
			String newdate=df.format(new Date())+" 00:00:00";
			
			SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			try {
				Date xzDate=df1.parse(newdate);
				
				//System.out.println(xzDate+"******************");
				// 第一阶段
				String firstname=ecppConfigs.getFirstname();				// 第一阶段名称
				Date firststartdate=ecppConfigs.getFirststartdate();		// 第一阶段开始时间
				Date firstenddate=ecppConfigs.getFirstenddate();			// 第一阶段结束时间
				long diff = firststartdate.getTime() - xzDate.getTime(); 	
			    long firststartdates = diff / (1000 * 60 * 60 * 24);
			    if(7>firststartdates&&(firststartdates>0||firststartdates==0)){
			    	String tx=firstname+"将在"+firststartdates+"天后开始";
			    	stringlist.add(tx);
			    }
			    
			    long firstenddatess = firstenddate.getTime() - xzDate.getTime(); // 第一阶段结束时间
			    long firstenddates = firstenddatess / (1000 * 60 * 60 * 24);
			    if(7>firstenddates&&(firstenddates>0||firstenddates==0)){
			    	String tx=firstname+"将在"+firstenddates+"天后结束";
			    	stringlist.add(tx);
			    }
			    
			    // 第二阶段
			    String secondname=ecppConfigs.getSecondname();				// 第二阶段名称
				Date secondstartdate=ecppConfigs.getSecondstartdate();		// 第二阶段开始时间
				Date secondenddate=ecppConfigs.getSecondenddate();			// 第二阶段结束时间
			    
				long secondstartdatess = secondstartdate.getTime() - xzDate.getTime(); // 第二阶段开始时间
			    long secondstartdates = secondstartdatess / (1000 * 60 * 60 * 24);
			    if(7>secondstartdates&&(secondstartdates>0||secondstartdates==0)){
			    	String tx=secondname+"将在"+secondstartdates+"天后开始";
			    	stringlist.add(tx);
			    }
			    
			    long secondenddatess = secondenddate.getTime() - xzDate.getTime(); // 第二阶段结束时间
			    long secondenddates = secondenddatess / (1000 * 60 * 60 * 24);
			    if(7>secondenddates&&(secondenddates>0||secondenddates==0)){
			    	String tx=secondname+"将在"+secondenddates+"天后结束";
			    	stringlist.add(tx);
			    }
			    
			    // 第三阶段
			    String thirdname=ecppConfigs.getThirdname();				// 第三阶段名称
				Date thirdstartdate=ecppConfigs.getThirdstartdate();		// 第三阶段开始时间
				Date thirdenddate=ecppConfigs.getThirdenddate();			// 第三阶段结束时间
			    long thirdstartdatess = thirdstartdate.getTime() - xzDate.getTime(); // 第三阶段开始时间
			    long thirdstartdates = thirdstartdatess / (1000 * 60 * 60 * 24);
			    if(7>thirdstartdates&&(thirdstartdates>0||thirdstartdates==0)){
			    	String tx=thirdname+"将在"+thirdstartdates+"天后开始";
			    	stringlist.add(tx);
			    }
			    
			    long thirdenddatess = thirdenddate.getTime() - xzDate.getTime(); // 第三阶段结束时间
			    long thirdenddates = thirdenddatess / (1000 * 60 * 60 * 24);
			    if(7>thirdenddates&&(thirdenddates>0||thirdenddates==0)){
			    	String tx=thirdname+"将在"+thirdenddates+"天后结束";
			    	stringlist.add(tx);
			    }
			    
			    // 第四阶段
			    String fouthname=ecppConfigs.getFouthname();				// 第四阶段名称
				Date fouthstartdate=ecppConfigs.getFouthstartdate();		// 第四阶段开始时间
				Date fouthenddate=ecppConfigs.getFouthenddate();			// 第四阶段结束时间
				long fouthstartdatess = fouthstartdate.getTime() - xzDate.getTime(); // 第四阶段开始时间
				long fouthstartdates = fouthstartdatess / (1000 * 60 * 60 * 24);
				if(7>fouthstartdates&&(fouthstartdates>0||fouthstartdates==0)){
					String tx=fouthname+"将在"+fouthstartdates+"天后开始";
					stringlist.add(tx);
				}
				
			    long fouthenddatess = fouthenddate.getTime() - xzDate.getTime(); // 第四阶段结束时间
			    long fouthenddates = fouthenddatess / (1000 * 60 * 60 * 24);
			    if(7>fouthenddates&&(fouthenddates>0||fouthenddates==0)){
			    	String tx=fouthname+"将在"+fouthenddates+"天后结束";
			    	stringlist.add(tx);
			    }
			    
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}


		OaNotify oaNotify = new OaNotify();
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		List<OaNotify> oanatifylist = oaNotifyService.findList(oaNotify);
		StringBuffer idString = new StringBuffer();
		if(oanatifylist.size() != 0){
			for (int i = 0; i < oanatifylist.size(); i++) {
				idString.append(oanatifylist.get(i).getId());
				idString.append(",");
			}
			model.addAttribute("oanatifylist", oaNotify);
			model.addAttribute("idString", idString);
		}
		model.addAttribute("stringlist", stringlist);

		List<Menu> menuList = systemService.findAllMenu();
        model.addAttribute("menuList", menuList);
		return "modules/sys/sysIndex";
	}
	
	/**
	 * 获取主题方案
	 */
	@RequestMapping(value = "/theme/{theme}")
	public String getThemeInCookie(@PathVariable String theme, HttpServletRequest request, HttpServletResponse response){
		if (StringUtils.isNotBlank(theme)){
			CookieUtils.setCookie(response, "theme", theme);
		}else{
			theme = CookieUtils.getCookie(request, "theme");
		}
		return "redirect:"+request.getParameter("url");
	}
	
	/**
	 * 是否是验证码登录
	 * @param useruame 用户名
	 * @param isFail 计数加1
	 * @param clean 计数清零
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean){
		Map<String, Integer> loginFailMap = (Map<String, Integer>)CacheUtils.get("loginFailMap");
		if (loginFailMap==null){
			loginFailMap = Maps.newHashMap();
			CacheUtils.put("loginFailMap", loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum==null){
			loginFailNum = 0;
		}
		if (isFail){
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean){
			loginFailMap.remove(useruame);
		}
		return loginFailNum >= 3;
	}
}
