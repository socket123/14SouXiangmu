package com.vrv.interceptor;

import java.util.HashSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class OnlineListener implements HttpSessionListener, HttpSessionAttributeListener,
        ServletRequestListener {

    HttpServletRequest request;

    private int count;

    private ServletContext application = null;

    public OnlineListener() {
        count = 0;
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent se) {

    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent se) {

    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent se) {

    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        count++;
        setContext(se);
        HttpSession session = se.getSession();
        application = session.getServletContext();
        // 在application范围由一个HashSet集保存所有的session
        HashSet sessions = (HashSet) application.getAttribute("sessions");
        if (sessions == null) {// 判断sessions是否存在，如果为空就new一个，set进application中，以后每次登录往hashset中set进去一个session对象
            sessions = new HashSet();
            application.setAttribute("sessions", sessions);
        }
        sessions.add(session);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        count--;
        setContext(se);
        HttpSession session = se.getSession();
        application = session.getServletContext();
        HashSet sessions = (HashSet) application.getAttribute("sessions");
        if (sessions != null) {
            sessions.remove(session);
        }
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sre) {

    }

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        request = (HttpServletRequest) sre.getServletRequest();
    }

    public void setContext(HttpSessionEvent httpSessionEvent) {
        httpSessionEvent.getSession().getServletContext().setAttribute("online", count);
    }
}
