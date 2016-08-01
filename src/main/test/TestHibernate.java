import com.carpe.system.entity.User;
import com.carpe.system.service.OrganizationService;
import com.carpe.system.service.RoleService;
import com.carpe.system.service.UserService;
import com.carpe.system.support.util.Md5Util;
import org.apache.log4j.Logger;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * hibernate测试
 * Created by wrj on 2016-07-06.
 */
public class TestHibernate {
      private  static Logger logger =Logger.getLogger(TestHibernate.class);
      private ClassPathXmlApplicationContext  context=null;
      private UserService userService =null;
      private OrganizationService organizationService =null;
      private RoleService roleService =null;
    {
        context = new ClassPathXmlApplicationContext("spring-hibernate.xml");
        userService =context.getBean(UserService.class);
        organizationService =context.getBean(OrganizationService.class);
        roleService =context.getBean(RoleService.class);
    }

    public  void testSave(){
      organizationService.testSaveOrganization();
        User user = new User();
        user.setLoginName("admin");
        user.setLoginPwd(Md5Util.encrypt("admin"));
        user.setName("超级管理员");
        userService.saveObject(user);
        context.close();
    }
    public static void main(String[] args) {
        TestHibernate testHibernate = new TestHibernate();
        testHibernate.testSave();

    }



}
