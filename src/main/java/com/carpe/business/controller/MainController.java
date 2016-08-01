package com.carpe.business.controller;

import com.carpe.system.support.util.CommonKey;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 主页控制层
 * Created by wrj on 2016-08-01
 */
@Controller
public class MainController {
    /**
     * 跳转到首页
     * @return
     */
  @RequestMapping("/main.shtml")
  public  String main(HttpSession session){
      if(session.getAttribute(CommonKey.USER_SESSION)==null){
          return  "redirect:login.shtml";
      }
      return  "jsp/main";
  }
}
