/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.config.web;

import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.config.entity.EcppConfig;
import com.thinkgem.jeesite.modules.config.service.EcppConfigService;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 管理提升控制信息Controller
 * @author zxt
 * @version 2018-03-21
 */
@Controller
@RequestMapping(value = "${adminPath}/config/ecppConfig")
public class EcppConfigController extends BaseController {

	@Autowired
	private EcppConfigService ecppConfigService;
	@Autowired
	private OaNotifyService oaNotifyService;
	
	@ModelAttribute
	public EcppConfig get(@RequestParam(required=false) String id) {
		EcppConfig entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ecppConfigService.get(id);
		}
		if (entity == null){
			entity = new EcppConfig();
		}
		return entity;
	}

	@RequiresPermissions("config:ecppConfig:view")
	@RequestMapping(value = "form")
	public String form(EcppConfig ecppConfig, Model model) {
		//获取时间控制数据并进入编辑模式
		model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
		return "modules/config/ecppConfigForm";
	}

	/**
	 * 环节倒计时提醒
	 * @param ecppConfig
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "layerNotice1")
	public String layerNotice1(EcppConfig ecppConfig, Model model) {

		List<String> stringlist=new ArrayList<String>();
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
				e.printStackTrace();
			}
		}

		model.addAttribute("stringlist", stringlist);

		return "modules/ecpp/layerNotice1";
	}

	/**
	 * 群发通知
	 * @param ecppConfig
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "layerNotice2")
	public String layerNotice2(EcppConfig ecppConfig, Model model) {
		OaNotify oaNotify = new OaNotify();
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		List<OaNotify> oanatifylist = oaNotifyService.findList(oaNotify);
		if (oanatifylist.size() != 0) {
			model.addAttribute("oanatifylist", oanatifylist);
		}
		return "modules/ecpp/layerNotice2";
	}
	
	@RequiresPermissions("config:ecppConfig:view")
	@RequestMapping(value = "nodeForm")
	public String nodeForm(EcppConfig ecppConfig, Model model) {
		//小结开关,管理员（改革办）设置显示或者隐藏
		model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
		return "modules/config/ecppNodeConfigForm";
	}

	@RequiresPermissions("config:ecppConfig:edit")
	@RequestMapping(value = "save")
	public String save(EcppConfig ecppConfig, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ecppConfig)){
			return form(ecppConfig, model);
		}
		ecppConfigService.save(ecppConfig);
		addMessage(redirectAttributes, "保存管理提升控制信息成功");
		model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
		return "modules/config/ecppConfigForm";
	}
	
	@RequiresPermissions("config:ecppConfig:edit")
	@RequestMapping(value = "nodeSave")
	public String nodeSave(EcppConfig ecppConfig, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ecppConfig)){
			return form(ecppConfig, model);
		}
		ecppConfigService.save(ecppConfig);
		addMessage(redirectAttributes, "保存管理提升小节控制信息成功");
		model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
		return "modules/config/ecppNodeConfigForm";
	}
	
	@RequiresPermissions("config:ecppConfig:edit")
	@RequestMapping(value = "delete")
	public String delete(EcppConfig ecppConfig, RedirectAttributes redirectAttributes) {
		ecppConfigService.delete(ecppConfig);
		addMessage(redirectAttributes, "删除管理提升控制信息成功");
		return "redirect:"+Global.getAdminPath()+"/config/ecppConfig/?repage";
	}

}