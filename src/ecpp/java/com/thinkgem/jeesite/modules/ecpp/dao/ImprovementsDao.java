/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ecpp.entity.Improvements;

/**
 * 管理提升 计划改进项DAO接口
 * @author zxt
 * @version 2018-03-21
 */
@MyBatisDao
public interface ImprovementsDao extends CrudDao<Improvements> {
	public Improvements getCount(Improvements improvements);
	public List<Improvements> getListByUnitId(@Param("unitId") String unitId);
	public List<Improvements> findByDeleteList(@Param("planId") String planId);
	public Integer getSumByUnitId(@Param("unitId") String unitId);
	public Double getSumqgByUnitId(@Param("unitId") String unitId);
	public Integer getImCout(@Param("type") String type);
	public void updataDelFlagStatus(@Param("planId") String planId);
	public Integer getCoutByOfficeIdAndPlanType(@Param("officeId") String officeId,@Param("type") String type);

	
}