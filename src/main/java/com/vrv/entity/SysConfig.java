package com.vrv.entity;


public class SysConfig {
    private Integer id;

    private String timeset;

    private Integer deliveryTimeout;

    private Integer receivTimeout;

    private String updateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTimeset() {
        return timeset;
    }

    public void setTimeset(String timeset) {
        this.timeset = timeset == null ? null : timeset.trim();
    }

    public Integer getDeliveryTimeout() {
        return deliveryTimeout;
    }

    public void setDeliveryTimeout(Integer deliveryTimeout) {
        this.deliveryTimeout = deliveryTimeout;
    }

    public Integer getReceivTimeout() {
        return receivTimeout;
    }

    public void setReceivTimeout(Integer receivTimeout) {
        this.receivTimeout = receivTimeout;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }
}