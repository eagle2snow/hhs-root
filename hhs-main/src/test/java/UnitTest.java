import com.gm.Main;
import com.gm.base.model.Member;
import com.gm.service.impl.MemberServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;


@RunWith(SpringRunner.class)
@SpringBootTest(classes = Main.class)
public class UnitTest {


    @Resource
    MemberServiceImpl memberService;

    @Test
    public void foo()
    {
        Member member = memberService.get(8);
        memberService.new Count().iterator(member, (m) -> {
            System.out.println(m.getId());
        });
    }
}
