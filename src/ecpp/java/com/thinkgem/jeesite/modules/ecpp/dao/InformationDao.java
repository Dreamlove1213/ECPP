/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ecpp.entity.Information;

/**
 * 管理提升信息表DAO接口
 * @author zxt
 * @version 2018-03-21
 */
@MyBatisDao
public interface InformationDao extends CrudDao<Information> {
	public List<Information> findList2(Information entity);
	public List<Information> findList3(Information entity);
	public List<Information> findList4(Information entity);
	public List<Information> findList5(Information entity);

    /**
     * 获取月报展示需要的数据
     * @return
     */
	public List<Information> getMonthReportNum();
}