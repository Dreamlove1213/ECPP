/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecpp.web;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.modules.ecpp.entity.*;
import com.thinkgem.jeesite.modules.ecpp.service.StatisticsService;
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogramme;
import com.thinkgem.jeesite.modules.ecppwork.service.EcppWorkprogrammeService;
import com.thinkgem.jeesite.modules.rejectreason.entity.Rejectreason;
import com.thinkgem.jeesite.modules.rejectreason.service.RejectreasonService;
import com.thinkgem.jeesite.modules.selfevluate.entity.Selfevluate;
import com.thinkgem.jeesite.modules.selfevluate.service.SelfevluateService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.config.entity.EcppConfig;
import com.thinkgem.jeesite.modules.config.service.EcppConfigService;
import com.thinkgem.jeesite.modules.ecpp.dao.ImprovementsDao;
import com.thinkgem.jeesite.modules.ecpp.service.PlaninformationService;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.ecpp.service.ResultrecordService;

/**
 * 管理提升 计划改进项Controller
 *
 * @author zxt
 * @version 2018-03-21
 */
@Controller
@RequestMapping(value = "${adminPath}/ecpp/planinformation")
public class PlaninformationController extends BaseController {

    @Autowired
    private PlaninformationService planinformationService;
    @Autowired
    private ResultrecordService resultrecordService;
    @Autowired
    private ImprovementsDao improvementsDao;
    @Autowired
    private EcppConfigService ecppConfigService;
    @Autowired
    private OfficeService officeservice;
    @Autowired
    private EcppWorkprogrammeService ecppWorkprogrammeService;
    @Autowired
    private RejectreasonService rejectreasonService;
    @Autowired
    private SelfevluateService selfevluateService;
    @Autowired
    private StatisticsService statisticsService;


    @ModelAttribute
    public Planinformation get(@RequestParam(required = false) String id) {
        Planinformation entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = planinformationService.get(id);
        }
        if (entity == null) {
            entity = new Planinformation();
        }
        return entity;
    }

    //	第二阶段
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u2List"})
    public String u2List(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Office office = UserUtils.getUser().getOffice();
        Office office1 = new Office();
        office1.setId(office.getId());
        office1.setType(null);
        planinformation.setUnit(office1);
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);
        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plan : planinformationlist) {
            if (plan != null) {
                Planinformation plans = planinformationService.get(plan.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plan.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }
        Rejectreason rejectreason = new Rejectreason();
        if (planinformation != null && planinformation.getUnit() != null && planinformation.getUnit().getId() != null && !"".equals(planinformation.getUnit().getId())) {
            rejectreason.setUnit(planinformation.getUnit());
            rejectreason = rejectreasonService.getByRejectreason(rejectreason);
            model.addAttribute("rejectreason", rejectreason);
        }
        planinformation.setShstatus("2");
        List<Planinformation> bohuiList = planinformationService.findList(planinformation);
        if (bohuiList.size() != 0) {
            model.addAttribute("isEmpty", "1");
        } else {
            model.addAttribute("isEmpty", "0");
        }

        model.addAttribute("page", page);
        return "modules/ecpp/part2/planinformationList";
    }


    //	第二阶段
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u2allUp"})
    public String u2allUp(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Office office = UserUtils.getUser().getOffice();
        Office office1 = new Office();
        office1.setId(office.getId());
        office1.setType(null);
        planinformation.setUnit(office1);
        planinformation.setShstatus("1");            //不查询已经通过的

        Map<String, String> map = new HashMap<String, String>();

        List<Planinformation> planinformationlist = planinformationService.findListButShstatus(planinformation);
        //删除驳回原因
        Rejectreason r = new Rejectreason();
        r.setUnit(planinformation.getUnit());
        rejectreasonService.deleteByUnit(r);


        //判断是否可以填报
        EcppConfig ecppConfig = ecppConfigService.get("089073542a8e4cc28ed44a1afc14e6f3");
        Date now = new Date();
        if (now.after(ecppConfig.getSecondenddate())) {
            map.put("dataStatus", "1");
            map.put("message", "已过填报时间！");
            return renderString(response, map);        //返回“1”，标识提交成功
        }
        if ("0".equals(ecppConfig.getSecondisstart())) {
            map.put("dataStatus", "2");
            map.put("message", "填报已关闭！");
            return renderString(response, map);        //返回“1”，标识提交成功
        }


        if (planinformationlist.size() != 0) {
            for (int i = 0; i < planinformationlist.size(); i++) {
                Planinformation p = planinformationlist.get(i);
                p.setTijiaotime(new Date());
                p.setStatus("1");
                p.setShstatus("0");        //信息提交后，初始化为“待处理”
                planinformationService.save(p);
            }
            map.put("dataStatus", "3");
            map.put("message", "提交成功！");
            return renderString(response, map);        //返回“1”，标识提交成功
        } else {
            map.put("dataStatus", "4");
            map.put("message", "当前没有需要提交的数据！！");
            return renderString(response, map);        //返回“0”，标识提交失败
        }
    }

    /**
     * 第二环节  管理员 统一通过
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"plan2Pass"})
    public String plan2Pass(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        planinformation.setStatus("1");         //查询已经提交的
        planinformation.setShstatus("0");      //查询待处理的

        List<Planinformation> planinformationlist = planinformationService.findList(planinformation);
        if (planinformationlist.size() != 0) {
            for (int i = 0; i < planinformationlist.size(); i++) {
                Planinformation p = planinformationlist.get(i);
                p.setTijiaotime(new Date());
                p.setStatus("1");
                p.setShstatus("1");        //信息通过后，将状态修改为“已通过”
                planinformationService.save(p);
            }
            return renderString(response, "1");        //返回“1”，标识通过成功
        } else {
            return renderString(response, "0");        //返回“0”，操作失败
        }
    }

    /**
     * 第二环节  管理员 统一驳回
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"plan2noPass"})
    public String plan2noPass(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        planinformation.setStatus("1");         //查询已经提交的
        planinformation.setShstatus("0");      //查询待处理的

        List<Planinformation> planinformationlist = planinformationService.findList(planinformation);
        if (planinformationlist.size() != 0) {
            for (int i = 0; i < planinformationlist.size(); i++) {
                Planinformation p = planinformationlist.get(i);
                p.setTijiaotime(new Date());
                p.setStatus("1");
                p.setShstatus("2");        //信息驳回后，将状态修改为“已驳回”
                planinformationService.save(p);
            }
            return renderString(response, "1");        //返回“1”，标识驳回成功
        } else {
            return renderString(response, "0");        //返回“0”，操作失败
        }
    }

    /**
     * 第二环节  管理员 统一驳回 驳回前检查是否有数据
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"checkIsData"})
    public String checkIsData(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        planinformation.setStatus("1");         //查询已经提交的
        planinformation.setShstatus("0");      //查询待处理的

        List<Planinformation> planinformationlist = planinformationService.findList(planinformation);
        if (planinformationlist.size() != 0) {
            return renderString(response, "1");        //返回“1”，表示有数据
        } else {
            return renderString(response, "0");        //返回“0”，表示没有需要驳回的数据
        }
    }

    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a2List"})
    public String a2List(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        //planinformation.setStatus("1");        //只查询已经提交的
        User u = UserUtils.getUser();
        if (u.getName() == "游客" || "游客".equals(u.getName())) {
            planinformation.setShstatus("1");    //只查询通过的
        }
        Page<Planinformation> page = planinformationService.findListtijiaotimenotnull(new Page<Planinformation>(request, response), planinformation);
        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plan : planinformationlist) {
            if (plan != null) {
                Planinformation plans = planinformationService.get(plan.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plan.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }
        Rejectreason rejectreason = new Rejectreason();
        if (planinformation != null && planinformation.getUnit() != null && planinformation.getUnit().getId() != null && !"".equals(planinformation.getUnit().getId())) {
            rejectreason.setUnit(planinformation.getUnit());
            rejectreason = rejectreasonService.getByRejectreason(rejectreason);
            model.addAttribute("rejectreason", rejectreason);

            model.addAttribute("type", planinformation.getUnit().getType());
        }

        model.addAttribute("officeId", planinformation.getUnit().getId());
        model.addAttribute("page", page);

        return "modules/ecpp/part2/planinformationa2List";    //planinformationList
    }


    /**
     * 第二环节归档信息列表
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a2List2"})
    public String a2List2(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        planinformation.setStatus("1");        //只查询已经提交的
        User u = UserUtils.getUser();
        planinformation.setShstatus("1");    //只查询通过的
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);

        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plan : planinformationlist) {
            if (plan != null) {
                plan.setSegment("一");
                Planinformation plans = planinformationService.get(plan.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plan.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }
        Rejectreason rejectreason = new Rejectreason();
        if (planinformation != null && planinformation.getUnit() != null && planinformation.getUnit().getId() != null && !"".equals(planinformation.getUnit().getId())) {
            rejectreason.setUnit(planinformation.getUnit());
            rejectreason = rejectreasonService.getByRejectreason(rejectreason);
            model.addAttribute("rejectreason", rejectreason);

            model.addAttribute("type", planinformation.getUnit().getType());
        }

        model.addAttribute("officeId", planinformation.getUnit().getId());
        model.addAttribute("page", page);

        return "modules/ecpp/part2/planinformationa2List2";    //planinformationList
    }

    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u2SubList"})
    public String u2SubList(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);
        model.addAttribute("page", page);
        return "modules/ecpp/part2/u2SubList";
    }

    @RequiresPermissions("ecpp:planin:edit")
    @RequestMapping(value = "u2Form")
    public String u2Form(Planinformation planinformation, Model model, RedirectAttributes redirectAttributes) {
        Map<String, String> map = ecppConfigService.isReport(2);
        if ("0".equals(map.get("isReport"))) {
            addMessage(redirectAttributes, map.get("msg"));
            return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u2List?repage";
        }

        model.addAttribute("saveStatus", planinformation.getSaveStatus());
        model.addAttribute("addSum", planinformation.getAddSum());
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part2/planinformationFormTest";
    }

    @RequiresPermissions("ecpp:planin:edit")
    @RequestMapping(value = "u2SubForm")
    public String u2SubForm(Planinformation planinformation, Model model) {
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part2/u2SubForm";
    }

    /**
     * 首页统计分析数据
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planin:view")
    @RequestMapping(value = "Analysisnew")
    public String Analysisnew(Planinformation planinformation, Model model,HttpServletResponse response) {
        Map<String, Integer> map = new HashMap<String, Integer>();

        Integer mbToatal = statisticsService.getSumByPlantype("munum");           //目标总数
        Integer gjxToatal = statisticsService.getSumByPlantype("gjxnum");         //改进项总数

        //3  二级单位	2 集团部门
        Integer mbNum1 = statisticsService.getSumByOfficeType("munum", "2");     //集团部门的目标数量
        Integer mbNum2 = statisticsService.getSumByOfficeType("munum", "3");     //二级单位的目标数量

        Integer gjxNum1 = statisticsService.getSumByOfficeType("gjxnum", "2");     //集团部门的改进项数量
        Integer gjxNum2 = statisticsService.getSumByOfficeType("gjxnum", "3");     //集团部门的改进项数量
        map.put("mbToatal", mbToatal);
        map.put("gjxToatal", gjxToatal);
        map.put("mbNum1", mbNum1);
        map.put("mbNum2", mbNum2);
        map.put("gjxNum1", gjxNum1);
        map.put("gjxNum2", gjxNum2);

        model.addAttribute("dataMap", map);
        return  renderString(response,map);

    }

    /**
     * 首页统计数据
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "getDataIndex")
    public String getDataIndex(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        //集团部门 2
        List<String> dwlistId = new ArrayList<String>();           //柱形统计图纵坐标公司名称 ID--
        List<String> dwlist = new ArrayList<String>();           //柱形统计图纵坐标公司名称 --
        List<Integer> mbjdlist = new ArrayList<Integer>();        //目标计划进度 --
        List<Integer> sjjdlist = new ArrayList<Integer>();        //目标实际进度 --

        //二级单位 3
        List<String> dwlistDId = new ArrayList<String>();           //柱形统计图纵坐标公司名称 ID--
        List<String> dwlistD = new ArrayList<String>();           //柱形统计图纵坐标公司名称 --
        List<Integer> mbjdlistD = new ArrayList<Integer>();        //目标计划进度 --
        List<Integer> sjjdlistD = new ArrayList<Integer>();        //目标实际进度 --
        List<Statistics> statisticsList = statisticsService.findListOrderBymBAndJd(new Statistics());
        for (Statistics s : statisticsList) {
            if ("2".equals(s.getOfficetype())) {
                dwlistId.add(s.getUnit().getId());
                dwlist.add(s.getOfficename());
                mbjdlist.add(s.getMuprogress());
                sjjdlist.add(s.getSjprogress());
            }
            if ("3".equals(s.getOfficetype())) {
                dwlistDId.add(s.getUnit().getId());
                dwlistD.add(s.getOfficename());
                mbjdlistD.add(s.getMuprogress());
                sjjdlistD.add(s.getSjprogress());
            }
        }

        map.put("dwlistId", dwlistId);
        map.put("dwlist", dwlist);
        map.put("mbjdlist", mbjdlist);
        map.put("sjjdlist", sjjdlist);

        map.put("dwlistDId", dwlistDId);
        map.put("dwlistD", dwlistD);
        map.put("mbjdlistD", mbjdlistD);
        map.put("sjjdlistD", sjjdlistD);
        return renderString(response, map);
    }


    @RequiresPermissions("ecpp:planin:edit")
    @RequestMapping(value = "u2Save")
    public String u2Save(Planinformation planinformation, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
        if (!beanValidator(model, planinformation)) {
            return u2Form(planinformation, model, redirectAttributes);
        }

        //判断是否满足填报要求
        Map<String, String> map = ecppConfigService.isReport(2);
        if ("0".equals(map.get("isReport"))) {
            addMessage(redirectAttributes, map.get("msg"));
            return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u2List?repage";
        }
        Double qz = 0.0;
        List<Improvements> improlist = planinformation.getImprovementsList();
        if (improlist != null) {
            for (Improvements impro : improlist) {
                if ("1".equals(impro.getDelFlag())) { //跳过已经删除的改进项
                    continue;
                }
                impro.setProgrcess("0");
                impro.setMoney2(0.00);
                impro.setMoney1(0.00);
                if (impro != null) {
                    String qzf = impro.getWeight();
                    try {
                        Double fqz = Double.valueOf(qzf);
                        qz = qz + fqz;
                    } catch (Exception e) {
                        // TODO: handle exception
                    }
                }
            }
        }
        if (qz != 100.0) {
            List<String> list = new ArrayList<String>();
            list.add(0, "权重和不等于100%，请重新输入！！！");
            addMessage(model, list.toArray(new String[]{}));
            planinformation.setAddSum("1");
            return newForm(planinformation, model);
        }
        planinformation.setUnit(UserUtils.getUser().getOffice());
        String sturts = planinformation.getSturts();

        List<String> list = new ArrayList<String>();
        if ("1".equals(sturts)) {
            list.add(0, "提交成功");
            planinformation.setStatus("1");
        } else {
            list.add(0, "保存成功");
            planinformation.setStatus("0");
            planinformation.setShstatus("3");   //第二阶段重新修改，将驳回状态修改为待处理
            //删除驳回原因
            Rejectreason r = new Rejectreason();
            r.setUnit(planinformation.getUnit());
            rejectreasonService.deleteByUnit(r);
        }
        planinformationService.save(planinformation);
        planinformation.setSaveStatus("1");

        addMessage(redirectAttributes, "保存成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u2List?repage";

    }

    @RequiresPermissions("ecpp:planin:view")
    @RequestMapping(value = "newForm")
    public String newForm(Planinformation planinformation, Model model) {
        model.addAttribute("planinformation", planinformation);
        model.addAttribute("saveStatus", planinformation.getSaveStatus());
        model.addAttribute("addSum", planinformation.getAddSum());
        return "modules/ecpp/part2/planinformationFormTest";
    }


    /**
     * 目标审核通过
     *
     * @param planinformation
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("ecpp:planin:view")
    @RequestMapping(value = "pass")
    public String pass(Planinformation planinformation, Model model, HttpServletRequest request, HttpServletResponse response) {
        planinformation.setShstatus("1");   //如果审核通过，则将审核状态置为1
        planinformationService.save(planinformation);
        return renderString(response, "1");
    }

    /**
     * 目标审核驳回
     *
     * @param planinformation
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("ecpp:planin:view")
    @RequestMapping(value = "noPass")
    public String noPass(Planinformation planinformation, Model model, HttpServletRequest request, HttpServletResponse response) {
        planinformation.setShstatus("2");   //如果审核驳回，则将审核状态置为2
        planinformationService.save(planinformation);
        return renderString(response, "1");
    }


    /**
     * 动态改变柱状图的数据
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planin:edit")
    @RequestMapping(value = "changeData")
    public String changeData(Planinformation planinformation, Model model, HttpServletRequest request, HttpServletResponse response) {
        String planType = "";        //初始化   	 类型 		 默认值为1 	    基础类
        if (planinformation.getPlantype() != null && !"".equals(planinformation.getPlantype())) {
            planType = planinformation.getPlantype();
        } else {
            planType = "1";
        }
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuffer intString = new StringBuffer();
        StringBuffer officeString = new StringBuffer();
        Planinformation planinformation5 = new Planinformation();
        planinformation5.setPlantype(planType);
        List<Planinformation> planinformation3List3 = planinformationService.findListByOrderOffice(planinformation5);
        for (int i = 0; i < planinformation3List3.size(); i++) {
            Planinformation planinformation3imp = new Planinformation();    //统计某一部门下    某一个具体类的改进项数量
            planinformation3imp = planinformation3List3.get(i);

            if (planinformation3imp.getUnit().getName() != null && !"".equals(planinformation3imp.getUnit().getName())) {
                officeString.append(planinformation3imp.getUnit().getName()).append(",");
            }
            Improvements improvements = new Improvements();
            improvements.setUnit(planinformation3imp.getUnit());
            improvements.setPlanType(planinformation3imp.getPlantype());
            Improvements improvementsl = new Improvements();

            improvementsl = this.improvementsDao.getCount(improvements);
            if (improvementsl.getNum() != null && !"".equals(improvementsl.getNum())) {
                Integer num = improvementsl.getNum();
                intString.append(num).append(",");
            } else {
                intString.append(0).append(",");
            }
        }
        intString = intString.deleteCharAt(intString.length() - 1);
        officeString = officeString.deleteCharAt(officeString.length() - 1);

        map.put("intArray", intString);
        map.put("officeArray", officeString);

        return renderString(response, map);
    }

    @RequiresPermissions("ecpp:planin:edit")
    @RequestMapping(value = "delete")
    public String delete(Planinformation planinformation, RedirectAttributes redirectAttributes) {
        planinformationService.delete(planinformation);
        addMessage(redirectAttributes, "删除计划改进项成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u2List?repage";
    }


    /**
     * 目标删除  删除的同时将第四环节提交的附件也一并删除
     *
     * @param planinformation
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("ecpp:planin:edit")
    @RequestMapping(value = "delete1")
    public String delete1(Planinformation planinformation, RedirectAttributes redirectAttributes) {
        planinformation.setUpdateBy(UserUtils.getUser());
        planinformation.setUpdateDate(new Date());
        planinformationService.delete(planinformation);
        Rejectreason r = new Rejectreason();
        r.setUnit(planinformation.getUnit());
        List<Rejectreason> rejectreasonsList = rejectreasonService.findList(r);
        if (rejectreasonsList.size() != 0) {
            for (int i = 0; i < rejectreasonsList.size(); i++) {
                rejectreasonService.delete(rejectreasonsList.get(i));
            }
        }
        //删除目标的同时删除第四阶段提交的自评报告
        selfevluateService.deleteByUnit(planinformation.getUnit().getId());
        addMessage(redirectAttributes, "删除目标成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/a2List?unit.id=" + planinformation.getUnit().getId() + "&unit.type=" + planinformation.getUnit().getType();
    }

    /**
     * 计划信息查看
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = "view")
    public String view(Planinformation planinformation, Model model) {
        String recordId = planinformation.getSituationandeffect();
        Resultrecord resultrecord = new Resultrecord();

        if (recordId != null && !"".equals(recordId)) {
            resultrecord = resultrecordService.get(recordId);
            model.addAttribute("resultrecord", resultrecord);
        }
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part2/planinformation";
    }

    /**
     * 管理员查看页面
     *
     * @param planinformation
     * @param ecppConfig
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = "a3View")
    public String a3View(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        String recordId = planinformation.getSituationandeffect();
        Resultrecord resultrecord = new Resultrecord();

        if (recordId != null && !"".equals(recordId)) {
            resultrecord = resultrecordService.get(recordId);
        }
        model.addAttribute("resultrecord", resultrecord);
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part3/planinformationa3";
    }

    /**
     * 游客查看页面
     *
     * @param planinformation
     * @param ecppConfig
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = "a3ViewCustomerLook")
    public String a3ViewCustomerLook(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        String recordId = planinformation.getSituationandeffect();
        Resultrecord resultrecord = new Resultrecord();

        if (recordId != null && !"".equals(recordId)) {
            resultrecord = resultrecordService.get(recordId);
        }
        /*   按类型 plantype
        按部门  unit.id      unit.type
        按公司  unit.id      unit.type
        按板块 unit.type   unit.plate*/
        if (planinformation != null) {
            if ("plantype".equals(planinformation.getUrlParmeter())) {
                model.addAttribute("Parmeter", planinformation.getUrlParmeter() + "=" + planinformation.getPlantype());
            }
            if ("type".equals(planinformation.getUrlParmeter())) {
                model.addAttribute("Parmeter", "unit.id=" + planinformation.getUnit().getId() + "&unit.type=" + planinformation.getUnit().getType());
            }
            if ("plate".equals(planinformation.getUrlParmeter())) {
                model.addAttribute("Parmeter", "unit.type=" + planinformation.getUnit().getType() + "&unit.plate=" + planinformation.getUnit().getPlate());
            }
        }
        model.addAttribute("resultrecord", resultrecord);
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part3/planinformationa3CustomLook";
    }

    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = "a3View1")
    public String a3View1(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        String recordId = planinformation.getSituationandeffect();
        Resultrecord resultrecord = new Resultrecord();

        if (recordId != null && !"".equals(recordId)) {
            resultrecord = resultrecordService.get(recordId);
        }
        model.addAttribute("resultrecord", resultrecord);
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        model.addAttribute("officeId", planinformation.getUnit().getId());
        return "modules/ecpp/part3/planinformationa3View1";
    }

    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = "a3View2")
    public String a3View2(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        String recordId = planinformation.getSituationandeffect();
        Resultrecord resultrecord = new Resultrecord();

        if (recordId != null && !"".equals(recordId)) {
            resultrecord = resultrecordService.get(recordId);
        }
        model.addAttribute("resultrecord", resultrecord);
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        model.addAttribute("officeId", planinformation.getUnit().getId());
        return "modules/ecpp/part3/planinformationa3View2";
    }


    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = "views")
    public String views(Planinformation planinformation, Model model) {
        String recordId = planinformation.getSituationandeffect();
        Resultrecord resultrecord = new Resultrecord();

        if (recordId != null && !"".equals(recordId)) {
            resultrecord = resultrecordService.get(recordId);
            model.addAttribute("resultrecord", resultrecord);
        }
        for (Improvements improvement : planinformation.getImprovementsList()) {
            improvement.setContent(StringUtils.abbr(improvement.getContent(), 30));
        }
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part2/planinformation1";
    }
    // 第三阶段

    /**
     * 计划列表
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u3List"})
    public String u3List(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Office office = UserUtils.getUser().getOffice();
        Office office1 = new Office();
        office1.setId(office.getId());
        office1.setType(null);
        if (planinformation.getUnit() != null && planinformation.getUnit().getPlate() != null && !"".equals(planinformation.getUnit().getPlate())) {
            office1.setPlate(planinformation.getUnit().getPlate());
        }
        //office1.setType(null);
        planinformation.setUnit(office1);
        planinformation.setStatus("1");        //只查询已经提交的
        planinformation.setShstatus("1");        //只查询已经审核通过的
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);
        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plan : planinformationlist) {
            if (plan != null) {
                Planinformation plans = planinformationService.get(plan.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plan.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }
        model.addAttribute("page", page);
        return "modules/ecpp/part3/planinformationList";
    }


    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u3View"})
    public String u3View(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Resultrecord resultrecordSel = new Resultrecord();
        resultrecordSel.setPlanid(planinformation.getId());
        List<Resultrecord> resultrecords = resultrecordService.findList(resultrecordSel);
        model.addAttribute("ecppConfig", ecppConfigService.findList(new EcppConfig()).get(0));
        model.addAttribute("resultrecords", resultrecords);
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part3/planinformationu3view";
    }

    /**
     * 3.1计划信息   改进项、提升情况及效果 修改
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "u3Form")
    public String u3Form(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        if (StringUtils.isNoneBlank(planinformation.getUrlParmeter())) {
            planinformationService.updateResultRecord(planinformation);
        }
        Resultrecord resultrecordSel = new Resultrecord();
        resultrecordSel.setPlanid(planinformation.getId());
        List<Resultrecord> resultrecords = resultrecordService.findList(resultrecordSel);
        model.addAttribute("resultrecords", resultrecords);

        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part3/planinformationFormTest";
    }

    /**
     * 3.1计划信息  改进项、提升情况及效果 保存
     *
     * @param planinformation
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "u3Save")
    public String u3Save(Planinformation planinformation, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, planinformation)) {
            return u3Form(planinformation, null, model);
        }

        //判断是否满足填报要求
        Map<String, String> map = ecppConfigService.isReport(3);
        if ("0".equals(map.get("isReport"))) {
            addMessage(redirectAttributes, map.get("msg"));
            return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u3List?repage";
        }

        String situationandeffect = planinformation.getSituationandeffect();//历史
        if (planinformation.getSituationandeffect() == null || "".equals(planinformation.getSituationandeffect())) {
            situationandeffect = "";
        }
        String tishengrizhi = planinformation.getTishengrizhi();//日志
        SimpleDateFormat df1 = new SimpleDateFormat("yyyy/MM/dd HH:mm");

        Date day = new Date();
        if (tishengrizhi != null && !"".equals(tishengrizhi)) {
            situationandeffect += "<p>" + tishengrizhi + " --" + df1.format(day) + "--" + UserUtils.getUser().getName() + "</p>";
            planinformation.setSituationandeffect(situationandeffect);
        }

        //提升日志   	tishengrizhi
        //提升历史		situationandeffect
        List<Improvements> improlist = planinformation.getImprovementsList();
        if (improlist != null) {
            for (Improvements impro : improlist) {
                if (impro != null) {
                    String lsgjcs = impro.getAttribute2();//历史
                    Double Improvementprogress = 0.0;
                    if (impro.getImprovementprogress() != null) {
                        impro.setProgrcess(String.valueOf(impro.getImprovementprogress() * 3));
                    } else {
                        impro.setProgrcess(String.valueOf(Improvementprogress * 3));
                    }

                    if (impro.getAttribute2() == null) {
                        lsgjcs = "";
                    }
                    String xdgjcs = impro.getAttribute6();//新加
                    if (xdgjcs != null && !"".equals(xdgjcs)) {

                        SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm");
                        String xdgjcss = "<p>" + xdgjcs + " -- " + df.format(day) + "--" + UserUtils.getUser().getName() + "</p>";
                        lsgjcs = lsgjcs + xdgjcss;
                        impro.setAttribute2(lsgjcs);
                        //Encodes.unescapeHtml("");
                    }
                }
            }
        }

        planinformation.setThreesement("1");
        planinformationService.savePlanOptionChange(planinformation);

        planinformationService.updateData(planinformation);//更新统计数据
        addMessage(redirectAttributes, "更新成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u3List?repage";
    }

    //	------
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a3List"})
    public String a3List(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {

        planinformation.setStatus("1");        //只查询已经提交的
        planinformation.setShstatus("1");        //只查询已经审核通过的
        planinformation.setThreesement("1");     //第三环节
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);

        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plan : planinformationlist) {
            if (plan != null) {
                Planinformation plans = planinformationService.get(plan.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plan.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }

        model.addAttribute("page", page);
        return "modules/ecpp/part3/auditPlaninformationList";
    }


    /**
     * 首页 四块 统计图数据穿透
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"a3ListIndexLook"})
    public String a3ListIndexLook(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {

        planinformation.setStatus("1");        //只查询已经提交的
        planinformation.setShstatus("1");        //只查询已经审核通过的
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);

        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plano : planinformationlist) {
            if (plano != null) {
                Planinformation plans = planinformationService.get(plano.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plano.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }
        planinformation = planinformationService.returnUrlString(planinformation);
        model.addAttribute("page", page);
        return "modules/ecpp/part3/indexLookpageByType";
    }

    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a3List1"})
    public String a3List1(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Office off1 = new Office();
        off1.setType("2");
        off1.setId(planinformation.getRemarks());        //部门的id暂时存在remarks字段中  只用于查询
        planinformation.setUnit(off1);
        planinformation.setStatus("1");     //仅查询已经提交的
        planinformation.setShstatus("1");     //仅查询已经审核通过的
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);

        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plan : planinformationlist) {
            if (plan != null) {
                Planinformation plans = planinformationService.get(plan.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plan.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }

        model.addAttribute("page", page);
        model.addAttribute("officeId", planinformation.getUnit().getId());
        return "modules/ecpp/part3/auditPlaninformationList1";
    }

    /**
     * 企业归档的展示列表
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a3List2"})
    public String a3List2(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        planinformation.setStatus("1");    //只查询已经提交的
        planinformation.setShstatus("1");    //只查询已经审核通过的
        planinformation.setThreesement("1");   //只查询已经归档的
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);

        List<Planinformation> planinformationlist = page.getList();
        for (Planinformation plan : planinformationlist) {
            if (plan != null) {
                Planinformation plans = planinformationService.get(plan.getId());
                if (plans != null) {
                    List<Improvements> improList = plans.getImprovementsList();
                    if (improList != null) {
                        int a = improList.size();
                        if (a > 0) {
                            Improvements impro = improList.get(a - 1);
                            if (impro != null) {
                                Date date = impro.getFinishtime();
                                if (date != null) {
                                    plan.setEndDate(date);
                                }
                            }
                        }
                    }
                }
            }
        }
        model.addAttribute("page", page);
        model.addAttribute("officeId", planinformation.getUnit().getId());
        model.addAttribute("type", planinformation.getUnit().getType());
        return "modules/ecpp/part3/auditPlaninformationList2";
    }

    /**
     * 部门归档下的工作计划列表
     *
     * @param ecppWorkprogramme
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a3ListWorkPlanCompany"})
    public String a3ListWorkPlanCompany(EcppWorkprogramme ecppWorkprogramme, HttpServletRequest request, HttpServletResponse response, Model model) {
        ecppWorkprogramme.setStatus("1");
        Page<EcppWorkprogramme> page = ecppWorkprogrammeService.findPage(new Page<EcppWorkprogramme>(request, response), ecppWorkprogramme);
        model.addAttribute("page", page);
        model.addAttribute("officeId", ecppWorkprogramme.getUnit().getId());
        return "modules/ecpp/part3/workPlanList1";
    }

    /**
     * 企业归档下的工作计划列表
     *
     * @param ecppWorkprogramme
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a3ListWorkPlan"})
    public String a3ListWorkPlan(EcppWorkprogramme ecppWorkprogramme, HttpServletRequest request, HttpServletResponse response, Model model) {
        ecppWorkprogramme.setStatus("1");
        Page<EcppWorkprogramme> page = ecppWorkprogrammeService.findPage(new Page<EcppWorkprogramme>(request, response), ecppWorkprogramme);
        model.addAttribute("page", page);
        model.addAttribute("officeId", ecppWorkprogramme.getUnit().getId());
        return "modules/ecpp/part3/workPlanList2";
    }

    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a2ListWorkPlan"})
    public String a2ListWorkPlan(EcppWorkprogramme ecppWorkprogramme, HttpServletRequest request, HttpServletResponse response, Model model) {
        ecppWorkprogramme.setStatus("1");
        Page<EcppWorkprogramme> page = ecppWorkprogrammeService.findPage(new Page<EcppWorkprogramme>(request, response), ecppWorkprogramme);
        model.addAttribute("page", page);
        model.addAttribute("officeId", ecppWorkprogramme.getUnit().getId());
        return "modules/ecpp/part2/workPlanList2";
    }

    /**
     * 第四环节    企业归档
     *
     * @param ecppWorkprogramme
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a4ListWorkPlan"})
    public String a4ListWorkPlan(EcppWorkprogramme ecppWorkprogramme, HttpServletRequest request, HttpServletResponse response, Model model) {
        ecppWorkprogramme.setStatus("1");
        Page<EcppWorkprogramme> page = ecppWorkprogrammeService.findPage(new Page<EcppWorkprogramme>(request, response), ecppWorkprogramme);
        model.addAttribute("page", page);
        model.addAttribute("officeId", ecppWorkprogramme.getUnit().getId());
        return "modules/ecpp/part4/workPlanList2";
    }

    /**
     * 3.2计划信息   改革小组建议  修改
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "a3Form")
    public String a3Form(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        Resultrecord resultrecordSel = new Resultrecord();
        resultrecordSel.setPlanid(planinformation.getId());
        List<Resultrecord> resultrecords = resultrecordService.findList(resultrecordSel);
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("resultrecords", resultrecords);
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part3/auditPlaninformationForm";
    }

    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = "a3Form1")
    public String a3Form1(Planinformation planinformation, Model model) {
        Resultrecord resultrecord = resultrecordService.get(planinformation.getSituationandeffect());
//		Resultrecord resultrecord = new Resultrecord();
//		resultrecord.setUnit(planinformation.getUnit());
//		resultrecord = resultrecordService.findRecord(resultrecord);
        planinformation.setRecord(resultrecord.getId());
//		planinformation.setSituationandeffect(resultrecord.getSituationandresults());
        model.addAttribute("resultrecord", resultrecord);
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part3/auditPlaninformationForm1";
    }

    /**
     * 3.2计划信息  改革小组建议 保存
     *
     * @param planinformation
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "a3Save")
    public String a3Save(Planinformation planinformation, Model model, RedirectAttributes redirectAttributes) {
        //判断是否满足填报要求
        Map<String, String> map = ecppConfigService.isReport(3);
        if ("0".equals(map.get("isReport"))) {
            addMessage(redirectAttributes, map.get("msg"));
            return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/a3List?unit.id=" + planinformation.getUnit().getId() + "&unit.type=" + planinformation.getUnit().getType();
        }
        planinformation.setThreesement("1");
        planinformationService.savePlanSugChange(planinformation);
        addMessage(redirectAttributes, "改革小组建议修改成功！");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/a3List?unit.id=" + planinformation.getUnit().getId() + "&unit.type=" + planinformation.getUnit().getType();
    }
//	第四阶段

    /**
     * 4.1
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u4List"})
    public String u4List(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Office office = UserUtils.getUser().getOffice();
        Office office1 = new Office();
        office1.setId(office.getId());
        office1.setType(null);
        planinformation.setUnit(office1);
        planinformation.setStatus("1");        //只查询已经提交的
        planinformation.setShstatus("1");        //只查询已经审核通过的
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);
        //自评报告
        Selfevluate selfevluate = new Selfevluate();
        selfevluate = selfevluateService.getByUnitId(planinformation.getUnit().getId());
        if (selfevluate == null) {
            Selfevluate selfevluateNew = new Selfevluate();
            model.addAttribute("selfevluate", selfevluateNew);
        } else {
            model.addAttribute("selfevluate", selfevluate);
        }

        if (page.getList().size() != 0) {
            model.addAttribute("sorceSvg", page.getList().get(0).getAveragescore());
        } else {
            model.addAttribute("sorceSvg", "0");
        }

        model.addAttribute("page", page);
        return "modules/ecpp/part4/planinformationList";
    }

    /**
     * 企业归档  查看列表
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a4List2"})
    public String a4List2(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        /*Office office = UserUtils.getUser().getOffice();
        Office office1 = new Office();
        office1.setId(office.getId());
        office1.setType(null);
        planinformation.setUnit(office1);*/
        planinformation.setStatus("1");        //只查询已经提交的
        planinformation.setShstatus("1");        //只查询已经审核通过的
        planinformation.setThreesement("1");        //查询第三环节已经归档的
        planinformation.setFoursegment("1");      //查询第四环节归档的
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);
        //自评报告
        Selfevluate selfevluate = new Selfevluate();
        selfevluate = selfevluateService.getByUnitId(planinformation.getUnit().getId());
        if (selfevluate == null) {
            Selfevluate selfevluateNew = new Selfevluate();
            model.addAttribute("selfevluate", selfevluateNew);
        } else {
            model.addAttribute("selfevluate", selfevluate);
        }

        model.addAttribute("page", page);
        return "modules/ecpp/part4/planinformationList4";
    }

    /**
     * 4.1计划信息   自我评价
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "u4Form")
    public String u4Form(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part4/planinformationForm";
    }

    /**
     * 4.1计划信息 自我评价 保存
     *
     * @param planinformation
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "u4Save")
    public String u4Save(Planinformation planinformation, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, planinformation)) {
            return u4Form(planinformation, null, model);
        }

        //判断是否满足填报要求
        Map<String, String> map = ecppConfigService.isReport(4);
        if ("0".equals(map.get("isReport"))) {
            addMessage(redirectAttributes, map.get("msg"));
            return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u4List?repage";
        }

        planinformation.setFoursegment("1");
        planinformationService.savePlan(planinformation);
        addMessage(redirectAttributes, "自我评价成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/u4List?repage";
    }

    /**
     * 4计划信息查看
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u4View"})
    public String u4View(Planinformation planinformation, Model model) {
        model.addAttribute("ecppConfig", ecppConfigService.findList(new EcppConfig()).get(0));
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part4/planinformation";
    }


    /**
     * 第四环节归档信息查看
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"FoursegmentView"})
    public String FoursegmentView(Planinformation planinformation, Model model) {
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part4/planinformationFoursegment";
    }

    /**
     * 4计划信息查看
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a4View"})
    public String a4View(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part4/planinformationa4";
    }

    /**
     * 2计划信息查看
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"u2View"})
    public String u2View(Planinformation planinformation, Model model) {
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part2/planinformationu2";
    }

    /**
     * 2计划信息查看
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a2View"})
    public String a2View(Planinformation planinformation, Model model) {
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part2/planinformationa2";
    }

    /**
     * 改革办小组 计划信息查看 带有审核功能
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a2ViewSh"})
    public String a2ViewSh(Planinformation planinformation, Model model) {
        model.addAttribute("planinformation", planinformation);
        model.addAttribute("officeId", planinformation.getUnit().getId());
        model.addAttribute("type", planinformation.getUnit().getType());
        return "modules/ecpp/part2/planinformationash";
    }

    /**
     * 4.1 管理计划列表
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"a4List"})
    public String a4List(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        planinformation.setStatus("1");        //只查询已经提交的
        planinformation.setShstatus("1");        //只查询已经审核通过的
        planinformation.setThreesement("1");
        planinformation.setFoursegment("1");
        Page<Planinformation> page = planinformationService.findPage(new Page<Planinformation>(request, response), planinformation);

        //自评报告
        Selfevluate selfevluate = new Selfevluate();
        selfevluate = selfevluateService.getByUnitId(planinformation.getUnit().getId());
        if (selfevluate == null) {
            Selfevluate selfevluateNew = new Selfevluate();
            model.addAttribute("selfevluate", selfevluateNew);
        } else {
            model.addAttribute("selfevluate", selfevluate);
        }

        if (page.getList().size() != 0) {
            model.addAttribute("sorceSvg", page.getList().get(0).getAveragescore());
        } else {
            model.addAttribute("sorceSvg", "0");
        }

        model.addAttribute("page", page);
        return "modules/ecpp/part4/auditPlaninformationList";
    }

    /**
     * 4.1计划信息   组织评价
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "a4Form")
    public String a4Form(Planinformation planinformation, EcppConfig ecppConfig, Model model) {
        model.addAttribute("ecppConfig", ecppConfigService.findList(ecppConfig).get(0));
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/part4/auditPlaninformationForm";
    }

    /**
     * 4.1计划信息  组织评价 保存
     *
     * @param planinformation
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "a4Save")
    public String a4Save(Planinformation planinformation, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, planinformation)) {
            return a4Form(planinformation, null, model);
        }
        //判断是否满足填报要求
        Map<String, String> map = ecppConfigService.isReport(4);
        if ("0".equals(map.get("isReport"))) {
            Office o = officeservice.getOne(planinformation.getUnit().getId());
            addMessage(redirectAttributes, map.get("msg"));
            return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/a4List?unit.id=" + planinformation.getUnit().getId() + "&unit.type=" + o.getType();
        }

        String sturts = planinformation.getSturts();

        if (sturts == null || "0".equals(sturts)) {
            planinformation.setAttribute11("0");
        } else {
            planinformation.setAttribute11("1");
        }
        planinformation.setFoursegment("1");
        if (planinformation.getEvaluationscore() == null || "".equals(planinformation.getEvaluationscore())) {
            planinformation.setEvaluationscore("0");
        }
        planinformationService.savePlan(planinformation);
        if ("1".equals(sturts)) {
            addMessage(redirectAttributes, "提交成功");
        } else {
            addMessage(redirectAttributes, "保存成功");
        }
        Office o = officeservice.getOne(planinformation.getUnit().getId());
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/a4List?unit.id=" + planinformation.getUnit().getId() + "&unit.type=" + o.getType();
    }
    //----  改进项内容查看

    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = "contentForm")
    public String contentForm(Planinformation planinformation, Model model, @RequestParam(required = false) String itemid) {
        Improvements improvements = this.improvementsDao.get(itemid);
        model.addAttribute("improvements", improvements);
        return "modules/ecpp/improvementsForm";
    }

    /**
     * 月报展示
     *
     * @param planinformation
     * @param model
     * @param
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "monthReport")
    public String monthReport(Planinformation planinformation, Model model) {
        Map<String, Integer> map = new HashMap<String, Integer>();
        List<Information> list = planinformationService.getMonthReport();
        try {
            map.put("fileNum", list.get(0).getMonthReportNum());      //文件数量
            map.put("zeRenNum", list.get(1).getMonthReportNum());    //责任人
            map.put("fuZenNum", list.get(2).getMonthReportNum());      //负责人
        } catch (Exception e) {
            map.put("fileNum", 0);      //文件数量
            map.put("zeRenNum", 0);     //责任人
            map.put("fuZenNum", 0);      //负责人
        }
        model.addAttribute("dataMap", map);
        return "modules/ecpp/monthReport";
    }

    /**
     * 查看已经删除的目标列表
     *
     * @param planinformation
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"deletePlanList"})
    public String deletePlanList(Planinformation planinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Planinformation> page = planinformationService.findDeletePage(new Page<Planinformation>(request, response), planinformation);
        model.addAttribute("page", page);
        return "modules/ecpp/planinformationDeleteList";
    }


    /**
     * 已经删除目标查看
     *
     * @param planinformation
     * @param model
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:view")
    @RequestMapping(value = {"deleteView"})
    public String deleteView(Planinformation planinformation, Model model) {
        model.addAttribute("planinformation", planinformation);
        return "modules/ecpp/planinformationDeleteView";
    }


    /**
     * 此方法为真正的删除，不是逻辑删除
     *
     * @param planinformation
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = {"reallyDelete"})
    public String reallyDelete(Planinformation planinformation, RedirectAttributes redirectAttributes) {
        planinformationService.realDelete(planinformation);
        addMessage(redirectAttributes, "删除目标成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/deletePlanList";
    }

    /**
     * 目标还原方法
     *
     * @param planinformation
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("ecpp:planinformation:edit")
    @RequestMapping(value = {"revertPlan"})
    public String revertPlan(Planinformation planinformation, RedirectAttributes redirectAttributes) {
        planinformation.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
        improvementsDao.updataDelFlagStatus(planinformation.getId());
        planinformationService.save(planinformation);
        addMessage(redirectAttributes, "目标还原成功");
        return "redirect:" + Global.getAdminPath() + "/ecpp/planinformation/deletePlanList";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = {"getstatisticsData"})
    public String getstatisticsData(Model model) {
        Map<String, Integer> map = new HashMap<String, Integer>();
        List<Information> list = planinformationService.getMonthReport();
        try {
            map.put("fileNum", list.get(0).getMonthReportNum());      //文件数量
            map.put("zeRenNum", list.get(1).getMonthReportNum());    //责任人
            map.put("fuZenNum", list.get(2).getMonthReportNum());      //负责人
        } catch (Exception e) {
            map.put("fileNum", 0);      //文件数量
            map.put("zeRenNum", 0);     //责任人
            map.put("fuZenNum", 0);      //负责人
        }
        model.addAttribute("dataMap", map);
        return "modules/ecpp/statisticsPage";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = {"getStatisticsByAjax"})
    public String getStatisticsByAjax(Model model,HttpServletResponse response) {
        //page=1&limit=30
        return renderString(response,statisticsService.getstatisticsData());
    }

    @RequiresPermissions("user")
    @RequestMapping(value = {"getStatisticsByAjaxPage"})
    public String getStatisticsByAjaxPage(Model model,HttpServletResponse response,HttpServletRequest request) {
        //page=1&limit=30
        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));
        Statistics statistics = new Statistics();
        statistics.setPageIndex(page);
        statistics.setPageSize(limit);

        Map<String,Object> map = new HashMap<String, Object>();
        //以下是layui要求的数据格式中三个参数
        map.put("code",0);
        map.put("msg","");
        map.put("count",50);
        map.put("data",statisticsService.getstatisticsDataPage(statistics));
        return renderString(response,map);
    }

}