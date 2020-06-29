package com.imood.blog.mapper;

import com.imood.blog.entity.AdminUser;
import org.apache.ibatis.annotations.Param;

public interface AdminUserMapper {
    int deleteByPrimaryKey(Integer adminUserId);

    int insert(AdminUser record);

    int insertSelective(AdminUser record);

    AdminUser selectByPrimaryKey(Integer adminUserId);

    int updateByPrimaryKeySelective(AdminUser record);

    int updateByPrimaryKey(AdminUser record);


    AdminUser login(@Param("userName") String userName, @Param("password") String password);


    AdminUser selectByUsername(@Param("userName") String userName);
}