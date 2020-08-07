package cn.msjava.blog.service;

import cn.msjava.blog.entity.BlogTagCount;
import cn.msjava.blog.util.PageQueryUtil;
import cn.msjava.blog.util.PageResult;

import java.util.List;

public interface TagService {

    /**
     * 查询标签的分页数据
     *
     * @param pageUtil
     * @return
     */
    PageResult getBlogTagPage(PageQueryUtil pageUtil);

    Boolean saveTag(String tagName);

    Boolean deleteBatch(Integer[] ids);

    List<BlogTagCount> getBlogTagCountForIndex();

}
