package cn.msjava.blog.controller.admin;

import cn.msjava.blog.entity.AdminUser;
import cn.msjava.blog.service.AdminUserService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 后台管理员相关操作
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminUserService adminUserService;

    /**
     * 页面跳转
     *
     * @return
     */
    @GetMapping({"", "/", "/index", "/index.html"})
    public String index() {
        return "admin/index";
    }

    /**
     * 页面跳转
     *
     * @return admin/login
     */
    @GetMapping({"/login"})
    public String login() {
        return "admin/login";
    }

    /**
     * 管理员用户登录
     *
     * @param userName   用户名
     * @param password   密码
     * @param verifyCode 验证码
     * @param session
     * @return
     */
    @PostMapping(value = "/login")
    @ApiOperation("管理员登录")
    public String login(@RequestParam("userName") String userName,
                        @RequestParam("password") String password,
                        @RequestParam("verifyCode") String verifyCode,
                        HttpSession session) {
        //验证码是存放在前端存放到session中的，后端取出来进行判断验证码是否正确
        if (StringUtils.isEmpty(verifyCode)) {
            session.setAttribute("errorMsg", "验证码不能为空");
            return "admin/login";
        }

        //判断用户名和密码是否为空
        if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
            session.setAttribute("errorMsg", "用户名或密码不能为空");
            return "admin/login";
        }

        // 在前端的时候放入的session,后端可以从session中取出验证码 ，进行验证
        String kaptchaCode = session.getAttribute("verifyCode") + "";
        //判断验证码是否为空 或者 是否正确
        if (StringUtils.isEmpty(kaptchaCode) || !verifyCode.equals(kaptchaCode)) {
            session.setAttribute("errorMsg", "验证码错误");
            return "admin/login";
        }
        // 拿着用户名和密码到数据库查找该用户
        AdminUser adminUser = adminUserService.login(userName, password);

        // 如果用户存在，存入session当中，并设置session有效期 ，否则登录失败
        if (adminUser != null) {
            //放入session当中
            session.setAttribute("loginUser", adminUser.getNickName());
            session.setAttribute("loginUserId", adminUser.getAdminUserId());
            //session过期时间设置为7200秒 即两小时
            session.setMaxInactiveInterval(60 * 60 * 2);
            //重定向地址跳转  redirect是服务器根据逻辑，发送一个状态码，告诉浏览器重新去请求那个地址，所以地址栏显示的是新的地址。
            return "redirect:/admin/index";
        } else {
            session.setAttribute("errorMsg", "登录失败");
            return "admin/login";
        }
    }


    /**
     * 管理员用户名 、 昵称 修改
     *
     * @param request
     * @return
     */
    @GetMapping("/profile")
    @ApiOperation("用户名昵称修改")
    public String profile(HttpServletRequest request) {
        //先到session 中取出这个用户id
        Integer loginUserId = (int) request.getSession().getAttribute("loginUserId");
        //到数据库中查找这个用户，如果不存在，则需要先登录
        AdminUser adminUser = adminUserService.getUserDetailById(loginUserId);
        if (adminUser == null) {
            return "admin/login";
        }
        request.setAttribute("path", "profile");
        request.setAttribute("loginUserName", adminUser.getLoginUserName());
        request.setAttribute("nickName", adminUser.getNickName());
        return "admin/profile";
    }

    /**
     * 修改密码
     *
     * @param request
     * @param originalPassword 旧密码
     * @param newPassword      新密码
     * @return
     */
    @PostMapping("/profile/password")
    @ResponseBody
    @ApiOperation("管理员用户密码修改")
    public String passwordUpdate(HttpServletRequest request, @RequestParam("originalPassword") String originalPassword,
                                 @RequestParam("newPassword") String newPassword) {
        //判断一下用户名、密码是否为空
        if (StringUtils.isEmpty(originalPassword) || StringUtils.isEmpty(newPassword)) {
            return "输入的参数均不能为空哦";
        }
        // 从session 中取出用户ID
        Integer loginUserId = (int) request.getSession().getAttribute("loginUserId");
        if (adminUserService.updatePassword(loginUserId, originalPassword, newPassword)) {
            //修改成功后清空session之前的用户数据，前端控制跳转至登录页
            request.getSession().removeAttribute("loginUserId");
            request.getSession().removeAttribute("loginUser");
            request.getSession().removeAttribute("errorMsg");
            return "success";
        } else {
            return "修改失败";
        }
    }

    /**
     * 修改用户名 和 昵称
     *
     * @param request
     * @param loginUserName
     * @param nickName
     * @return
     */
    @PostMapping("/profile/name")
    @ResponseBody
    public String nameUpdate(HttpServletRequest request, @RequestParam("loginUserName") String loginUserName,
                             @RequestParam("nickName") String nickName) {
        if (StringUtils.isEmpty(loginUserName) || StringUtils.isEmpty(nickName)) {
            return "参数不能为空";
        }
        Integer loginUserId = (int) request.getSession().getAttribute("loginUserId");
        if (adminUserService.updateName(loginUserId, loginUserName, nickName)) {
            return "success";
        } else {
            return "修改失败";
        }
    }


    /**
     * 退出登录
     *
     * @param request
     * @return
     */
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        //将用户信息从session中移除
        request.getSession().removeAttribute("loginUserId");
        request.getSession().removeAttribute("loginUser");
        request.getSession().removeAttribute("errorMsg");
        return "admin/login";
    }

}
