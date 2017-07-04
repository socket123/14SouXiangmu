package com.vrv.service.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.pool.DruidPooledConnection;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.vrv.entity.SSUser;
import com.vrv.mapper.SSUserMapper;
import com.vrv.service.BaseService;
import com.vrv.utils.StringUtil;
import com.vrv.utils.sync.RemoteConnection;

@Service
public class UserService extends BaseService<SSUser> {
    private final Logger logger = Logger.getLogger(UserService.class);

    @Autowired
    SSUserMapper ssUserMapper;

    public SSUser findByUser(String jobNum) {
        return ssUserMapper.findByUser(jobNum);
    }

    public Integer findByUserByJobNum(String jobNum, String ddId) {
        return ssUserMapper.findByUserByJobNum(jobNum, ddId);
    }

    public List<SSUser> findUserList() {
        return ssUserMapper.findUserList();
    }

    public SSUser findUserById(Integer id) {
        return ssUserMapper.findUserById(id);
    }

    public List<SSUser> findJobNumById(Integer teamId) {
        return ssUserMapper.findJobNumById(teamId);

    }

    // 查询
    public List<SSUser> selectWorker (){

        return  ssUserMapper.selectWorker();
    }

    // 修改
    public  int updateByPrimaryKeySelective(SSUser ssUser){

        return ssUserMapper.updateByPrimaryKeySelective(ssUser);
    }

    /**
     * Description: <br>
     * 查询符合条件的团队及负责人
     * 
     * @param areaCode
     * @param ability
     * @return <br>
     */
    public List<SSUser> findTeamUser(String areaCode, String areaCode1, String ability) {
        return ssUserMapper.findTeamUser(areaCode, areaCode1, ability);
    }

    /**
     * Description: <br>
     * 查询符合条件的团队及负责人
     *
     * @param areaCode
     * @param ability
     * @return <br>
     */
    public List<SSUser> findTeamUserNew(String areaCode, String areaCode1, String ability) {
        return ssUserMapper.findTeamUserNew(areaCode, areaCode1, ability);
    }

    @Transactional
    public int saveDDUser() {
        int i = 0;
        try {
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
                logger.info("==================>获取到结果集：" + rs.getString(1) + rs.getString(2)
                        + rs.getString(3));

                String json = rs.getString(3);
                if (!StringUtils.isEmpty(json)) {
                    Gson gson = new Gson();
                    List<Map<String, Object>> list = gson.fromJson(json,
                            new TypeToken<List<Map<String, Object>>>() {
                            }.getType());
                    Map<String, Object> map = list.get(0);
                    String jobNum = StringUtil.toStr(map.get("f1d8d9b8088e4be5b9ed6914ad6b7ee6"));

                    SSUser ssUser = this.findByUser(jobNum);
                    if (null == ssUser) {
                        //工号不存在，新增
                        SSUser user = new SSUser();
                        user.setDdId(rs.getString(1));
                        user.setUserName(rs.getString(2));
                        user.setCreateTime(new Date());
                        if (!StringUtils.isEmpty(jobNum)) {
                            user.setJobNum(jobNum);
                            user.setTelephone(map.get("enmobile") + "");
                            i += super.insert(user);
                        }
                    } else {
                        ssUser.setDdId(rs.getString(1));
                        ssUser.setUserName(rs.getString(2));
                        ssUser.setTelephone(map.get("enmobile") + "");
                        i += super.update(ssUser);
                    }
                }
            }
            ps.close();
            con.close();
            dbp = null;
        } catch (Exception e) {
            logger.error("出现异常：", e);
        }
        return i;
    }
}
