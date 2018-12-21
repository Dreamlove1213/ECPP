/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.config.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.config.entity.EcppConfig;
import com.thinkgem.jeesite.modules.config.dao.EcppConfigDao;

/**
 * 管理提升控制信息Service
 * @author zxt
 * @version 2018-03-21
 */
@Service
@Transactional(readOnly = true)
public class EcppConfigService extends CrudService<EcppConfigDao, EcppConfig> {

	public EcppConfig get(String id) {
		return super.get(id);
	}
	
	public List<EcppConfig> findList(EcppConfig ecppConfig) {
		return super.findList(ecppConfig);
	}
	
	public Page<EcppConfig> findPage(Page<EcppConfig> page, EcppConfig ecppConfig) {
		return super.findPage(page, ecppConfig);
	}
	
	@Transactional(readOnly = false)
	public void save(EcppConfig ecppConfig) {
		super.save(ecppConfig);
	}
	
	@Transactional(readOnly = false)
	public void delete(EcppConfig ecppConfig) {
		super.delete(ecppConfig);
	}

	/**
	 * 第三环节
	 * 判断是否可以上报
	 * @return
	 */
	public Map<String,String> isReport(Integer i){
		Map<String,String> map = new HashMap<String,String>();
		Date nowTime = new Date();
		EcppConfig ecppConfig = this.get("089073542a8e4cc28ed44a1afc14e6f3");
		if(i == 2){
			if(!nowTime.after(ecppConfig.getSecondstartdate())){
				map.put("isReport","0");
				map.put("msg","填报未开始！");
				return map;
			}else
			if(!nowTime.before(ecppConfig.getSecondenddate())){
				map.put("isReport","0");
				map.put("msg","已过填报时间！");
				return map;
			}else
			if(!"1".equals(ecppConfig.getSecondisstart())){
				map.put("isReport","0");
				map.put("msg","填报已经关闭！");
				return map;
			}else if(nowTime.after(ecppConfig.getSecondstartdate()) && nowTime.before(ecppConfig.getSecondenddate()) && "1".equals(ecppConfig.getSecondisstart())){
				map.put("isReport","1");
				map.put("msg","正常填报！");
				return map;
			}
		}else if(i == 3){
			if(!nowTime.after(ecppConfig.getThirdstartdate())){
				map.put("isReport","0");
				map.put("msg","填报未开始！");
				return map;
			}else if(!nowTime.before(ecppConfig.getThirdenddate())){
				map.put("isReport","0");
				map.put("msg","已过填报时间！");
				return map;
			}else if(!"1".equals(ecppConfig.getThirdisstart())){
				map.put("isReport","0");
				map.put("msg","填报已关闭！");
				return map;
			}else if(nowTime.after(ecppConfig.getThirdstartdate()) && nowTime.before(ecppConfig.getThirdenddate()) && "1".equals(ecppConfig.getThirdisstart())){
				map.put("isReport","1");
				map.put("msg","正常填报！");
				return map;
			}
		}else{
			if(!nowTime.after(ecppConfig.getFouthstartdate())){
				map.put("isReport","0");
				map.put("msg","填报未开始！");
				return map;
			}else if(!nowTime.before(ecppConfig.getFouthenddate())){
				map.put("isReport","0");
				map.put("msg","已过填报时间！");
				return map;
			}else if(!"1".equals(ecppConfig.getFirstisstart())){
				map.put("isReport","0");
				map.put("msg","填报已关闭！");
				return map;
			}else if(nowTime.after(ecppConfig.getFouthstartdate()) && nowTime.before(ecppConfig.getFouthenddate()) && "1".equals(ecppConfig.getFirstisstart())){
				map.put("isReport","1");
				map.put("msg","正常填报！");
				return map;
			}
		}
		return map;
	}
	
}