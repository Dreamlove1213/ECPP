/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.config.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.config.entity.EcppConfig;

/**
 * 管理提升控制信息DAO接口
 * @author zxt
 * @version 2018-03-21
 */
@MyBatisDao
public interface EcppConfigDao extends CrudDao<EcppConfig> {
	
}