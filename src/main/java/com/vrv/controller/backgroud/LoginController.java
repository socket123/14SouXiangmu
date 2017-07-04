package com.vrv.controller.backgroud;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vrv.contans.MyConfig;
import com.vrv.entity.Login;
import com.vrv.service.impl.LoginServiceImpl;
import com.vrv.service.log.MyLog;
import com.vrv.utils.AdminUtil;
import com.vrv.utils.MD5Util;

@Controller
public class LoginController {
    @Autowired
    LoginServiceImpl loginService;

    @RequestMapping(value = "/login")
    public ModelAndView inityIndex() {
        return new ModelAndView("backgroud/login");
    }

    @MyLog(module = "system", type = "login", content = "登录")
    @RequestMapping(value = "/checkLogin", produces = MyConfig.PRODUCES)
    @ResponseBody
    public Map<String, Object> checkLogin(String username, String password) {
        Login login = new Login();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("message", 0);
        try {
            login = loginService.findLogin(username);
            if (login != null) {
                String salt = login.getSalt();
                String newPassword = MD5Util.getMD5Code(password, salt);
                if (login.getPassword().equals(newPassword)) {
                    map.put("message", 1);
                    map.put("username", login.getUsername());
                    AdminUtil.getInstance().setValue(AdminUtil.ADMIN_USER, login);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "/admin/index")
    public ModelAndView gotoIndex(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        String username = request.getParameter("username");
        map.put("username", username);
        return new ModelAndView("backgroud/index", map);
    }
}
