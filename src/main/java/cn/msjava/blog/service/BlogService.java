package cn.msjava.blog.service;

import cn.msjava.blog.entity.Blog;
import cn.msjava.blog.util.PageQueryUtil;
import cn.msjava.blog.util.PageResult;
import cn.msjava.blog.controller.vo.BlogDetailVO;
import cn.msjava.blog.controller.vo.SimpleBlogListVO;

import java.util.List;

public interface BlogService {

    String saveBlog(Blog blog);

    /**
     * 根据id获取详情
     *
     * @param blogId
     * @return
     */
    Blog getBlogById(Long blogId);



    /**
     * 后台修改
     *
     * @param blog
     * @return
     */
    String updateBlog(Blog blog);

    PageResult getBlogsPage(PageQueryUtil pageUtil);

    Boolean deleteBatch(Integer[] ids);

    /**
     * 首页侧边栏数据列表
     * 0-点击最多 1-最新发布
     *
     * @param type
     * @return
     */
    List<SimpleBlogListVO> getBlogListForIndexPage(int type);

    /**
     * 获取首页文章列表
     *
     * @param page
     * @return
     */
    PageResult getBlogsForIndexPage(int page);

    PageResult getBlogsPageBySearch(String keyword, int page);

    /**
     * 根据分类获取文章列表
     *
     * @param categoryId
     * @param page
     * @return
     */
    PageResult getBlogsPageByCategory(String categoryId, int page);


    /**
     * 根据标签获取文章列表
     *
     * @param tagName
     * @param page
     * @return
     */
    PageResult getBlogsPageByTag(String tagName, int page);

    /**
     * 文章详情获取
     *
     * @param blogId
     * @return
     */
    BlogDetailVO getBlogDetail(Long blogId);
}
