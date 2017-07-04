package com.vrv.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.vrv.entity.SSUser;

public interface SSUserMapper extends BaseDao<SSUser> {

    SSUser findByUser(String jobNum);

    Integer findByUserByJobNum(@Param("jobNum") String jobNum, @Param("ddId") String ddId);

    public List<SSUser> findUserList();

    SSUser findUserById(Integer id);

    public List<SSUser> findJobNumById(Integer teamId);


    // 查询 空闲 民工
    List<SSUser> selectWorker ();

    // 修改
    int updateByPrimaryKeySelective(SSUser ssUser);

    /**
     * Description: <br>
     * 查询符合条件的团队及负责人
     * 
     * @param areaCode
     * @param ability
     * @return <br>
     */
    public List<SSUser> findTeamUser(@Param("areaCode") String areaCode,
            @Param("areaCode1") String areaCode1, @Param("ability") String ability);

    /**
     * Description: <br>
     * 查询符合条件的团队及负责人
     *
     * @param areaCode
     * @param ability
     * @return <br>
     */
    public List<SSUser> findTeamUserNew(@Param("areaCode") String areaCode,
                                     @Param("areaCode1") String areaCode1, @Param("ability") String ability);
}