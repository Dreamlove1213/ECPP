/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import com.thinkgem.jeesite.modules.ecpp.dao.*;
import com.thinkgem.jeesite.modules.ecpp.entity.*;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Dict;

/**
 * 管理提升 计划改进项Service
 *
 * @author zxt
 * @version 2018-03-21
 */
@Service
@Transactional(readOnly = true)
public class PlaninformationService extends CrudService<PlaninformationDao, Planinformation> {

    @Autowired
    private ImprovementsDao improvementsDao;

    /**
     * 改进项进度记录DAO接口
     */
    @Autowired
    private ProgressrecordDao progressrecordDao;

    /**
     * 提升情况信息及小组建议DAO接口
     */
    @Autowired
    private ResultrecordDao resultrecordDao;

    @Autowired
    private PlaninformationDao planinformationDao;
    @Autowired
    private StatisticsDao statisticsDao;

    @Autowired
    private OfficeDao officeDao;
    @Autowired
    private InformationDao informationDao;


    public Planinformation get(String id) {
        Planinformation planinformation = super.get(id);
        planinformation.setImprovementsList(improvementsDao.findList(new Improvements(planinformation)));
        return planinformation;
    }

    public List<Planinformation> findList(Planinformation planinformation) {
        return super.findList(planinformation);
    }

    public List<Planinformation> findList1(Planinformation planinformation) {
        return planinformationDao.findList1(planinformation);
    }

    /**
     * 获取目标数量和改进项数量
     *
     * @param
     * @return
     */
    public Planinformation coutPlanAndIm(Planinformation planinformation) {
        return planinformationDao.coutPlanAndIm(planinformation);
    }

    /**
     * 根据机构类型获取目标数量
     *
     * @param
     * @return
     */
    public Planinformation getPlanCount(Integer type) {
        return planinformationDao.getPlanCount(type);
    }

    public List<Planinformation> findListButShstatus(Planinformation planinformation) {
        return planinformationDao.findListButShstatus(planinformation);
    }

    /**
     * 根据企业进行分组
     *
     * @param planinformation
     * @return
     */
    public List<Planinformation> findListByqiyeGroupByUnit(Planinformation planinformation) {
        return planinformationDao.findListByqiyeGroupByUnit(planinformation);
    }

    public Integer countByType(Planinformation planinformation) {
        return planinformationDao.countByType(planinformation);
    }

    public List<Planinformation> findList2(Planinformation planinformation) {
        return planinformationDao.findList2(planinformation);
    }

    public List<Planinformation> findListBymbjd(Planinformation planinformation) {
        return planinformationDao.findListBymbjd(planinformation);
    }

    public List<Planinformation> findListByOrderOffice(Planinformation planinformation) {
        return planinformationDao.findListByOrderOffice(planinformation);
    }

    /**
     * 根据归属部门进行分组 （必须是已经提交的目标  status值为1）
     *
     * @param planinformation
     * @return
     */
    public List<Planinformation> findListByCompany(Planinformation planinformation) {
        return planinformationDao.findListByCompany(planinformation);
    }

    public Page<Planinformation> findPage(Page<Planinformation> page, Planinformation planinformation) {
        return super.findPage(page, planinformation);
    }

    public Page<Planinformation> findListtijiaotimenotnull(Page<Planinformation> page, Planinformation planinformation) {
        return super.findListtijiaotimenotnull(page, planinformation);
    }


    /**
     * 查询已经被删除的数据
     * @param page
     * @param planinformation
     * @return
     */
    public Page<Planinformation> findDeletePage(Page<Planinformation> page, Planinformation planinformation) {
        return super.findDeletePage(page, planinformation);
    }

    /**
     * 环节2 计划改进项保存
     *
     * @param planinformation
     */
    @Transactional(readOnly = false)
    public void save(Planinformation planinformation) {
        super.save(planinformation);
        for (Improvements improvements : planinformation.getImprovementsList()) {
            if (improvements.getId() == null) {
                continue;
            }
            if (Improvements.DEL_FLAG_NORMAL.equals(improvements.getDelFlag())) {
                improvements.setPlanid(planinformation);
                if (StringUtils.isBlank(improvements.getId())) {
                    improvements.preInsert();
                    improvements.setUnit(planinformation.getUnit());
                    improvements.setPlanType(planinformation.getPlantype());
                    improvementsDao.insert(improvements);
                } else {
                    improvements.preUpdate();
                    improvementsDao.update(improvements);
                }
            } else {
                improvementsDao.delete(improvements);
            }
        }
    }

    @Transactional(readOnly = false)
    public void delete(Planinformation planinformation) {
        super.delete(planinformation);
        improvementsDao.delete(new Improvements(planinformation));
    }


    @Transactional(readOnly = false)
    public void realDelete(Planinformation planinformation) {
        planinformationDao.realDelete(planinformation);
    }

    /**
     * 环节3 计划改进项保存  成果情况变更   改进项进度
     *
     * @param planinformation
     */
    @Transactional(readOnly = false)
    public void savePlanOptionChange(Planinformation planinformation) {
        Double sumProgress = 0.0, progress = 0.0;
        String changeId = IdGen.uuid();
        for (Improvements improvements : planinformation.getImprovementsList()) {
            if (improvements.getId() == null) {
                continue;
            }
            improvements.setPlanid(planinformation);
            improvements.preUpdate();
            improvements.setUnit(planinformation.getUnit());

//			改进项  -- 进度
            improvementsDao.update(improvements);
//			改进项进度1
            Progressrecord progressrecord = new Progressrecord();
            progressrecord.preInsert();
            progressrecord.setImprovedid(improvements.getId());        // 改进信息id
            progressrecord.setProgress(improvements.getImprovementprogress());        // 改进项进度
            progressrecord.setChangedate(new Date());        // 变更时间
            progressrecord.setUnit(planinformation.getUnit());
            progressrecord.setAttribute4(changeId);
            this.progressrecordDao.insert(progressrecord);
            Double a = 0.0;
            Double weight = 0.0;
            if (improvements.getWeight() == null || "".equals(improvements.getWeight())) {
                weight = 0.0;
            } else {
                weight = Double.valueOf(improvements.getWeight())/100;
            }
            if (improvements.getImprovementprogress() == null || "".equals(improvements.getImprovementprogress())) {
                a = 0.0;
            } else {
                a = improvements.getImprovementprogress();
            }
            sumProgress += a*weight;
        }
        progress = sumProgress;
        planinformation.setPlannedprogress(progress);
/*//			提升情况2
        if (planinformation.getGroupproposal().getOpinion() != null && !"".equals(planinformation.getGroupproposal().getOpinion())) {
            Resultrecord resultrecord = new Resultrecord();
            resultrecord.preInsert();
            resultrecord.setPlanid(planinformation.getId());        // 计划信息ID
//			-------成果、情况
            resultrecord.setReschangedate(new Date());        // 成果情况变更时间
            resultrecord.setSituationandresults(planinformation.getSituationandeffect());        // 提升情况及成果
            resultrecord.setStatus(Dict.PLAN_RES);        // 变更信息状态
            resultrecord.setUnit(planinformation.getUnit());        // 单位
            resultrecord.setAttribute4(changeId);
            this.resultrecordDao.insert(resultrecord);
        }*/

        super.save(planinformation);
    }

    /**
     * 环节3 计划改进项保存  组意见变更
     *
     * @param planinformation
     */
    @Transactional(readOnly = false)
    public void savePlanSugChange(Planinformation planinformation) {
        Resultrecord resultrecord = planinformation.getGroupproposal();
        resultrecord.setPlanid(planinformation.getId());
        resultrecord.setOpinionchangedate(new Date());        // 小组意见变更时间
        resultrecord.setStatus(Dict.PLAN_SUG);        // 变更信息状态
        resultrecord.preInsert();
        if (planinformation.getGroupproposal().getOpinion() != null && !"".equals(planinformation.getGroupproposal().getOpinion())) {
            resultrecord.setOpinion(planinformation.getGroupproposal().getOpinion() + "--" + UserUtils.getUser().getName());        // 改革小组意见
            Office u = new Office();
            u.setId(planinformation.getUnit().getId());
            resultrecord.setUnit(u);
            this.resultrecordDao.insert(resultrecord);
            planinformation.setGroupproposal(resultrecord);
        }
        super.save(planinformation);
    }

    /**
     * 环节4计划信息保存
     *
     * @param planinformation
     */
    @Transactional(readOnly = false)
    public void savePlan(Planinformation planinformation) {

        Double sunScore = 0.0;
        for (Improvements improvements : planinformation.getImprovementsList()) {
            if (improvements.getId() == null) {
                continue;
            }
            improvements.setPlanid(planinformation);
            improvements.preUpdate();
            improvements.setUnit(planinformation.getUnit());
            Double temp = 0.0;
            improvementsDao.update(improvements);
            if (improvements.getScore() != null && !"".equals(improvements.getScore())) {
                temp = improvements.getScore();
            }
            sunScore += (Double.valueOf(improvements.getWeight()) / 100) * temp;
        }
        planinformation.setSelfevaluationscore(sunScore);
        super.save(planinformation);
        this.averageScore(planinformation);
    }

    public void averageScore(Planinformation planinformation) {
        String officeId = planinformation.getUnit().getId();
        Planinformation p = new Planinformation();
        p.setShstatus("1");    //查询当前单位下的通过审核的
        p.setStatus("1");        //查询当前单位下的已经提交的
        Office o = new Office();
        o.setId(officeId);
        o.setType(planinformation.getUnit().getType());
        p.setUnit(o);
        List<Planinformation> planinformationList = planinformationDao.findList(p);
        //循环计算出平均分
        Double sum = 0.0;
        if (planinformationList.size() != 0) {
            for (int i = 0; i < planinformationList.size(); i++) {
                if (planinformationList.get(i).getSelfevaluationscore() != null && !"".equals(planinformationList.get(i).getSelfevaluationscore())) {
                    sum += planinformationList.get(i).getSelfevaluationscore();
                } else {
                    sum += 0;
                }
            }
        }
        if (planinformationList.size() != 0) {
            //循环保存平均分
            Double averageScore = sum / planinformationList.size();
            for (int i = 0; i < planinformationList.size(); i++) {
                Planinformation p1 = planinformationList.get(i);
                p1.setAveragescore(averageScore);
                super.save(p1);
            }
        }
    }

    /**
     * 更新该单位的统计信息
     * @param planinformation
     */
    @Transactional(readOnly = false)
    public void updateData(Planinformation planinformation){
        Statistics statistics = new Statistics();
        statistics = statisticsDao.getOneResult(planinformation.getUnit().getId());

        //----------------------------------------


        //(mbTotal / quanTotal
        //目标实际进度  =  目标改进项*权重->和/权重之和
        //目标计划进度  =  (（时间比值/改进项权重）+..)/权重之和
        Double quanTotal = 0.0;                                //权重之和
        Double quanTotalD = 0.0;                                //权重之和
        Double fenziTotal = 0.0;                                //分子之和		//目标计划进度
        Double Total = 0.0;                                //目标改进项*权重->和		//目标计划进度

        //当前日期
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date nowDate = new Date();

        //时间节点    	 从环节设置中获取
        Date datenode = null;

        //固定时间   	7月1日(获取第二阶段时间的下一天)
        Date date1 = null;

        Double cz = 0.0;    //时间差比值

        try {
            date1 = df.parse("2018-07-01 00:00:00");
            //datenode = df.parse("2018-05-31 00:00:00");
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        quanTotal = (double) ((improvementsDao.getSumByUnitId(planinformation.getUnit().getId())) / 100);    //权重之和
        Total = ((improvementsDao.getSumqgByUnitId(planinformation.getUnit().getId())) / 100 )/ 100;    //目标改进项*权重->和

        //获取当前单位的目标数量
        Planinformation p = new Planinformation();
        Office op = new Office();
        //修改此处获取office id 进行循环更新统计数据
        op.setId(planinformation.getUnit().getId());
        op.setType(null);
        p.setUnit(op);
        p.setDelFlag("0");
        p.setStatus("1");
        List<Planinformation> plist =  planinformationDao.findList(p);
        List<Improvements> ImprovementsList = improvementsDao.getListByUnitId(planinformation.getUnit().getId());
        for (int j = 0; j < ImprovementsList.size(); j++) {                //目标改进项列表
            //目标计划进度
            String weightVal = ImprovementsList.get(j).getWeight();
            Date nodeDate = ImprovementsList.get(j).getFinishtime();    //获取时间节点	（改进项中的完成时间）

            Integer chazhi = (int) ((nowDate.getTime() - nodeDate.getTime()) / (1000 * 60 * 60 * 24));    //当前时间-时间节点    大于0   比值为1
            Integer chazhi1 = (int) ((nowDate.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));     //当前时间-7月1号    小于0   比值为0

            Double days1 = (double) ((nowDate.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));        //分子差
            Double days2 = (double) ((nodeDate.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));        //分母差

            if (chazhi > 0) {
                cz = 1.0;
            } else if (chazhi1 < 0) {
                cz = 0.0;
            } else {
                cz = days1 / days2;
            }
            fenziTotal += cz * (Double.valueOf(weightVal) / 100);            //分子之和(权重)
        }

        //目标计划进度
        Integer a =Integer.valueOf((int) ((fenziTotal / quanTotal) * 100));
        //目标实际进度
        Integer b = Integer.valueOf((int) ((Total / quanTotal) * 100));
        statistics.setMuprogress(a);  //目标计划进度
        statistics.setSjprogress(b);  //目标计划进度
        statistics.setMunum(plist.size());  //目标数量
        statistics.setGjxnum(ImprovementsList.size()); //改进项数量
        statisticsDao.updateSta(statistics);

    }


    @Transactional(readOnly = false)
    public void autoRunUpdateData(){
        List<Office> offlist = officeDao.findList(new Office());
        String officeNotRootNode = DictUtils.OFFICENOT_ROOTNODE;    //office的根节点
        for (Office o: offlist) {
            if(!officeNotRootNode.equals(o.getId())){
                this.updateIndexData(o.getId());
            }
        }
    }

    /**
     * 更新首页统计数据方法  每天只触发一次
     * @param officeId
     */
    @Transactional(readOnly = false)
    public void updateIndexData(String officeId){
        Statistics statistics = new Statistics();
        statistics = statisticsDao.getOneResult(officeId);

        Office officeTemp = officeDao.getOne(officeId);     //更新office中的板块信息

        //----------------------------------------

        //(mbTotal / quanTotal
        //目标实际进度  =  目标改进项*权重->和/权重之和
        //目标计划进度  =  (（时间比值/改进项权重）+..)/权重之和
        Double quanTotal = 0.0;                                //权重之和
        Double quanTotalD = 0.0;                                //权重之和
        Double fenziTotal = 0.0;                                //分子之和		//目标计划进度
        Double Total = 0.0;                                //目标改进项*权重->和		//目标计划进度

        //当前日期
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date nowDate = new Date();

        //时间节点    	 从环节设置中获取
        Date datenode = null;

        //固定时间   	7月1日(获取第二阶段时间的下一天)
        Date date1 = null;

        Double cz = 0.0;    //时间差比值

        try {
            date1 = df.parse("2018-07-01 00:00:00");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        quanTotal = (double) ((improvementsDao.getSumByUnitId(officeId)) / 100);    //权重之和
        Total = ((improvementsDao.getSumqgByUnitId(officeId)) / 100 )/ 100;    //目标改进项*权重->和

        //获取当前单位的目标数量
        Planinformation p = new Planinformation();
        Office op = new Office();
        //修改此处获取office id 进行循环更新统计数据
        op.setId(officeId);
        op.setType(null);
        p.setUnit(op);
        p.setDelFlag("0");
        p.setStatus("1");
        List<Planinformation> plist =  planinformationDao.findList(p);
        List<Improvements> ImprovementsList = improvementsDao.getListByUnitId(officeId);
        for (int j = 0; j < ImprovementsList.size(); j++) {                //目标改进项列表
            //目标计划进度
            String weightVal = ImprovementsList.get(j).getWeight();
            Date nodeDate = ImprovementsList.get(j).getFinishtime();    //获取时间节点	（改进项中的完成时间）

            Integer chazhi = (int) ((nowDate.getTime() - nodeDate.getTime()) / (1000 * 60 * 60 * 24));    //当前时间-时间节点    大于0   比值为1
            Integer chazhi1 = (int) ((nowDate.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));     //当前时间-7月1号    小于0   比值为0

            Double days1 = (double) ((nowDate.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));        //分子差
            Double days2 = (double) ((nodeDate.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));        //分母差

            if (chazhi > 0) {
                cz = 1.0;
            } else if (chazhi1 < 0) {
                cz = 0.0;
            } else {
                cz = days1 / days2;
            }
            fenziTotal += cz * (Double.valueOf(weightVal) / 100);            //分子之和(权重)
        }

        /**
         * 1: 基础类
         * 2：改善类
         * 3：执行类
         * 4：突破类
         */
        Integer type1_num = planinformationDao.getCountByPlantype(officeId,DictUtils.PLAN_TYPE1);
        Integer type2_num = planinformationDao.getCountByPlantype(officeId,DictUtils.PLAN_TYPE2);
        Integer type3_num = planinformationDao.getCountByPlantype(officeId,DictUtils.PLAN_TYPE3);
        Integer type4_num = planinformationDao.getCountByPlantype(officeId,DictUtils.PLAN_TYPE4);

        Integer gjxtype1_num = improvementsDao.getCoutByOfficeIdAndPlanType(officeId,DictUtils.PLAN_TYPE1);
        Integer gjxtype2_num = improvementsDao.getCoutByOfficeIdAndPlanType(officeId,DictUtils.PLAN_TYPE2);
        Integer gjxtype3_num = improvementsDao.getCoutByOfficeIdAndPlanType(officeId,DictUtils.PLAN_TYPE3);
        Integer gjxtype4_num = improvementsDao.getCoutByOfficeIdAndPlanType(officeId,DictUtils.PLAN_TYPE4);


        //目标计划进度
        Integer a =Integer.valueOf((int) ((fenziTotal / quanTotal) * 100));
        //目标实际进度
        Integer b = Integer.valueOf((int) ((Total / quanTotal) * 100));
        statistics.setMbtype1(type1_num);  //目标 基础类
        statistics.setMbtype2(type2_num);  //目标 改善类
        statistics.setMbtype3(type3_num);  //目标 执行类
        statistics.setMbtype4(type4_num);  //目标 突破类

        statistics.setGjxtype1(gjxtype1_num);  //改进项 基础类
        statistics.setGjxtype2(gjxtype2_num);  //改进项 改善类
        statistics.setGjxtype3(gjxtype3_num);  //改进项 基础类
        statistics.setGjxtype4(gjxtype4_num);  //改进项 突破类

        statistics.setMuprogress(a);  //目标计划进度
        statistics.setSjprogress(b);  //目标计划进度
        statistics.setMunum(plist.size());  //目标数量
        statistics.setGjxnum(ImprovementsList.size()); //改进项数量
        statistics.setPlantype(officeTemp.getPlate());
        statisticsDao.updateSta(statistics);

    }

    public Planinformation returnUrlString(Planinformation planinformation){
     /*   按类型 plantype
        按部门  unit.id      unit.type
        按公司  unit.id      unit.type
        按板块 unit.type   unit.plate*/
     if (planinformation != null){
         if(planinformation.getPlantype() != null && !"".equals(planinformation.getPlantype())){
             planinformation.setUrlParmeter("plantype");
             return planinformation;
         }
         if (planinformation.getUnit() != null){
             if (StringUtils.isNotBlank(planinformation.getUnit().getId()) && StringUtils.isNotBlank(planinformation.getUnit().getType())){
                 planinformation.setUrlParmeter("type");
                 return planinformation;

             }
             if (StringUtils.isNotBlank(planinformation.getUnit().getPlate()) && StringUtils.isNotBlank(planinformation.getUnit().getType())){
                 planinformation.setUrlParmeter("plate");
                 return planinformation;

             }

         }
     }
     return planinformation;
    }

    /**
     * 返回月报数据
     * @return
     */
    public List<Information> getMonthReport(){
        return informationDao.getMonthReportNum();
    }


    /**
     * 用户查看过改革小组的建议后，该条通知消失
     * @param planinformation
     */
    @Transactional(readOnly = false)
    public void updateResultRecord(Planinformation planinformation){
        Resultrecord resultrecord = new Resultrecord();
        resultrecord.setStatus("2");
        resultrecord.setPlanid(planinformation.getId());
        List<Resultrecord> resultrecordslist = resultrecordDao.findList(resultrecord);
        for (Resultrecord r : resultrecordslist){
            r.setStatus("1");
            resultrecordDao.update(r);
        }
    }


}