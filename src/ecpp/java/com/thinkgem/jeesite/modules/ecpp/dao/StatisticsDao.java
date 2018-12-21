/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ecpp.entity.Statistics;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import java.util.List;

/**
 * 统计DAO接口
 * @author zxy
 * @version 2018-07-18
 */
@MyBatisDao
public interface StatisticsDao extends CrudDao<Statistics> {
    public Statistics getOneResult(@Param("unitId") String unitId);
    public Integer countByType(@Param("type") String type);
    public List<Statistics> findListOrderBymBAndJd(Statistics statistics);

    /**
     * 获取首页统计数据
     * @return
     */
    public List<Statistics> getStatisticsData();

    /**
     * 获取首页统计数据
     * @return
     */
    public List<Statistics> getStatisticsDataPage(Statistics statistics);

    public void updateSta(Statistics statistics);
    public Integer getCountMbByOfficeAndBk(@Param("officeType") String officeType, @Param("bk") String bk);
    public Integer getCountGjxByOfficeAndBk(@Param("officeType") String officeType, @Param("bk") String bk);
    public Integer getSumByPlantype(@Param("planType") String planType);
    public Integer getSumByOfficeType(@Param("numname") String numname,@Param("officeType") String officeType);

}