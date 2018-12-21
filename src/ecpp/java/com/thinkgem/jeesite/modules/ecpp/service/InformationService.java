/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.service;

import java.util.List;

import com.thinkgem.jeesite.modules.ecpp.dao.ImprovementsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.ecpp.entity.Information;
import com.thinkgem.jeesite.modules.ecpp.dao.InformationDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 管理提升信息表Service
 * @author zxt
 * @version 2018-03-21
 */
@Service
@Transactional(readOnly = true)
public class InformationService extends CrudService<InformationDao, Information> {
	@Autowired
	private ImprovementsDao improvementsDao;

	public Information get(String id) {
		return super.get(id);
	}
	
	public List<Information> findList(Information information) {
		return super.findList(information);
	}
	public List<Information> findList2(Information information) {
		return dao.findList2(information);
	}
	public List<Information> findList3(Information information) {
		return dao.findList3(information);
	}
	public List<Information> findList4(Information information) {
		return dao.findList4(information);
	}

    /**
     * 获取月报展示需要的数据
     * @return
     */
	public List<Information> getMonthReportNum() {
		return dao.getMonthReportNum();
	}

	public Integer getImCout(String type) {
		return improvementsDao.getImCout(type);
	}
	
	public Page<Information> findPage(Page<Information> page, Information information) {
		return super.findPage(page, information);
	}
	public Page<Information> findPage2(Page<Information> page, Information information) {
		information.setPage(page);
		page.setList(dao.findList2(information));
		return page;
	}
	public Page<Information> findPage5(Page<Information> page, Information information) {
		information.setPage(page);
		page.setList(dao.findList5(information));
		return page;
	}
	public Page<Information> findPage3(Page<Information> page, Information information) {
		information.setPage(page);
		page.setList(dao.findList3(information));
		return page;
	}
	public Page<Information> findPage4(Page<Information> page, Information information) {
		information.setPage(page);
		page.setList(dao.findList4(information));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(Information information) {
		super.save(information);
	}
	
	@Transactional(readOnly = false)
	public void delete(Information information) {
		super.delete(information);
	}
	/**
	 * 首页资讯
	 * @param
	 * @param type
	 * @return 
	 */
	public List<Information> findInfoList(String type) {
		List<Information> informations = Lists.newArrayList();
		Information information = new Information();
		information.setStatus("1");
		Office office = new Office();
		if (type.equals("work")) {
			office.setType("1");
			information.setUnit(office);
			informations = this.dao.findList(information);
		}else if (type.equals("dep")) {
			office.setType("2");
			//office.setGrade("1");
			information.setUnit(office);
			informations = this.dao.findList(information);
			
		}else if (type.equals("info")) {
			office.setType("3");
			//office.setGrade("2");
			information.setUnit(office);
			informations = this.dao.findList(information);
			
		}
		return informations;
		// TODO Auto-generated method stub
		
	}
	
}