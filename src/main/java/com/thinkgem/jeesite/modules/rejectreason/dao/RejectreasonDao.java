/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rejectreason.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.rejectreason.entity.Rejectreason;

/**
 * 目标驳回原因DAO接口
 * @author zxt
 * @version 2018-06-13
 */
@MyBatisDao
public interface RejectreasonDao extends CrudDao<Rejectreason> {
	public Rejectreason getByRejectreason(Rejectreason rejectreason);
	public void deleteByUnit(Rejectreason rejectreason);
}