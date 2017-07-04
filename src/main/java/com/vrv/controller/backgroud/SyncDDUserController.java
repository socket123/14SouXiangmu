package com.vrv.controller.backgroud;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.druid.pool.DruidPooledConnection;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.vrv.service.impl.UserService;
import com.vrv.utils.sync.RemoteConnection;

@Controller
@RequestMapping("/admin/sync")
public class SyncDDUserController {

    @Autowired
    UserService userService;

    public static void main(String[] args) throws SQLException {
        //querySQL();
        String json = "[{\"duty\":\"无\",\"isFirstLogin\":\"0\",\"enmail\":\"564654654@qq.com\",\"orderNum\":5,\"f1d8d9b8088e4be5b9ed6914ad6b7ee6\":\"000071\",\"enmobile\":\"15062226155\",\"orgID\":\"1\",\"enname\":\"袁荣祥\"}]";
        Gson gson = new Gson();
        List<Map<String, Object>> list = gson.fromJson(json,
                new TypeToken<List<Map<String, Object>>>() {
                }.getType());
        Map<String, Object> map = list.get(0);
        System.out.println(map.get("f1d8d9b8088e4be5b9ed6914ad6b7ee6"));
        System.out.println(map.get("enmobile"));
    }

    private static void querySQL() throws SQLException {
        RemoteConnection dbp = RemoteConnection.getInstance();
        DruidPooledConnection con = dbp.getConnection();
        String sql = "SELECT userID,`name`,entExtend FROM IM_USER_0 "
                + "UNION ALL SELECT userID,`name`,entExtend FROM IM_USER_1 "
                + "UNION ALL SELECT userID,`name`,entExtend FROM IM_USER_2 "
                + "UNION ALL SELECT userID,`name`,entExtend FROM IM_USER_3 "
                + "UNION ALL SELECT userID,`name`,entExtend FROM IM_USER_4";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            System.out.print(" ==>id : " + rs.getString(1));
            System.out.print(" ==>name : " + rs.getString(2));
            System.out.println(" ==>entExtend : " + rs.getString(3));

        }
        ps.close();
        con.close();
        dbp = null;
    }
}
