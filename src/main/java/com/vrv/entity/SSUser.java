package com.vrv.entity;

import java.util.Date;

public class SSUser {
    private Integer id;

    private String userName;

    private String jobNum;

    private String telephone;

    private Integer isOpen;

    private Date createTime;

    private String ddId;

    private String ddUser;

    private String password;

    private String salt;

    private Integer isTeam;

    private Integer teamId;

    private String teamName;

    private String ability;

    private String mycode;


    private  Integer is_worker;


    private  Integer worker_status;



    public Integer getWorker_status() {
        return worker_status;
    }

    public void setWorker_status(Integer worker_status) {
        this.worker_status = worker_status;
    }

    public Integer getIs_worker() {
        return is_worker;
    }

    public void setIs_worker(Integer is_worker) {
        this.is_worker = is_worker;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getJobNum() {
        return jobNum;
    }

    public void setJobNum(String jobNum) {
        this.jobNum = jobNum == null ? null : jobNum.trim();
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

    public Integer getIsOpen() {
        return isOpen;
    }

    public void setIsOpen(Integer isOpen) {
        this.isOpen = isOpen;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getDdId() {
        return ddId;
    }

    public void setDdId(String ddId) {
        this.ddId = ddId == null ? null : ddId.trim();
    }

    public String getDdUser() {
        return ddUser;
    }

    public void setDdUser(String ddUser) {
        this.ddUser = ddUser == null ? null : ddUser.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }

    public Integer getIsTeam() {
        return isTeam;
    }

    public void setIsTeam(Integer isTeam) {
        this.isTeam = isTeam;
    }

    public Integer getTeamId() {
        return teamId;
    }

    public void setTeamId(Integer teamId) {
        this.teamId = teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getAbility() {
        return ability;
    }

    public void setAbility(String ability) {
        this.ability = ability;
    }

    public String getMycode() {
        return mycode;
    }

    public void setMycode(String mycode) {
        this.mycode = mycode;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}