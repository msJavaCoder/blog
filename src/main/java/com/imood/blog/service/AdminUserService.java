package com.imood.blog.service;

import com.imood.blog.entity.AdminUser;
import org.apache.ibatis.annotations.Param;

public interface AdminUserService {

    AdminUser login(String userName, String password);

    /**
     * 获取用户信息
     *
     * @param loginUserId
     * @return
     */
    AdminUser getUserDetailById(Integer loginUserId);

    /**
     * 修改当前登录用户的密码
     *
     * @param loginUserId
     * @param originalPassword
     * @param newPassword
     * @return
     */
    Boolean updatePassword(Integer loginUserId, String originalPassword, String newPassword);

    /**
     * 修改当前登录用户的名称信息
     *
     * @param loginUserId
     * @param loginUserName
     * @param nickName
     * @return
     */
    Boolean updateName(Integer loginUserId, String loginUserName, String nickName);

    /**
     *  根据用户名查找用户
     * @param userName
     * @return AdminUser
     */
    AdminUser selectByUsername(@Param("userName") String userName);


}
