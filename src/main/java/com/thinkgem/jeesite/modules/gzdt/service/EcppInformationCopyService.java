/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gzdt.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.gzdt.entity.EcppInformationCopy;
import com.thinkgem.jeesite.modules.gzdt.dao.EcppInformationCopyDao;

/**
 * 工作动态Service
 * @author nan
 * @version 2018-04-03
 */
@Service
@Transactional(readOnly = true)
public class EcppInformationCopyService extends CrudService<EcppInformationCopyDao, EcppInformationCopy> {

	public EcppInformationCopy get(String id) {
		return super.get(id);
	}
	
	public List<EcppInformationCopy> findList(EcppInformationCopy ecppInformationCopy) {
		return super.findList(ecppInformationCopy);
	}
	
	public List<EcppInformationCopy> findInfoList() {
		EcppInformationCopy ecppInformationCopy=new EcppInformationCopy();
		ecppInformationCopy.setStatus("1");
		return super.findList(ecppInformationCopy);
	}
	
	public Page<EcppInformationCopy> findPage(Page<EcppInformationCopy> page, EcppInformationCopy ecppInformationCopy) {
		return super.findPage(page, ecppInformationCopy);
	}
	
	@Transactional(readOnly = false)
	public void save(EcppInformationCopy ecppInformationCopy) {
		super.save(ecppInformationCopy);
	}
	
	@Transactional(readOnly = false)
	public void delete(EcppInformationCopy ecppInformationCopy) {
		super.delete(ecppInformationCopy);
	}
	
}