package com.vrv.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vrv.mapper.BaseDao;
import com.vrv.utils.FiledUtil;
import com.vrv.utils.Pager;

/**
 * <Description> <br>
 * 基础逻辑处理
 * 
 * @CreateDate 2016年5月26日 <br>
 */
@Service
public class BaseService<T> {

    @Autowired
    private BaseDao<T> baseDao;

    /**
     * 根据id查询
     * 
     * @param id
     */
    public T get(String id) {
        if (StringUtils.isEmpty(id)) {
            return null;
        } else {
            return baseDao.selectByPrimaryKey(id);
        }
    }

    /**
     * 根据id查询
     * 
     * @param id
     */
    public T get(Integer id) {
        if (null == id) {
            return null;
        } else {
            return baseDao.selectByPrimaryKey(id);
        }
    }

    /**
     * 删除
     * 
     * @param id
     * @return <br>
     */
    public int delete(Integer id) {
        if (null == id) {
            return -1;
        } else {
            return baseDao.deleteByPrimaryKey(id);
        }
    }

    /**
     * 删除
     * 
     * @param id
     * @return <br>
     */
    public int delete(String id) {
        if (StringUtils.isEmpty(id)) {
            return -1;
        } else {
            return baseDao.deleteByPrimaryKey(id);
        }
    }

    /**
     * 修改
     * 
     * @param id
     * @return <br>
     */
    public int update(T obj) {
        return baseDao.updateByPrimaryKeySelective(obj);
    }

    /**
     * Description: <br>
     * 统计条数
     * 
     * @return <br>
     */
    public int getTotalCount(Map<String, Object> map) {
        return baseDao.getTotalCount(map);
    }

    /**
     * Description: <br>
     * 统计条数
     * 
     * @return <br>
     */
    public int getTotalCount(Object object) {
        Map<String, Object> map = FiledUtil.getObjectValue(object);
        return baseDao.getTotalCount(map);
    }

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    public List<T> getList(Integer size) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("offset", 0);
        map.put("size", size);
        return baseDao.getList(map);
    }

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    public List<T> getList(Map<String, Object> map) {
        return baseDao.getList(map);
    }

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    public Pager<T> getPage(Integer pageNo) {
        return getPage(new HashMap<String, Object>(), pageNo, null);
    }

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    public Pager<T> getPage(T obj, Integer pageNo) {
        return getPage(obj, pageNo, null);
    }

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    public Pager<T> getPage(T obj, Integer pageNo, Integer size) {
        Map<String, Object> map = FiledUtil.getObjectValue(obj);
        return getPage(map, pageNo, size);
    }

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    public Pager<T> getPage(Map<String, Object> map, Integer pageNo) {
        return getPage(map, pageNo, null);
    }

    /**
     * Description: <br>
     * 分页查询
     * 
     * @param map{startIndex,limit}
     * @return <br>
     */
    public Pager<T> getPage(Map<String, Object> map, Integer pageNo, Integer size) {
        if (map == null) {
            map = new HashMap<String, Object>();
        }
        int total = getTotalCount(map);
        Pager<T> page = new Pager<T>(total, pageNo, size);
        map.put("offset", page.getOffset());
        map.put("size", page.getLimit());
        page.setList(getList(map));
        return page;
    }

    /**
     * 修改或保存
     */
    public int saveOrUpdate(T obj, Integer id) {
        int count = 0;
        if (obj == null) {
            count = -1;
        } else if (null == id) {
            count = insert(obj);
        } else {
            count = update(obj);
        }
        return count;
    }

    /**
     * 修改或保存
     */
    public int saveOrUpdate(T obj, String id) {
        int count = 0;
        if (obj == null) {
            count = -1;
        } else if (StringUtils.isEmpty(id)) {
            count = insert(obj);
        } else {
            count = update(obj);
        }
        return count;
    }

    public int insert(T obj) {
        return baseDao.insertSelective(obj);
    }
}
