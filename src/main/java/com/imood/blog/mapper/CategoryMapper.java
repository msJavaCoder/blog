package com.imood.blog.mapper;

import java.util.*;

import com.imood.blog.entity.Category;
import com.imood.blog.util.PageQueryUtil;
import org.apache.ibatis.annotations.Param;

public interface CategoryMapper {
    int deleteByPrimaryKey(Integer categoryId);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(Integer categoryId);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);

    List<Category> findCategoryList(PageQueryUtil pageUtil);

    int getTotalCategories(PageQueryUtil pageUtil);

    Category selectByCategoryName(String categoryName);

    int deleteBatch(Integer[] ids);

}