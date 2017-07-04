package com.vrv.controller.font;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vrv.contans.MyConfig;
import com.vrv.entity.SSUser;
import com.vrv.service.impl.TransportTeamService;
import com.vrv.service.impl.UserService;
import com.vrv.utils.AdminUtil;
import com.vrv.utils.MD5Util;

@Controller
public class IndexController {

    @Autowired
    UserService userService;

    @Autowired
    TransportTeamService teamService;

    @RequestMapping(value = "font/toChoiceRole")
    public String toMain() {
        return "font_page/index";
    }

    @RequestMapping(value = "toLogin")
    public String toLogin() {
        return "font_page/login";
    }

    @RequestMapping(value = "font/systemSetting")
    public String systemSetting(HttpServletRequest request, HttpServletResponse response) {
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        request.setAttribute("user", user);
        return "font_page/systemSetting";
    }

    @RequestMapping(value = "font/switchIsOpen", produces = "application/json;charset=UTF-8")
    public @ResponseBody Map<String, Object> switchIsOpen(HttpServletRequest request,
            HttpServletResponse response, Integer isOpen) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", "0");
        SSUser user = (SSUser) AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        SSUser userObj = new SSUser();
        if (user != null) {
            userObj.setId(user.getId());
            userObj.setIsOpen(isOpen);
        }
        try {
            map.put("message", userService.update(userObj));
            user.setIsOpen(isOpen);
            request.setAttribute("user", user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "userlogin", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> login(String userid, String password, Integer type) {
        Map<String, Object> map = new HashMap<String, Object>();
        int code = -1;
        if (!StringUtils.isEmpty(userid) && !StringUtils.isEmpty(password)) {
            SSUser user = userService.findByUser(userid);
            if (null != user) {
                int count = 1;
                if (type == 2) {
                    Map<String, Object> map2 = new HashMap<String, Object>();
                    map2.put("jobNum", user.getJobNum());
                    count = teamService.getTotalCount(map2);
                }
                if (count > 0) {
                    String pwd = MD5Util.getMD5Code(password, user.getSalt());
                    if (pwd.equalsIgnoreCase(user.getPassword())) {
                        AdminUtil.getInstance().setValue(MyConfig.FONT_USER, user, MyConfig.MAXAGE);
                        code = 1;
                    }
                }
            }
        }
        map.put("code", code);
        return map;
    }

    @RequestMapping(value = "login2", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> login2(String userid, String ddId) {
        Map<String, Object> map = new HashMap<String, Object>();
        int code = -1;
        int isTeam = 0;
        if (!StringUtils.isEmpty(userid)) {
            SSUser user = userService.findByUser(userid);
            if (null != user) {
                AdminUtil.getInstance().setValue(MyConfig.FONT_USER, user, MyConfig.MAXAGE);
                if (StringUtils.isEmpty(user.getDdId())) {
                    user.setDdId(ddId);
                    userService.update(user);
                }
                code = 1;
                isTeam = (null == user.getIsTeam()) ? 0 : user.getIsTeam();
            }
        }
        map.put("code", code);
        map.put("isTeam", isTeam);
        return map;
    }

    @RequestMapping(value = "logout")
    public String logout() {
        return "redirect:toLogin";
    }
}
