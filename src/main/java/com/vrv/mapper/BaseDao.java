package com.vrv.mapper;

import java.util.List;
import java.util.Map;

/**
 * <Description> <br>
 * 基础dao
 * 
 * @CreateDate 2016年5月26日 <br>
 */
public interface BaseDao<T> {
    /**
     * 根据id查询
     * 
     * @param id
     */
    T selectByPrimaryKey(String id);

    /**
     * 根据id查询
     * 
     * @param id
     */
    T selectByPrimaryKey(Integer id);

    /**
     * 删除
     * 
     * @param id
     * @return <br>
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 删除
     * 
     * @param id
     * @return <br>
     */
    int deleteByPrimaryKey(String id);

    /**
     * 修改
     * 
     * @param id
     * @return <br>
     */
    int updateByPrimaryKeySelective(T obj);

    /**
     * 新增
     * 
     * @param id
     * @return <br>
     */
    int insertSelective(T obj);

    /**
     * Description: <br>
     * 统计条数
     * 
     * @return <br>
     */
    int getTotalCount(Map<String, Object> map);

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    List<T> getList(Map<String, Object> map);




}
