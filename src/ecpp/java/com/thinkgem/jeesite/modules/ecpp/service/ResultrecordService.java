/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.ecpp.entity.Resultrecord;
import com.thinkgem.jeesite.modules.ecpp.dao.ResultrecordDao;
import com.thinkgem.jeesite.modules.sys.entity.Dict;

/**
 * 提升情况信息及小组建议Service
 * @author zxt
 * @version 2018-03-22
 */
@Service
@Transactional(readOnly = true)
public class ResultrecordService extends CrudService<ResultrecordDao, Resultrecord> {

	@Autowired
	private ResultrecordDao resultrecordDao;

	public Resultrecord get(String id) {
		return super.get(id);
	}
	
	public List<Resultrecord> findList(Resultrecord resultrecord) {
		return super.findList(resultrecord);
	}

	public List<Resultrecord> findListGroupPlanId(Resultrecord resultrecord) {
		return resultrecordDao.findListGroupPlanId(resultrecord);
	}
	
	public Page<Resultrecord> findPage(Page<Resultrecord> page, Resultrecord resultrecord) {
		return super.findPage(page, resultrecord);
	}
	
	@Transactional(readOnly = false)
	public void save(Resultrecord resultrecord) {
		super.save(resultrecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(Resultrecord resultrecord) {
		super.delete(resultrecord);
	}
	
	public Resultrecord findRecord(Resultrecord resultrecord) {
		resultrecord.setStatus(Dict.PLAN_RES);
		List<Resultrecord> resultrecords = super.findList(resultrecord);
		if (resultrecords.size() > 0) {
			return resultrecords.get(0);
		}else {
			return new Resultrecord();
		}
		
	}
	
}