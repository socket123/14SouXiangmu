package com.vrv.service.log;

import java.lang.reflect.Method;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.vrv.entity.Login;
import com.vrv.entity.SysLog;
import com.vrv.service.impl.SysLogService;
import com.vrv.utils.AdminUtil;
import com.vrv.utils.DateUtil;

/**
 * 切点类
 * 
 * @author tiangai
 * @since 2014-08-05 Pm 20:35
 * @version 1.0
 */
@Aspect
@Component
public class SystemLogAspect {
    // 注入Service用于把日志保存数据库
    @Resource
    private SysLogService logService;

    // 本地异常日志记录对象
    private static final Logger logger = LoggerFactory.getLogger(SystemLogAspect.class);

    // Controller层切点
    @Pointcut("@annotation(com.vrv.service.log.MyLog)")
    public void controllerAspect() {
    }

    /**
     * 前置通知 用于拦截Controller层记录用户的操作
     *
     * @param joinPoint 切点
     * @throws SecurityException
     * @throws NoSuchMethodException
     * @throws ClassNotFoundException
     */
    @SuppressWarnings("rawtypes")
    @After("controllerAspect()")
    public void doBefore(JoinPoint joinPoint) throws NoSuchMethodException, SecurityException,
            ClassNotFoundException {

        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);

        if (StringUtils.isNotEmpty(methodName)) {
            Method[] methods = targetClass.getMethods();
            for (Method method : methods) {
                boolean hasAnnotation = method.isAnnotationPresent(MyLog.class);
                if (method.getName().equals(methodName) && hasAnnotation) {
                    Class[] clazzs = method.getParameterTypes();
                    if (clazzs.length == arguments.length) {
                        MyLog annotation = method.getAnnotation(MyLog.class);
                        Login user = (Login) AdminUtil.getInstance().getValue(AdminUtil.ADMIN_USER);
                        if (null != user) {
                            SysLog sysLog = new SysLog();
                            sysLog.setContent(annotation.content());
                            sysLog.setCreateTime(DateUtil.getNowDate(""));
                            sysLog.setModule(annotation.module());
                            sysLog.setType(annotation.type());
                            sysLog.setCreateUser(user.getUsername());
                            sysLog.setIp(AdminUtil.getInstance().getIp());
                            logService.insert(sysLog);
                            logger.info("sysLog:" + sysLog.toString());
                        }
                        break;
                    }
                }
            }
        }
    }
}
