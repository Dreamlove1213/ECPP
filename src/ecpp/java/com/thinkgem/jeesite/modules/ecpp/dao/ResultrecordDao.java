/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ecpp.entity.Resultrecord;

import java.util.List;

/**
 * 提升情况信息及小组建议DAO接口
 * @author zxt
 * @version 2018-03-22
 */
@MyBatisDao
public interface ResultrecordDao extends CrudDao<Resultrecord> {

    public List<Resultrecord> findListGroupPlanId(Resultrecord resultrecord);
	
}