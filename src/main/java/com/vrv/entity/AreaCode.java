package com.vrv.entity;

import java.util.Date;

public class AreaCode {
    private Integer id;

    private String areaCode;

    private String areaOut;

    private Integer isEnable;

    private Date createTime;

    private String userId;

    private Integer areaType;

    private String areaTrunk;

    /**
     * 转入数
     */
    private Integer inCount;

    /**
     * 转出数
     */
    private Integer outCount;

    private Integer ssOrder;

    private Integer teamId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode == null ? null : areaCode.trim();
    }

    public String getAreaOut() {
        return areaOut;
    }

    public void setAreaOut(String areaOut) {
        this.areaOut = areaOut == null ? null : areaOut.trim();
    }

    public Integer getIsEnable() {
        return isEnable;
    }

    public void setIsEnable(Integer isEnable) {
        this.isEnable = isEnable;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getInCount() {
        return inCount;
    }

    public void setInCount(Integer inCount) {
        this.inCount = inCount;
    }

    public Integer getOutCount() {
        return outCount;
    }

    public void setOutCount(Integer outCount) {
        this.outCount = outCount;
    }

    public Integer getSsOrder() {
        return ssOrder;
    }

    public void setSsOrder(Integer ssOrder) {
        this.ssOrder = ssOrder;
    }

    public Integer getTeamId() {
        return teamId;
    }

    public void setTeamId(Integer teamId) {
        this.teamId = teamId;
    }

    public Integer getAreaType() {
        return areaType;
    }

    public void setAreaType(Integer areaType) {
        this.areaType = areaType;
    }

    public String getAreaTrunk() {return areaTrunk;}

    public void setAreaTrunk(String areaTrunk) {this.areaTrunk = areaTrunk;}

}