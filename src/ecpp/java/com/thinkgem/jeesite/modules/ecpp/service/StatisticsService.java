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
import com.thinkgem.jeesite.modules.ecpp.entity.Statistics;
import com.thinkgem.jeesite.modules.ecpp.dao.StatisticsDao;

/**
 * 统计Service
 * @author zxy
 * @version 2018-07-18
 */
@Service
@Transactional(readOnly = true)
public class StatisticsService extends CrudService<StatisticsDao, Statistics> {

	@Autowired
	private StatisticsDao statisticsDao;

	public Statistics get(String id) {
		return super.get(id);
	}
	
	public List<Statistics> findList(Statistics statistics) {
		return super.findList(statistics);
	}

	public Integer getCountMbByOfficeAndBk(String officeType,String bk) {
		return statisticsDao.getCountMbByOfficeAndBk(officeType,bk);
	}

	public Integer getSumByOfficeType(String numname,String officeType) {
		return statisticsDao.getSumByOfficeType(numname,officeType);
	}

	public Integer getCountGjxByOfficeAndBk(String officeType,String bk) {
		return statisticsDao.getCountGjxByOfficeAndBk(officeType,bk);
	}

	public Integer getSumByPlantype(String planType) {
		return statisticsDao.getSumByPlantype(planType);
	}

	/**
	 * 根据实际进度和目标计划进度进行排序
	 * @param statistics
	 * @return
	 */
	public List<Statistics> findListOrderBymBAndJd(Statistics statistics) {
		return statisticsDao.findListOrderBymBAndJd(statistics);
	}

	/**
	 * 获取首页统计数据
	 * @return
	 */
	public List<Statistics> getstatisticsData() {
		return statisticsDao.getStatisticsData();
	}

	/**
	 * 获取首页统计数据  尝试对数据进行分页
	 * @return
	 */
	public List<Statistics> getstatisticsDataPage(Statistics statistics) {
		return statisticsDao.getStatisticsDataPage(statistics);
	}

	public Integer countByType(String type) {
		return statisticsDao.countByType(type);
	}
	
	public Page<Statistics> findPage(Page<Statistics> page, Statistics statistics) {
		return super.findPage(page, statistics);
	}
	
	@Transactional(readOnly = false)
	public void save(Statistics statistics) {
		super.save(statistics);
	}
	
	@Transactional(readOnly = false)
	public void delete(Statistics statistics) {
		super.delete(statistics);
	}
	
}