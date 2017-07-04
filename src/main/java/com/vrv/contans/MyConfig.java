package com.vrv.contans;

import com.vrv.utils.SystemConfig;

public class MyConfig {
    /**
     * json标记
     */
    public static final String PRODUCES = "application/json; charset=utf-8";

    public static final String FONT_USER = "FONT_SS_USER";

    public static final String TEAM_USER = "FONT_TEAM_USER";

    public static final int MAXAGE = SystemConfig.getInt("cookieMaxAge");

    public static final String ACCESS_TOKEN = "access_token";

    public interface platForm {
        public static final String APPID = SystemConfig.getStr("appid");

        public static final String APPSCRET = SystemConfig.getStr("appscret");

        public static final String BASE_URL = SystemConfig.getStr("ftbaseurl");

        public static final String PLATFORM_URL = BASE_URL + "platform/platform/";

    }
}
