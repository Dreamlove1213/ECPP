/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ecppwork.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.Encodes;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.ecppwork.entity.EcppWorkprogramme;
import com.thinkgem.jeesite.modules.ecppwork.service.EcppWorkprogrammeService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 工作计划Controller
 *
 * @author nan
 * @version 2018-03-29
 */
@Controller
@RequestMapping(value = "${adminPath}/ecppwork/ecppWorkprogramme")
public class EcppWorkprogrammeController extends BaseController {

    @Autowired
    private EcppWorkprogrammeService ecppWorkprogrammeService;

    @ModelAttribute
    public EcppWorkprogramme get(@RequestParam(required = false) String id) {
        EcppWorkprogramme entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = ecppWorkprogrammeService.get(id);
        }
        if (entity == null) {
            entity = new EcppWorkprogramme();
        }
        return entity;
    }

    @RequiresPermissions("user")
    @RequestMapping(value = {"list", ""})
    public String list(EcppWorkprogramme ecppWorkprogramme, HttpServletRequest request, HttpServletResponse response, Model model) {
        ecppWorkprogramme.setStatus("1");
        Page<EcppWorkprogramme> page = ecppWorkprogrammeService.findPage(new Page<EcppWorkprogramme>(request, response), ecppWorkprogramme);
        model.addAttribute("page", page);
        return "modules/ecppwork/ecppWorkprogrammeList";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "form")
    public String form(EcppWorkprogramme ecppWorkprogramme, Model model) {
        model.addAttribute("ecppWorkprogramme", ecppWorkprogramme);
        return "modules/ecppwork/ecppWorkprogrammeForms";
    }

    @RequiresPermissions("ecppwork:ecppWorkprogramme:view")
    @RequestMapping(value = "formforedit")
    public String formforedit(EcppWorkprogramme ecppWorkprogramme, Model model) {
        model.addAttribute("ecppWorkprogramme", ecppWorkprogramme);
        return "modules/ecppwork/ecppWorkprogrammeForm";
    }

    @RequiresPermissions("ecppwork:ecppWorkprogramme:view")
    @RequestMapping(value = "forms")
    public String forms(EcppWorkprogramme ecppWorkprogramme, Model model) {
        ecppWorkprogramme.setUnit(UserUtils.getUser().getOffice());
        List<EcppWorkprogramme> ecppWorkprogrammelist = ecppWorkprogrammeService.findList(ecppWorkprogramme);

        if (ecppWorkprogrammelist != null) {
            if (ecppWorkprogrammelist.size() > 0) {
                EcppWorkprogramme ecppWorkprogrammes = ecppWorkprogrammelist.get(0);
                model.addAttribute("ecppWorkprogramme", ecppWorkprogrammes);
                return "modules/ecppwork/ecppWorkprogrammeForms";
            } else {
                model.addAttribute("ecppWorkprogramme", ecppWorkprogramme);
                return "modules/ecppwork/ecppWorkprogrammeForm";
            }
        } else {
            model.addAttribute("ecppWorkprogramme", ecppWorkprogramme);
            return "modules/ecppwork/ecppWorkprogrammeForm";
        }
    }

    @RequiresPermissions("ecppwork:ecppWorkprogramme:view")
    @RequestMapping(value = "formss")
    public String formss(EcppWorkprogramme ecppWorkprogramme, Model model) {
        ecppWorkprogramme.setUnit(UserUtils.getUser().getOffice());
        List<EcppWorkprogramme> ecppWorkprogrammelist = ecppWorkprogrammeService.findList(ecppWorkprogramme);

        if (ecppWorkprogrammelist != null) {
            if (ecppWorkprogrammelist.size() > 0) {
                EcppWorkprogramme ecppWorkprogrammes = ecppWorkprogrammelist.get(0);
                model.addAttribute("ecppWorkprogramme", ecppWorkprogrammes);
                return "modules/ecppwork/ecppWorkprogrammeForms";
            } else {
                model.addAttribute("ecppWorkprogramme", ecppWorkprogramme);
                return "modules/ecppwork/ecppWorkprogrammeForms";
            }
        } else {
            model.addAttribute("ecppWorkprogramme", ecppWorkprogramme);
            return "modules/ecppwork/ecppWorkprogrammeForms";
        }
    }

    @RequiresPermissions("ecppwork:ecppWorkprogramme:edit")
    @RequestMapping(value = "save")
    public String save(EcppWorkprogramme ecppWorkprogramme, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, ecppWorkprogramme)) {
            return form(ecppWorkprogramme, model);
        }
        ecppWorkprogramme.setUnit(UserUtils.getUser().getOffice());
        String str = Encodes.unescapeHtml(ecppWorkprogramme.getInformationcontent());
        ecppWorkprogramme.setInformationcontent(str);

        ecppWorkprogramme.setStatus("0");
        ecppWorkprogramme.setAttribute4(UserUtils.getUser().getOffice().getType());
        model.addAttribute("ecppWorkprogramme", ecppWorkprogramme);
        addMessage(redirectAttributes, "保存工作计划成功");
        ecppWorkprogrammeService.save(ecppWorkprogramme);
        return "redirect:" + Global.getAdminPath() + "/ecppwork/ecppWorkprogramme/forms";
    }

    @RequiresPermissions("ecppwork:ecppWorkprogramme:edit")
    @RequestMapping(value = "delete")
    public String delete(EcppWorkprogramme ecppWorkprogramme, RedirectAttributes redirectAttributes) {
        ecppWorkprogrammeService.delete(ecppWorkprogramme);
        addMessage(redirectAttributes, "删除工作计划成功");
        return "redirect:" + Global.getAdminPath() + "/ecppwork/ecppWorkprogramme/?repage";
    }


    @RequiresPermissions("ecppwork:ecppWorkprogramme:edit")
    @RequestMapping(value = "tijiao")
    public String tijiao(EcppWorkprogramme ecppWorkprogramme, RedirectAttributes redirectAttributes) {
        ecppWorkprogramme.setStatus("1");
        ecppWorkprogrammeService.save(ecppWorkprogramme);
        addMessage(redirectAttributes, "提交工作计划成功");
        return "redirect:" + Global.getAdminPath() + "/ecppwork/ecppWorkprogramme/forms";
    }

}