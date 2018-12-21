/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.ecpp.entity.Progressrecord;
import com.thinkgem.jeesite.modules.ecpp.dao.ProgressrecordDao;

/**
 * 改进项进度记录Service
 * @author zxt
 * @version 2018-03-22
 */
@Service
@Transactional(readOnly = true)
public class ProgressrecordService extends CrudService<ProgressrecordDao, Progressrecord> {

	public Progressrecord get(String id) {
		return super.get(id);
	}
	
	public List<Progressrecord> findList(Progressrecord progressrecord) {
		return super.findList(progressrecord);
	}
	
	public Page<Progressrecord> findPage(Page<Progressrecord> page, Progressrecord progressrecord) {
		return super.findPage(page, progressrecord);
	}
	
	@Transactional(readOnly = false)
	public void save(Progressrecord progressrecord) {
		super.save(progressrecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(Progressrecord progressrecord) {
		super.delete(progressrecord);
	}
	
}