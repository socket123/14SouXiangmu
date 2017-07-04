package com.vrv.entity;

import java.util.Date;

public class Evaluate {
    private Integer id;

    private Integer orderId;

    private String sendorreci;

    private Integer evaluateUserid;

    private Integer evaluateCourier;

    private Integer serviceAttitude;

    private Integer timeliness;

    private Integer serviceQuality;

    private String remark;

    private Date createTime;

    private Integer ifDefault;

    private Integer teamId;

    private String waybillNumber;

    private String userName;

    private String courierName;

    private String teamName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getSendorreci() {
        return sendorreci;
    }

    public void setSendorreci(String sendorreci) {
        this.sendorreci = sendorreci;
    }

    public Integer getEvaluateUserid() {
        return evaluateUserid;
    }

    public void setEvaluateUserid(Integer evaluateUserid) {
        this.evaluateUserid = evaluateUserid;
    }

    public Integer getEvaluateCourier() {
        return evaluateCourier;
    }

    public void setEvaluateCourier(Integer evaluateCourier) {
        this.evaluateCourier = evaluateCourier;
    }

    public Integer getServiceAttitude() {
        return serviceAttitude;
    }

    public void setServiceAttitude(Integer serviceAttitude) {
        this.serviceAttitude = serviceAttitude;
    }

    public Integer getTimeliness() {
        return timeliness;
    }

    public void setTimeliness(Integer timeliness) {
        this.timeliness = timeliness;
    }

    public Integer getServiceQuality() {
        return serviceQuality;
    }

    public void setServiceQuality(Integer serviceQuality) {
        this.serviceQuality = serviceQuality;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getIfDefault() {
        return ifDefault;
    }

    public void setIfDefault(Integer ifDefault) {
        this.ifDefault = ifDefault;
    }

    public String getWaybillNumber() {return waybillNumber;}

    public void setWaybillNumber(String waybillNumber) {this.waybillNumber = waybillNumber;}

    public String getUserName() {return userName;}

    public void setUserName(String userName) {this.userName = userName;}

    public String getCourierName() {return courierName;}

    public void setCourierName(String courierName) {this.courierName = courierName;}

    public Integer getTeamId() {return teamId;}

    public void setTeamId(Integer teamId) {this.teamId = teamId;}

    public String getTeamName() {return teamName;}

    public void setTeamName(String teamName) {this.teamName = teamName;}
}