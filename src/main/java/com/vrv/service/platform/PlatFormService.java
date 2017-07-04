package com.vrv.service.platform;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.vrv.contans.MyConfig;
import com.vrv.utils.AdminUtil;
import com.vrv.utils.HttpClientUtil;

@Service
public class PlatFormService {

    private static Logger logger = Logger.getLogger(PlatFormService.class);

    /**
     * Description: <br>
     * 获取token
     * 
     * @return <br>
     */
    public static String getToken() {
        String token = (String) AdminUtil.getInstance().getValue(MyConfig.ACCESS_TOKEN);
        //        String token = "";
        if (StringUtils.isEmpty(token)) {
            String tokenurl = MyConfig.platForm.PLATFORM_URL + "token?accessType=CLIENT&appID="
                    + MyConfig.platForm.APPID + "&appSecret=" + MyConfig.platForm.APPSCRET;
            String json = HttpClientUtil.getInstance().get(tokenurl);
            JSONObject jsonObject = JSONObject.fromObject(json);
            if (null != jsonObject) {
                int code = jsonObject.getInt("code");
                if (code == 0) {
                    String result = jsonObject.getString("result");
                    JSONObject resObject = JSONObject.fromObject(result);
                    token = resObject.getString("access_token");
                    AdminUtil.getInstance().setValue(MyConfig.ACCESS_TOKEN, token);
                } else {
                    logger.info("获取token失败：" + json);
                }
            }
        }
        return token;
    }

    /**
     * Description: <br>
     * 发送模板消息
     * 
     * @param title 标题
     * @param content 内容
     * @param detailUrl 跳转url
     * @param toUsers 豆豆号<br>
     */
    public static void sendMessage(String title, String content, String detailUrl, String toUsers) {
        String token = getToken();
        String sendUrl = MyConfig.platForm.PLATFORM_URL
                + "message/sendMessageTemplate?access_token=" + token;
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("content", content);
        map.put("creator", "系统");
        map.put("detailUrl", detailUrl);
        map.put("title", title);
        map.put("titleBgColor", "#FFFFF0");
        map.put("titleColor", "#000000");
        map.put("toUsers", toUsers);
        map.put("type", "1");
        Gson gson = new Gson();
        String json = gson.toJson(map);
        Map<String, Object> msg = new HashMap<String, Object>();
        msg.put("message", json);
        String result = HttpClientUtil.getInstance().post(sendUrl, msg, "gbk");
        System.out.println("=========================================================================================");
        System.out.println(result);
    }

    public static void main(String[] args) {
        sendMessage("订单已完成", "订单已完成", "http://www.baidu.com", "7902186201");
    }

}
