/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.selfevluate.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.selfevluate.entity.Selfevluate;

/**
 * 自评报告DAO接口
 * @author zxt
 * @version 2018-06-18
 */
@MyBatisDao
public interface SelfevluateDao extends CrudDao<Selfevluate> {
    public Selfevluate getByUnitId(String unitId);
    public void deleteByUnit(String unitId);

}