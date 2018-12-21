/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zzjg.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zzjg.entity.EcppStrformationCopyCopy;
import com.thinkgem.jeesite.modules.zzjg.dao.EcppStrformationCopyCopyDao;

/**
 * 组织机构Service
 * @author nan
 * @version 2018-03-31
 */
@Service
@Transactional(readOnly = true)
public class EcppStrformationCopyCopyService extends CrudService<EcppStrformationCopyCopyDao, EcppStrformationCopyCopy> {

	public EcppStrformationCopyCopy get(String id) {
		return super.get(id);
	}
	
	public List<EcppStrformationCopyCopy> findList(EcppStrformationCopyCopy ecppStrformationCopyCopy) {
		return super.findList(ecppStrformationCopyCopy);
	}
	
	public Page<EcppStrformationCopyCopy> findPage(Page<EcppStrformationCopyCopy> page, EcppStrformationCopyCopy ecppStrformationCopyCopy) {
		return super.findPage(page, ecppStrformationCopyCopy);
	}
	
	@Transactional(readOnly = false)
	public void save(EcppStrformationCopyCopy ecppStrformationCopyCopy) {
		super.save(ecppStrformationCopyCopy);
	}
	
	@Transactional(readOnly = false)
	public void delete(EcppStrformationCopyCopy ecppStrformationCopyCopy) {
		super.delete(ecppStrformationCopyCopy);
	}
	
}