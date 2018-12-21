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
import com.thinkgem.jeesite.modules.ecppwork.dao.EcppWorkprogrammeCopyDao;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

/**
 * 查看工作方案Service
 * @author nan
 * @version 2018-03-31
 */
@Service
@Transactional(readOnly = true)
public class EcppWorkprogrammeCopyService extends CrudService<EcppWorkprogrammeCopyDao, EcppWorkprogrammeCopy> {

	public EcppWorkprogrammeCopy get(String id) {
		return super.get(id);
	}
	
	public List<EcppWorkprogrammeCopy> findList(EcppWorkprogrammeCopy ecppWorkprogrammeCopy) {
		return super.findList(ecppWorkprogrammeCopy);
	}
	
	public Page<EcppWorkprogrammeCopy> findPage(Page<EcppWorkprogrammeCopy> page, EcppWorkprogrammeCopy ecppWorkprogrammeCopy) {
		return super.findPage(page, ecppWorkprogrammeCopy);
	}
	
	@Transactional(readOnly = false)
	public void save(EcppWorkprogrammeCopy ecppWorkprogrammeCopy) {
		super.save(ecppWorkprogrammeCopy);
	}
	
	@Transactional(readOnly = false)
	public void delete(EcppWorkprogrammeCopy ecppWorkprogrammeCopy) {
		super.delete(ecppWorkprogrammeCopy);
	}
	
}