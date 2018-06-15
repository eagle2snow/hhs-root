import com.gm.Main;
import com.gm.base.model.Member;
import com.gm.service.impl.OrderServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = Main.class)
public class UnitTest {


    @Resource
    OrderServiceImpl orderService;

    @Test
    @Transactional
    public void foo()
    {
        Member member = new Member();
        member.setId(5);
        orderService.finishGoods(member, null);
    }
}
