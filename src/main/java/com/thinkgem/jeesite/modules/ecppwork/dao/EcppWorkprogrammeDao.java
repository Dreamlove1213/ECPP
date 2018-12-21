/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecppwork.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogramme;

import java.util.List;

/**
 * 工作方案DAO接口
 * @author nan
 * @version 2018-03-29
 */
@MyBatisDao
public interface EcppWorkprogrammeDao extends CrudDao<EcppWorkprogramme> {
    public List<EcppWorkprogramme> findListByqiyeGroupByUnit(EcppWorkprogramme ecppWorkprogramme);
	
}