package com.carpe.system.support.shiro;

import com.carpe.system.entity.User;
import com.carpe.system.service.UserService;
import com.carpe.system.support.util.CommonKey;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;

/**
 * shiro权限配置
 * Created by wrj on 2016-07-30
 */
public class UserRealm extends AuthorizingRealm {
     @Resource
    private UserService userService;
    /**
     * 授权
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //获取用户信息的所有资料，如权限角色等.
        //info.setStringPermissions(权限集合);
        //info.setRoles(角色集合);
        return info;

    }

    /**
     * 认证
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        String loginName =upToken.getUsername();
        String pwd = String.valueOf(upToken.getPassword());
        User user = userService.getUserByLoginName(loginName);
        if (null != user) {
            if (user.getStatus() == CommonKey.USER_DISABLED_BYTE) {
                throw new LockedAccountException(); // 帐号锁定
            }
            if (!pwd.equals(user.getLoginPwd())) {
                throw new AuthenticationException(); // 密码不正确
            }
            return new SimpleAuthenticationInfo(loginName, pwd, getName());
        } else {
            throw new UnknownAccountException();// 没找到帐号
        }
    }
}
