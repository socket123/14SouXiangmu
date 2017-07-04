package com.vrv.utils;

import java.util.*;

import org.apache.log4j.Logger;

/**
 * <Description> <br>
 * 字符串处理工具类
 * 
 * @author Administrator<br>
 * @CreateDate 2015年10月28日 <br>
 */
public class StringUtil {
    private static final Logger LOG = Logger.getLogger(StringUtil.class);

    /**
     * Description: <br>
     * 判断map里面的值
     * 
     * @author Administrator<br>
     * @param map
     * @return <br>
     *         true 为空 false 不为空
     */
    public static boolean isEmpty(Map<String, Object> map) {
        boolean flag = false;
        if (null != map) {
            for (String key : map.keySet()) {
                LOG.info("key= " + key + " and value= " + map.get(key));
                return isEmpty(map.get(key));
            }
        } else {
            flag = true;
        }
        return flag;
    }

    /**
     * 判断字符串是否为空
     * 
     * @param strVal string
     * @return true 为空 false 不为空
     */
    public static boolean isEmpty(Object strVal) {
        boolean flag = false;
        if (strVal == null) {
            flag = true;
        } else {
            String str = String.valueOf(strVal);
            if ("".equals(trim(str)) || "null".equalsIgnoreCase(trim(str))) {
                flag = true;
            }
        }
        return flag;
    }

    public static String listToString(List<String> list) {

        String str = "";
        for (String string : list) {
            str += "\"" + string + "\",";
        }
        str = str.substring(0, str.length() - 1);

        return str;
    }

    public static String trimBracket(String strVal) {
        String strTemp = strVal.substring(0, strVal.length() - 1);
        return strTemp.substring(1, strTemp.length());
    }

    /**
     * 去除左右边全、半角空格
     * 
     * @param strValue 字符串
     * @return String 去除左右边全、半角空格字符串
     */
    public static String trim(String strValue) {

        if ((strValue != null) && (!strValue.equals(""))) {
            StringBuffer sb = new StringBuffer();
            StringBuffer sb1 = new StringBuffer();
            String strRet = "";
            sb.append(rTrim(strValue));
            // 反转后去掉右空格
            strRet = rTrim(sb.reverse().toString());
            sb1.append(strRet);
            strRet = sb1.reverse().toString();
            return strRet.trim();
        } else {
            return "";
        }
    }

    /**
     * 去除右边全半角空格
     * 
     * @param strValue String
     * @return String String
     */
    private static String rTrim(String strValue) {

        if ((strValue != null) && (!strValue.equals(""))) {
            char[] cValue = strValue.toCharArray();
            int nCur = 0;

            for (int i = cValue.length - 1; i > -1; i--) {
                if ((cValue[i] != '\u0020') && (cValue[i] != '\u3000')) {
                    nCur = i;
                    break;
                }
            }

            if ((nCur == 0) && ((cValue[0] == '\u0020') || (cValue[0] == '\u3000'))) {
                return "";
            }

            return strValue.substring(0, nCur + 1);
        } else {
            return "";
        }
    }

    /**
     * @param str object
     * @return
     */
    public static String toStr(Object str) {
        if (null == str) {
            return null;
        }

        return String.valueOf(str);
    }

    /**
     * 可以设置默认值
     * 
     * @param str
     * @param defaultValue
     * @return
     */
    public static String toStr(Object str, String defaultValue) {
        if (null == str) {
            return defaultValue;
        }

        return String.valueOf(str);
    }

    /**
     * 将对象转换成int类型
     * 
     * @param str
     * @param defaultValue 0
     * @return
     */
    public static int toInt(Object str, int defaultValue) {
        int value = defaultValue;

        if (null == str) {
            return value;
        }

        try {
            value = Integer.valueOf(String.valueOf(str));
        } catch (NumberFormatException e) {
            LOG.error(e);
            value = defaultValue;
        }
        return value;

    }

    public static int toInt(Object str) {
        return toInt(str, 0);
    }

    /**
     * Description: <br>
     * 判断list是否为空<br>
     * null or empty
     * 
     * @param list
     * @return true时为空，false不为空
     */
    public static boolean isEmpty(List<?> list) {
        return null == list || list.isEmpty();
    }

    /**
     * 将逗号的字符串组装为map类型的list
     * 
     * @param ids
     * @return
     */
    public static List<Map<String, Object>> setHandle(String ids) {
        // 组装IN条件
        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

        boolean have = false;

        for (String id : ids.split(",")) {
            if (StringUtil.isEmpty(id)) {
                continue;
            }
            Map<String, Object> itemMap = new HashMap<String, Object>();
            itemMap.put("brandId", id.trim());
            resultList.add(itemMap);
            have = true;
        }

        if (have) {
            return resultList;
        }

        return null;
    }


    /**
     *  字符串
     * @param ids
     * @return
     */
    public  static  List<String > string_split(String ids){
        boolean have = false;
        List<String > strings = new ArrayList<String>();
        for (String id : ids.split(",")) {
            if (StringUtil.isEmpty(id)) {
                continue;
            }

            strings.add(id);
            have = true;
        }

        if (have) {
            return strings;
        }

        return null;
    }




    private static boolean isNotEmojiCharacter(char codePoint) {
        return (codePoint == 0x0) || (codePoint == 0x9) || (codePoint == 0xA) || (codePoint == 0xD)
                || ((codePoint >= 0x20) && (codePoint <= 0xD7FF))
                || ((codePoint >= 0xE000) && (codePoint <= 0xFFFD));
    }

    /**
     * 过滤emoji 或者 其他非文字类型的字符
     * 
     * @param source
     * @return
     */
    public static String filterEmoji(String source) {
        int len = source.length();
        StringBuilder buf = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            char codePoint = source.charAt(i);
            if (isNotEmojiCharacter(codePoint)) {
                buf.append(codePoint);
            }
        }
        return buf.toString();
    }

    /**
     * 作用：产生随机字符串，不长于32位
     */
    public static String getRandomStr(int length) {
        StringBuffer buffer = new StringBuffer("0123456789abcdefghijklmnopqrstuvwxyz");
        StringBuffer sb = new StringBuffer();
        Random r = new Random();
        int range = buffer.length();
        for (int i = 0; i < length; i++) {
            sb.append(buffer.charAt(r.nextInt(range)));
        }
        return sb.toString();
    }
}
