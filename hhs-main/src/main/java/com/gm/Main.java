package com.gm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.base.model.Member;
import com.gm.service.IMemberService;

@SpringBootApplication
@ServletComponentScan
@EnableTransactionManagement
@Controller
public class Main extends SpringBootServletInitializer {

	@Resource
	private IMemberService memberService;

	/**
	 * 用外部tomcat启动
	 */

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(Main.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(Main.class, args);
	}

	@RequestMapping("/test/{id}")
	@ResponseBody
	public String index(@PathVariable Integer id) {
		Member m = memberService.get(id);
		List<Member> members = memberService.getAllSons(m);
		// for (Member member : members) {
		// System.out.println(member.getId());
		// }
		// List<Member> members1 = memberService.getSons1(m);
		// for (Member member : members1) {
		// System.err.println(member.getId());
		// }
		return JSON.toJSONString(members);
	}

}
