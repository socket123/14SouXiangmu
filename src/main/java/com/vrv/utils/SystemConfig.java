package com.vrv.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * 系统配置文件
 * 
 * @author wanglei
 */
public class SystemConfig {

    private static final Logger logger = Logger.getLogger(SystemConfig.class);

    private static final String FILE_URL = "config/config.properties";

    private static Properties config = null;
    static {
        InputStream in = SystemConfig.class.getClassLoader().getResourceAsStream(FILE_URL);
        config = new Properties();
        try {
            config.load(in);
            in.close();
        } catch (IOException e) {
            logger.error("No AreaPhone.properties defined error");
        }
    }

    // 根据key读取value
    public static String readValue(String key) {
        // Properties props = new Properties();
        try {
            String value = config.getProperty(key);
            return value;
        } catch (Exception e) {
            logger.error("ConfigInfoError" + e.toString());
            return null;
        }
    }

    public static String getStr(String key) {
        return getStr(key, "");
    }

    /**
     * 根据key读取配置文件对应值，当值不存在时返回默认值
     * 
     * @param key 属性名
     * @param defaultValue 默认值
     * @return 字符串
     */
    public static String getStr(String key, String defaultValue) {
        String value = null;

        try {
            value = config.getProperty(key);
        } catch (Exception e) {
            logger.error(e);
        }

        if (null == value || "".equals(value)) {
            value = defaultValue;
        }

        return value;
    }

    /**
     * 根据key读取配置文件对应值，当值不存在时返回默认值
     * 
     * @param key 属性名
     * @param defaultValue 默认值
     * @return 数字
     */
    public static int getInt(String key, int defaultValue) {
        int value = defaultValue;

        try {
            value = Integer.valueOf(config.getProperty(key));
        } catch (NumberFormatException e) {
            logger.error(e);
        }

        return value;
    }

    /**
     * 根据key读取配置文件对应值，当值不存在时返回默认值0
     * 
     * @param key 属性名
     * @param defaultValue 默认值
     * @return 数字
     */
    public static int getInt(String key) {
        return getInt(key, 0);
    }

    // 根据key读取value
    public static String setValue(String key, String value) {
        try {
            Properties properties = new Properties();
            // 保存属性到properties文件
            File file = new File(FILE_URL);
            String path = file.getCanonicalPath();
            FileOutputStream outputStream = new FileOutputStream(path, true);// true表示追加打开
            properties.setProperty(key, value);
            properties.store(outputStream, "dbInfo");
            outputStream.close();
            return value;
        } catch (Exception e) {
            logger.error("ConfigInfoError" + e.toString());
            return null;
        }
    }

    public static void main(String[] args) throws IOException {

    }

}
