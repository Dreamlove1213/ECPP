/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.selfevluate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.selfevluate.entity.Selfevluate;
import com.thinkgem.jeesite.modules.selfevluate.dao.SelfevluateDao;

/**
 * 自评报告Service
 * @author zxt
 * @version 2018-06-18
 */
@Service
@Transactional(readOnly = true)
public class SelfevluateService extends CrudService<SelfevluateDao, Selfevluate> {

	public Selfevluate get(String id) {
		return super.get(id);
	}

	public Selfevluate getByUnitId(String unitId) {
		return this.dao.getByUnitId(unitId);
	}
	
	public List<Selfevluate> findList(Selfevluate selfevluate) {
		return super.findList(selfevluate);
	}
	
	public Page<Selfevluate> findPage(Page<Selfevluate> page, Selfevluate selfevluate) {
		return super.findPage(page, selfevluate);
	}
	
	@Transactional(readOnly = false)
	public void save(Selfevluate selfevluate) {
		super.save(selfevluate);
	}
	
	@Transactional(readOnly = false)
	public void delete(Selfevluate selfevluate) {
		super.delete(selfevluate);
	}

	@Transactional(readOnly = false)
	public void deleteByUnit(String UnitId) {
		this.dao.deleteByUnit(UnitId);
	}
	
}