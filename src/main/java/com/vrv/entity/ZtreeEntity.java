/**
 * Ztree实体类
 */
package com.vrv.entity;

/**
 * @author zhq
 */
public class ZtreeEntity {
    private Long id;// 菜单编号
    private Long pId;// 父菜单编号
    private String name;// 菜单名称
    private String url;// 链接
    private String target;// target 默认链接到rightFrame
    private String checked;
    private Boolean open;
    private String pidL;//所有上级id
    private String pNameL;//所有上级名称

    /**
     * @return type
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */

    public Long getId() {
        return id;
    }

    /**
     * @param id
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @return type
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */

    public Long getpId() {
        return pId;
    }

    /**
     * @param pId
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */
    public void setpId(Long pId) {
        this.pId = pId;
    }

    /**
     * @return type
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */

    public String getName() {
        return name;
    }

    /**
     * @param name
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return type
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */

    public String getUrl() {
        return url;
    }

    /**
     * @param url
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return type
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */

    public String getTarget() {
        return target;
    }

    /**
     * @param target
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */
    public void setTarget(String target) {
        this.target = target;
    }

    /**
     * @return type
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */

    public String getChecked() {
        return checked;
    }

    /**
     * @param checked
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */
    public void setChecked(String checked) {
        this.checked = checked;
    }

    /**
     * @return type
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */

    public Boolean getOpen() {
        return open;
    }

    /**
     * @param open
     * @author zhanghongqi
     * @created 2015年8月14日 下午3:40:27
     */
    public void setOpen(Boolean open) {
        this.open = open;
    }

    public String getPidL() {
        return pidL;
    }

    public void setPidL(String pidL) {
        this.pidL = pidL;
    }

    public String getpNameL() {
        return pNameL;
    }

    public void setpNameL(String pNameL) {
        this.pNameL = pNameL;
    }

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "ZtreeEntity [id=" + id + ", pId=" + pId + ", name=" + name
                + ", url=" + url + ", target=" + target + ", checked="
                + checked + ", open=" + open + ", pidL="  + pidL +", pNameL="  + pNameL +"]";
    }

}
