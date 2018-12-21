/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rejectreason.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.utils.Encodes;
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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.rejectreason.entity.Rejectreason;
import com.thinkgem.jeesite.modules.rejectreason.service.RejectreasonService;

/**
 * 目标驳回原因Controller
 *
 * @author zxt
 * @version 2018-06-13
 */
@Controller
@RequestMapping(value = "${adminPath}/rejectreason/rejectreason")
public class RejectreasonController extends BaseController {

    @Autowired
    private RejectreasonService rejectreasonService;

    @ModelAttribute
    public Rejectreason get(@RequestParam(required = false) String id) {
        Rejectreason entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = rejectreasonService.get(id);
        }
        if (entity == null) {
            entity = new Rejectreason();
        }
        return entity;
    }

    @RequiresPermissions("rejectreason:rejectreason:view")
    @RequestMapping(value = {"list", ""})
    public String list(Rejectreason rejectreason, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Rejectreason> page = rejectreasonService.findPage(new Page<Rejectreason>(request, response), rejectreason);
        model.addAttribute("page", page);
        return "modules/rejectreason/rejectreasonList";
    }

    @RequiresPermissions("rejectreason:rejectreason:view")
    @RequestMapping(value = "form")
    public String form(Rejectreason rejectreason, Model model) {
        model.addAttribute("rejectreason", rejectreason);
        return "modules/rejectreason/rejectreasonForm";
    }

    /**
     * 目标驳回信息查看
     *
     * @param rejectreason
     * @param model
     * @return
     */
    @RequiresPermissions("rejectreason:rejectreason:view")
    @RequestMapping(value = "reasonView")
    public String reasonView(Rejectreason rejectreason, Model model) {
        model.addAttribute("rejectreason", rejectreason);
        return "modules/rejectreason/reasonView";
    }

    @RequiresPermissions("rejectreason:rejectreason:edit")
    @RequestMapping(value = "save")
    public String save(Rejectreason rejectreason, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, rejectreason)) {
            return form(rejectreason, model);
        }
        String str = Encodes.unescapeHtml(rejectreason.getDescription());
        rejectreason.setDescription(str);
        rejectreasonService.save(rejectreason);
        addMessage(redirectAttributes, "保存目标驳回原因成功");
        return "redirect:" + Global.getAdminPath() + "/rejectreason/rejectreason/reasonView?id=" + rejectreason.getId();
    }


    @RequiresPermissions("rejectreason:rejectreason:edit")
    @RequestMapping(value = "delete")
    public String delete(Rejectreason rejectreason, RedirectAttributes redirectAttributes) {
        rejectreasonService.delete(rejectreason);
        addMessage(redirectAttributes, "删除目标驳回原因成功");
        return "redirect:" + Global.getAdminPath() + "/rejectreason/rejectreason/?repage";
    }

}