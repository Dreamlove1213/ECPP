/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ecpp.entity.Planinformation;
import org.apache.ibatis.annotations.Param;

/**
 * 管理提升 计划改进项DAO接口
 * @author zxt
 * @version 2018-03-21
 */
@MyBatisDao
public interface PlaninformationDao extends CrudDao<Planinformation> {
	public List<Planinformation> findList1(Planinformation planinformation);
	public List<Planinformation> findList2(Planinformation planinformation);
	public List<Planinformation> findListByOrderOffice(Planinformation planinformation);
	public List<Planinformation> findListBymbjd(Planinformation planinformation);
	public Integer countByType(Planinformation planinformation);
	/**
	 * 根据归属部门进行分组   （必须是已经提交的目标  status值为1）
	 * @param planinformation
	 * @return
	 */
	public List<Planinformation> findListByCompany(Planinformation planinformation);
	
	/**
	 * 根据企业类型进行分组  首页
	 * @param planinformation
	 * @return
	 */
	public List<Planinformation> findListByqiyeGroupByUnit(Planinformation planinformation);

	/**
	 * 不查询已经通过的
	 * @param planinformation
	 * @return
	 */
	public List<Planinformation> findListButShstatus(Planinformation planinformation);

	/**
	 * 获取目标数量和改进项数量
	 * @param planinformation
	 * @return
	 */
	public Planinformation coutPlanAndIm(Planinformation planinformation);


	public Planinformation getPlanCount(@Param("type") Integer type);

	public Integer getCountByPlantype(@Param("officeId") String officeId,@Param("type") String type);

	/**
	 * 真正删除
	 * @param planinformation
	 */
	public void realDelete(Planinformation planinformation);

}