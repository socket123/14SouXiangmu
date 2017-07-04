package com.vrv.entity;

public class QRJson {
    private String system;

    private String date;

    private String serialNo;

    private String sendLocation;

    private String sendPerson;

    private String receiveLocation;

    private String receivePerson;

    private String size;

    private String emergency;

    private String isLogsitics;

    public String getSystem() {
        return system;
    }

    public void setSystem(String system) {
        this.system = system;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public String getSendLocation() {
        return sendLocation;
    }

    public void setSendLocation(String sendLocation) {
        this.sendLocation = sendLocation;
    }

    public String getSendPerson() {
        return sendPerson;
    }

    public void setSendPerson(String sendPerson) {
        this.sendPerson = sendPerson;
    }

    public String getReceiveLocation() {
        return receiveLocation;
    }

    public void setReceiveLocation(String receiveLocation) {
        this.receiveLocation = receiveLocation;
    }

    public String getReceivePerson() {
        return receivePerson;
    }

    public void setReceivePerson(String receivePerson) {
        this.receivePerson = receivePerson;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getEmergency() {
        return emergency;
    }

    public void setEmergency(String emergency) {
        this.emergency = emergency;
    }

    public String getIsLogsitics() {
        return isLogsitics;
    }

    public void setIsLogsitics(String isLogsitics) {
        this.isLogsitics = isLogsitics;
    }

    @Override
    public String toString() {
        return "QRJson [system=" + system + ", date=" + date + ", serialNo=" + serialNo
                + ", sendLocation=" + sendLocation + ", sendPerson=" + sendPerson
                + ", receiveLocation=" + receiveLocation + ", receivePerson=" + receivePerson
                + ", size=" + size + ", emergency=" + emergency + ", isLogsitics=" + isLogsitics
                + "]";
    }

}
