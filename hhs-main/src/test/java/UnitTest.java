import com.gm.Main;
import com.gm.base.model.Member;
import com.gm.service.impl.MemberServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = Main.class)
public class UnitTest {


    @Resource
    MemberServiceImpl memberService;

    @Test
    public void foo()
    {
        Member member = memberService.get(8);
        Member parent = memberService.getParent(member, 1);
        System.out.println(parent);
        parent = memberService.getParent(member, 2);
        System.out.println(parent);
        parent = memberService.getParent(memberService.get(1), 1);
        parent = memberService.getParent(memberService.get(1), 1);
        System.out.println("parent = " + parent);
    }
}
