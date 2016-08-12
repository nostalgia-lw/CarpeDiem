package com.carpe.business.controller;

import com.carpe.system.support.util.CommonKey;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 主页控制层
 * Created by wrj on 2016-08-01
 */
@Controller
public class MainController {
    /**
     * 跳转到主页
     * @return
     */
    @RequestMapping("/main.html")
    public  String main(HttpSession session, Model model){
        if(session.getAttribute(CommonKey.USER_SESSION)==null){
            return  "redirect:login.html";
        }
        return  "jsp/main";
    }

    /**
     * 加载主页内容
     * @return
     */
    @RequestMapping("/index.html")
    public  String index(Model model){
        return  "jsp/index";
    }

    /**
     * 退出
     * @param session
     * @return
     */
    @RequestMapping("/logout.html")
    public  String  logout(HttpSession session){
        session.removeAttribute(CommonKey.USER_SESSION);
        session.removeAttribute(CommonKey.USER_SESSION_ID);
        return "redirect:login.html";
    }
}
