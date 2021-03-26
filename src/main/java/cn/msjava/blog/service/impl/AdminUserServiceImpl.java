package cn.msjava.blog.service.impl;

import cn.msjava.blog.entity.AdminUser;
import cn.msjava.blog.util.MD5Util;
import cn.msjava.blog.mapper.AdminUserMapper;
import cn.msjava.blog.service.AdminUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminUserServiceImpl implements AdminUserService {

    @Resource
    private AdminUserMapper adminUserMapper;

    /**
     *   用户登录
     * @param userName
     * @param password
     * @return
     */
    @Override
    public AdminUser login(String userName, String password) {
        String passwordMd5 = MD5Util.MD5Encode(password, "UTF-8");
        return adminUserMapper.login(userName, passwordMd5);
    }


    /**
     * 根据id 查看用户信息
     * @param loginUserId
     * @return
     */
    @Override
    public AdminUser getUserDetailById(Integer loginUserId) {
        return adminUserMapper.selectByPrimaryKey(loginUserId);
    }

    /**
     *  更新用户密码
     * @param loginUserId   用户id
     * @param originalPassword   旧密码
     * @param newPassword   新密码
     * @return
     */
    @Override
    public Boolean updatePassword(Integer loginUserId, String originalPassword, String newPassword) {
        //先查看一下该用户是否存在
        AdminUser adminUser = adminUserMapper.selectByPrimaryKey(loginUserId);
        //当前用户非空才可以进行更改
        if (adminUser != null) {
            // 原始密码进行md5加密处理
            String originalPasswordMd5 = MD5Util.MD5Encode(originalPassword, "UTF-8");
            String newPasswordMd5 = MD5Util.MD5Encode(newPassword, "UTF-8");
            //比较原密码是否正确
            if (originalPasswordMd5.equals(adminUser.getLoginPassword())) {
                //设置新密码并修改
                adminUser.setLoginPassword(newPasswordMd5);
                if (adminUserMapper.updateByPrimaryKeySelective(adminUser) > 0) {
                    //修改成功则返回true
                    return true;
                }
            }
        }
        return false;
    }

    /**
     *  修改用户昵称
     * @param loginUserId
     * @param loginUserName
     * @param nickName
     * @return
     */
    @Override
    public Boolean updateName(Integer loginUserId, String loginUserName, String nickName) {
        AdminUser adminUser = adminUserMapper.selectByPrimaryKey(loginUserId);
        //当前用户非空才可以进行更改
        if (adminUser != null) {
            //设置昵称并修改
            adminUser.setLoginUserName(loginUserName);
            adminUser.setNickName(nickName);
            if (adminUserMapper.updateByPrimaryKeySelective(adminUser) > 0) {
                //修改成功则返回true
                return true;
            }
        }
        return false;
    }
}
