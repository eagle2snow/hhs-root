package com.gm.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.ansj.domain.Result;
import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.api.websocket.WebSokectMsgSender;
import com.gm.base.consts.Const;
import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.IMsgDao;
import com.gm.base.enums.MsgCatEnum;
import com.gm.base.enums.MsgTypeEnum;
import com.gm.base.model.AutoMsg;
import com.gm.base.model.Msg;
import com.gm.service.IAutoMsgService;
import com.gm.service.IMsgService;
import com.gm.utils.StringUtil;

@Transactional
@Service("msgSercive")
public class MsgServiceImpl extends BaseServiceImpl<Msg, Integer> implements IMsgService {
	@Resource
	private IMsgDao dao;

	@Resource
	private IAutoMsgService autoMsgService;

	@Resource
	private WebSokectMsgSender sender;

	@Override
	public IBaseDao<Msg, Integer> getDao() {
		return dao;
	}

	@Override
	public List<Msg> listOurChatMsgs(Integer userId, Integer memberId) {
		List<Msg> list = list(" from msg b where ( b.fromId=" + userId + " and b.toId=" + memberId + ") or ( b.fromId="
				+ memberId + " and b.toId=" + userId + ") order by id asc");
		return list;
	}

	@Override
	public Map<String, Object> snedToMember(Integer userId, Integer memberId, MsgTypeEnum type, String text) {

		Map<String, Object> map = new HashMap<>();
		Msg msg = new Msg();
		msg.setFromId(userId);
		msg.setToId(memberId);
		msg.setContent(text);
		msg.setType(type);
		msg.setCat(MsgCatEnum.KF_TO_MEMBER);
		if (save(msg)) {
			sender.send(msg);
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	@Override
	public Map<String, Object> snedToKf(Integer memberId, Integer userId, MsgTypeEnum type, String text) {
		Map<String, Object> map = new HashMap<>();
		Msg msg = new Msg();
		msg.setFromId(memberId);
		msg.setToId(userId);
		msg.setContent(text);
		msg.setType(type);
		msg.setCat(MsgCatEnum.MEMBER_TO_KF);
		if (save(msg)) {
			sender.send(msg);
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	@Override
	public List<Msg> listMsgByMember(Integer memberId) {
		List<Msg> list = list(
				" from msg b where ( b.toId=" + memberId + ") or ( b.fromId=" + memberId + ") order by id asc");
		return list;
	}

	@Override
	public List<Msg> getNotReadMemberToKfMsgs() {
		List<Msg> list = list(" from msg m where m.cat='" + MsgCatEnum.MEMBER_TO_KF + "' and m.readed=1");
		return list;
	}

	@Override
	public void sendInputTextMsgToKf(Msg msg) {
		String str = msg.getContent();

		Result result = ToAnalysis.parse(str); // 分词结果的一个封装，主要是一个List<Term>的terms
		List<Term> terms = result.getTerms(); // 拿到terms

		List<String> termsList = terms.parallelStream().filter(p -> {
			String name = p.getName();
			String natureStr = p.getNatureStr();
			return name.length() > 1 && !"null".equals(natureStr) && !"w".equals(natureStr);
		}).map(Term::getName).collect(Collectors.toList());

		List<AutoMsg> autoMsgs = autoMsgService.list();
		StringBuilder sb = new StringBuilder();

		for (AutoMsg autoMsg : autoMsgs) {
			if (!StringUtil.strNullOrEmpty(autoMsg.getKeyz())) {
				List<String> keys = Arrays.asList(autoMsg.getKeyz().split("，"));
				for (String t : termsList) {
					if (keys.contains(t)) {
						String msgHtm = "<li><a href='javascript:void(0);' onClick='showContent(\"" + autoMsg.getName()
								+ "\",\" " + autoMsg.getContent() + " \")'><p>" + autoMsg.getName() + "</p></a></li>";
						sb.append(msgHtm);
					}
				}
			}
		}

		save(msg);
		sender.send(msg);// 发给客服
		try {
			Thread.currentThread().sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		if (sb.length() > 0) {
			sb.insert(0, "<div class=\"chat_faqbox\"><div class=\"chat_faq_dt\">请选择</div><ul class=\"chat_faqlist\">");
			sb.append("</ul></div>");
			Msg msg2 = new Msg();
			msg2.setCat(MsgCatEnum.KF_TO_MEMBER);
			msg2.setType(MsgTypeEnum.TEXT);
			msg2.setFromId(msg.getToId());
			msg2.setToId(msg.getFromId());
			msg2.setContent(sb.toString());
			save(msg2);
			sender.send(msg2);
			sender.sendToUrl(msg2, Const.SEND_NEW_MSG_TO_KF + msg2.getFromId());
		}
	}
}