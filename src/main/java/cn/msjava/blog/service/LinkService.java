package cn.msjava.blog.service;

import cn.msjava.blog.entity.BlogLink;
import cn.msjava.blog.util.PageQueryUtil;
import cn.msjava.blog.util.PageResult;

public interface LinkService {
    /**
     * 查询友链的分页数据
     *
     * @param pageUtil
     * @return
     */
    PageResult getBlogLinkPage(PageQueryUtil pageUtil);

    Boolean saveLink(BlogLink link);

    BlogLink selectById(Integer id);

    Boolean updateLink(BlogLink tempLink);

    Boolean deleteBatch(Integer[] ids);
}
