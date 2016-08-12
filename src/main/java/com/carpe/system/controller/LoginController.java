package com.carpe.system.controller;

import com.carpe.system.entity.Organization;
import com.carpe.system.entity.User;
import com.carpe.system.service.UserService;
import com.carpe.system.support.util.CommonKey;
import com.carpe.system.support.util.CommonUtils;
import com.carpe.system.support.util.Md5Util;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 登录控制器
 * Created by wrj on 2016-07-28
 */
@Controller
public class LoginController {
    @Resource
    private UserService userService;
    /**
     * 跳转到登录页
     * @param request
     * @return
     */
    @RequestMapping(value ="/login.html",method = RequestMethod.GET)
    public String login(HttpServletRequest request){
        User curuser =userService.getUserByLoginName("admin");
        if(curuser==null){
            User user = new User();
            user.setLoginName("admin");
            user.setLoginPwd(Md5Util.encrypt("admin"));
            user.setName("超级管理员");
            Organization organization = new Organization();
            organization.setName("系统管理员");
            organization.setPid(0L);
            user.setOrganization(organization);
            userService.saveObject(user);
        }
         return  "login";
    }

    /**
     * 验证登录
     * @param loginName  登录名
     * @param password  密码
     * @param validateCode  验证码
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/login.html",method = RequestMethod.POST)
    public String login(String loginName, String password, String validateCode, HttpServletRequest request, HttpSession session, Model model){
        if(StringUtils.isEmpty(loginName) || StringUtils.isEmpty(password)){
            return CommonUtils.msgCallback(false,"登录用户名和密码不能为空",null,null);
        }
        password = Md5Util.encrypt(password);
        UsernamePasswordToken upToken =new UsernamePasswordToken(loginName,password);
        //subject权限对象
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(upToken);
        }catch(UnknownAccountException e){
          upToken.clear();
            return  CommonUtils.msgCallback(false,"账号不存在",null,null);
        } catch (LockedAccountException e) {
            upToken.clear();
            return  CommonUtils.msgCallback(false,"账号已经被锁定，请与管理员联系！",null,null);
        } catch (AuthenticationException e) {
            upToken.clear();
            return  CommonUtils.msgCallback(false,"用户名和密码不匹配",null,null);
        }
        User user =userService.getUserByLoginName(loginName);
        session.setAttribute(CommonKey.USER_SESSION,user);
        session.setAttribute(CommonKey.USER_SESSION_ID,user.getId());
        return CommonUtils.msgCallback(true,"main.html",null,null);
    }


}
