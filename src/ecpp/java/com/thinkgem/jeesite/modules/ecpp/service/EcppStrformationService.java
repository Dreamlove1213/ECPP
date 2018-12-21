/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.ecpp.entity.EcppStrformation;
import com.thinkgem.jeesite.modules.ecpp.dao.EcppStrformationDao;

/**
 * 组建机构Service
 * @author lin
 * @version 2018-03-27
 */
@Service
@Transactional(readOnly = true)
public class EcppStrformationService extends CrudService<EcppStrformationDao, EcppStrformation> {

	public EcppStrformation get(String id) {
		return super.get(id);
	}
	
	public List<EcppStrformation> findList(EcppStrformation ecppStrformation) {
		return super.findList(ecppStrformation);
	}
	
	public Page<EcppStrformation> findPage(Page<EcppStrformation> page, EcppStrformation ecppStrformation) {
		return super.findPage(page, ecppStrformation);
	}
	
	@Transactional(readOnly = false)
	public void save(EcppStrformation ecppStrformation) {
		super.save(ecppStrformation);
	}
	
	@Transactional(readOnly = false)
	public void delete(EcppStrformation ecppStrformation) {
		super.delete(ecppStrformation);
	}
	
}