package com.vrv.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.vrv.contans.MyConfig;
import com.vrv.utils.AdminUtil;

public class UserInterceptor implements HandlerInterceptor {

    private Logger logger = Logger.getLogger(UserInterceptor.class);

    @Override
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2,
            Exception arg3) throws Exception {

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
            Object handler, ModelAndView arg3) throws Exception {
        preHandle(request, response, handler);
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
            Object handler) throws Exception {
        Object obj = AdminUtil.getInstance().getValue(MyConfig.FONT_USER);
        if (obj == null) {
            String jsCode = "<script type='text/javascript'>"
                    + "var p=window;while(p!=p.parent){p=p.parent; } p.location.href='"
                    + request.getContextPath() + "/toLogin'</script>";
            PrintWriter writer = response.getWriter();
            writer.print(jsCode);
            writer.flush();
            writer.close();
            logger.log(Level.INFO, "user not login");
            return false;
        } else {
            logger.log(Level.INFO, "用户session还存在");
        }
        return true;

    }

}
