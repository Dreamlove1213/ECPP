/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecppwork.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogramme;
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogrammeCopy;
import com.thinkgem.jeesite.modules.ecppwork.dao.EcppWorkprogrammeDao;

/**
 * 工作方案Service
 * @author nan
 * @version 2018-03-29
 */
@Service
@Transactional(readOnly = true)
public class EcppWorkprogrammeService extends CrudService<EcppWorkprogrammeDao, EcppWorkprogramme> {

	@Autowired
	private EcppWorkprogrammeCopyService ecppWorkprogrammeCopyService;
	
	public EcppWorkprogramme get(String id) {
		return super.get(id);
	}
	
	public List<EcppWorkprogramme> findList(EcppWorkprogramme ecppWorkprogramme) {
		return super.findList(ecppWorkprogramme);
	}

	public List<EcppWorkprogramme> findListByqiyeGroupByUnit(EcppWorkprogramme ecppWorkprogramme) {
		return this.dao.findListByqiyeGroupByUnit(ecppWorkprogramme);
	}
	
	public Page<EcppWorkprogramme> findPage(Page<EcppWorkprogramme> page, EcppWorkprogramme ecppWorkprogramme) {
		return super.findPage(page, ecppWorkprogramme);
	}
	
	@Transactional(readOnly = false)
	public void save(EcppWorkprogramme ecppWorkprogramme) {
		super.save(ecppWorkprogramme);
	}
	
	@Transactional(readOnly = false)
	public void saves(EcppWorkprogramme ecppWorkprogramme) {
		EcppWorkprogrammeCopy ecppWorkprogrammeCopy=new EcppWorkprogrammeCopy();
		ecppWorkprogrammeCopy.setUnit(ecppWorkprogramme.getUnit());
//		ecppWorkprogrammeCopyService.delete(ecppWorkprogrammeCopy);
		
		ecppWorkprogrammeCopy.setDelFlag("0");
		ecppWorkprogrammeCopy.setInformationtitle(ecppWorkprogramme.getInformationtitle());		// 工作方案标题
		ecppWorkprogrammeCopy.setInformationcontent(ecppWorkprogramme.getInformationcontent());		// 工作方案内容
		ecppWorkprogrammeCopy.setAttachment(ecppWorkprogramme.getAttachment());		// 附件
//		ecppWorkprogrammeCopy.setStatus(ecppWorkprogramme.getStatuss());		// 工作方案审核状态
		ecppWorkprogrammeCopy.setUnit(ecppWorkprogramme.getUnit());		// 单位
		ecppWorkprogrammeCopy.setRemarks(ecppWorkprogramme.getRemarks());
		ecppWorkprogrammeCopy.preInsert();
		ecppWorkprogrammeCopyService.save(ecppWorkprogrammeCopy);
	}
	
	@Transactional(readOnly = false)
	public void delete(EcppWorkprogramme ecppWorkprogramme) {
		super.delete(ecppWorkprogramme);
	}
	
}