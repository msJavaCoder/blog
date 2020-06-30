package com.imood.blog.service.impl;

import com.imood.blog.entity.Category;
import com.imood.blog.mapper.CategoryMapper;
import com.imood.blog.service.CategoryService;
import com.imood.blog.util.PageQueryUtil;
import com.imood.blog.util.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @description:
 * @author: 微信公众号：码上Java
 * @createDate: 2020/6/29/0029
 * @version: 1.0
 */
@Service("categoryService")
public class CategoryServiceImpl  implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public PageResult getBlogCategoryPage(PageQueryUtil pageUtil) {
        List<Category> categoryList = categoryMapper.findCategoryList(pageUtil);
        int total = categoryMapper.getTotalCategories(pageUtil);
        PageResult pageResult = new PageResult(categoryList, total, pageUtil.getLimit(), pageUtil.getPage());
        return pageResult;
    }

    public Boolean saveCategory(String categoryName, String categoryIcon) {
        Category temp = categoryMapper.selectByCategoryName(categoryName);
        if (temp == null) {
            Category blogCategory = new Category();
            blogCategory.setCategoryName(categoryName);
            blogCategory.setCategoryIcon(categoryIcon);
            return categoryMapper.insertSelective(blogCategory) > 0;
        }
        return false;
    }

    public Boolean deleteBatch(Integer[] ids) {
        if (ids.length < 1) {
            return false;
        }
        //删除分类数据
        return categoryMapper.deleteBatch(ids) > 0;
    }

    @Override
    public Category selectById(int categoryId) {
        return categoryMapper.selectByPrimaryKey(categoryId);
    }


    @Override
    @Transactional
    public Boolean updateCategory(Integer categoryId, String categoryName, String categoryIcon) {
        Category blogCategory = categoryMapper.selectByPrimaryKey(categoryId);
        if (blogCategory != null) {
            blogCategory.setCategoryIcon(categoryIcon);
            blogCategory.setCategoryName(categoryName);
            return categoryMapper.updateByPrimaryKeySelective(blogCategory) > 0;
        }
        return false;
    }
}
