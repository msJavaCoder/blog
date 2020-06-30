package com.imood.blog.service;

import com.imood.blog.entity.Category;
import com.imood.blog.util.PageQueryUtil;
import com.imood.blog.util.PageResult;

/**
 * @description:
 * @author: 微信公众号：码上Java
 * @createDate: 2020/6/29/0029
 * @version: 1.0
 */
public interface CategoryService {
    PageResult getBlogCategoryPage(PageQueryUtil pageUtil);

    Boolean saveCategory(String categoryName, String categoryIcon);

    Boolean deleteBatch(Integer[] ids);

    Category selectById(int categoryId);


    Boolean updateCategory(Integer categoryId, String categoryName, String categoryIcon);
}
