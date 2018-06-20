import com.gm.Main;
import com.gm.base.model.Member;
import com.gm.service.impl.MemberServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

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
        MemberServiceImpl.Count count = memberService.new Count();
        List<Integer> chains = new ArrayList<>();
        Member root = count.getRoot(member, chains);
        count.visit(root);
        Map<Integer, Integer> childrenCount = count.getChildrenCount();
        Map<Integer, Integer> direct = count.getDirect();
        for (Integer one : chains) {
            if (one.equals(1)) {
                Member member1 = memberService.get(one);
                member1.setBalance(member1.getBalance().add(BigDecimal.valueOf(10)));
                boolean update = memberService.update(member1);
                System.out.println("update = " + update);
            }
        }


        System.out.println(root);
    }
}
