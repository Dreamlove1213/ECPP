/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rejectreason.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.rejectreason.entity.Rejectreason;
import com.thinkgem.jeesite.modules.rejectreason.dao.RejectreasonDao;

/**
 * 目标驳回原因Service
 * @author zxt
 * @version 2018-06-13
 */
@Service
@Transactional(readOnly = true)
public class RejectreasonService extends CrudService<RejectreasonDao, Rejectreason> {
	@Autowired
	public RejectreasonDao rejectreasonDao;

	public Rejectreason get(String id) {
		return super.get(id);
	}
	public Rejectreason getByRejectreason(Rejectreason rejectreason) {
		return rejectreasonDao.getByRejectreason(rejectreason);
	}
	
	public List<Rejectreason> findList(Rejectreason rejectreason) {
		return super.findList(rejectreason);
	}
	
	public Page<Rejectreason> findPage(Page<Rejectreason> page, Rejectreason rejectreason) {
		return super.findPage(page, rejectreason);
	}
	
	@Transactional(readOnly = false)
	public void save(Rejectreason rejectreason) {
		super.save(rejectreason);
	}
	
	@Transactional(readOnly = false)
	public void delete(Rejectreason rejectreason) {
		super.delete(rejectreason);
	}

	@Transactional(readOnly = false)
	public void deleteByUnit(Rejectreason rejectreason) {
		rejectreasonDao.deleteByUnit(rejectreason);
	}
	
}