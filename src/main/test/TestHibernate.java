import com.carpe.system.service.OrganizationService;
import com.carpe.system.service.UserService;
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
    {
        context = new ClassPathXmlApplicationContext("spring-application-context.xml");
        userService =context.getBean(UserService.class);
        organizationService =context.getBean(OrganizationService.class);
    }

    public  void testSave(){
       organizationService.testSaveOrganization();
        context.close();
    }
    public static void main(String[] args) {
        TestHibernate testHibernate = new TestHibernate();
        testHibernate.testSave();

    }



}
