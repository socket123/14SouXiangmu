package com.vrv.service.log;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface MyLog {
    /**
     * 方法描述
     * 
     * @return
     */
    public String content() default "";

    /**
     * 模块描述
     * 
     * @return
     */
    public String module();

    /**
     * 操作类型
     * 
     * @return
     */
    public String type();
}
