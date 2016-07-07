import com.carpe.system.entity.User;
import com.carpe.system.service.UserService;
import com.carpe.system.support.log.SystemLog;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * hibernate测试
 * Created by wrj on 2016-07-06.
 */
public class TestHibernate {
      private ApplicationContext  context=null;
      private UserService userService =null;
    {
        context = new ClassPathXmlApplicationContext("spring-application-context.xml");
        userService =context.getBean(UserService.class);
    }
    @SystemLog(methods = "菜单管理-新增菜单")
    public  void testSave(){
        User user =new User();
        userService.saveObject(user);
        user.setName("wangrenju4");
    }

    public static void main(String[] args) {
        TestHibernate testHibernate = new TestHibernate();
        testHibernate.testSave();

    }



}
