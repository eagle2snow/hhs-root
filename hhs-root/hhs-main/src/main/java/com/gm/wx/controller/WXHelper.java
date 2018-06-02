package com.gm.wx.controller;

import com.gm.base.model.Member;
import com.gm.service.IMemberService;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

@Component
public class WXHelper {

    @Resource
    private IMemberService memberService;

    private static WXHelper self;

    @PostConstruct
    public void init()
    {
        self = this;
    }

    public static Member getMember(Member member)
    {
        String openid = member.getOpenid();
        member = self.memberService.get(member.getId());
        if (member == null)
            member = self.memberService.getOne("openid", openid);
        return member;
    }
}
