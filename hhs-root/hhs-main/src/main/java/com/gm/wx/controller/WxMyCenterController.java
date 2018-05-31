package com.gm.wx.controller;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.github.sd4324530.fastweixin.api.enums.OauthScope;
import com.github.sd4324530.fastweixin.api.enums.QrcodeType;
import com.github.sd4324530.fastweixin.api.response.QrcodeResponse;
import com.gm.api.sms.BSSendSms;
import com.gm.api.wx.WeiXinApi;
import com.gm.base.consts.Const;
import com.gm.base.model.Member;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.service.impl.CommodityAppraiseServiceImpl;
import com.gm.service.impl.MemberServiceImpl;
import com.gm.utils.StringUtil;
import com.xiaoleilu.hutool.http.HttpUtil;
import com.xiaoleilu.hutool.io.FileUtil;
import com.xiaoleilu.hutool.io.IoUtil;
import com.xiaoleilu.hutool.util.RandomUtil;

/**
 * @author: Ealge
 * @date: 2018年5月8日 上午11:20:30
 * @ClassName: WxMyCenterController
 * @Description:个人中心控制器
 * 
 * @Copyright: 2018 www.gxhhskj.com Inc. All rights reserved.
 *             注意：本内容仅限于广西恒河沙科技有限公司内部传阅，禁止外泄以及用于其他的商业目
 */
@Controller
@RequestMapping("/wx/myCenter/")
public class WxMyCenterController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WxMyCenterController.class);
	private static final String PATH = "wx/myCenter/";

	@Autowired
	private MemberServiceImpl memberService;

	@Autowired
	private CommodityAppraiseServiceImpl commodityAppraiseService;

	@Resource
	private IOrderService orderService;

	@Resource
	private IOrderItemService orderItemService;

	@Resource
	private BSSendSms semdSms;

	/**
	 * 
	 * <p>
	 * Title: toMyCenterIndex
	 * </p>
	 * 
	 * <p>
	 * Description: 首页
	 * </p>
	 * 
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("index")
	public String toMyCenterIndex(ModelMap map, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Member member = getCurMember();
		Member dbmember = memberService.get(member.getId());
		if (dbmember == null)
			logger.info("toMyCenterIndex", "dbmember == null");
		else
			member = dbmember;
		map.put("member", member);

		if (StringUtil.strNullOrEmpty(member.getNickname())) {
			String domain = request.getScheme() + "://" + request.getServerName();
			String currentUrl = request.getRequestURL().toString();
			currentUrl = URLEncoder.encode(currentUrl, "utf-8");
			String url = WeiXinApi.getOauthAPI().getOauthPageUrl(domain + "/wx/getUserInfo", OauthScope.SNSAPI_USERINFO,
					currentUrl);
			response.sendRedirect(url);
		}

		map.put("path", PATH);
		return PATH + "personal";

	}

	/**
	 * 
	 * 
	 * <p>
	 * Title: myMembers
	 * </p>
	 * 
	 * <p>
	 * Description: 我的会员
	 * </p>
	 * 
	 * @param type
	 *            1未购买，2已购买
	 * @param map
	 * @param generalizeId
	 * @return
	 */
	@RequestMapping("myMembers/{type}")
	public String myMembers(ModelMap map, @PathVariable Integer type) {
		List<Member> list = null;
		String generalizeId = getCurMember().getGeneralizeId();
		if (type == 1) {
			list = memberService.list(" from member m where m.deleted=1 and m.referrerGeneralizeId='" + generalizeId
					+ "' and m.setMeal=1");
			logger.info("未购买会员下属列表 {}.", JSON.toJSON(list.size()));
		} else if (2 == type) {
			list = memberService.list(" from member m where m.deleted=1 and m.referrerGeneralizeId='" + generalizeId
					+ "' and (m.setMeal=2 or m.setMeal=3)");
			logger.info("已购买会员下属列表 {}.", JSON.toJSON(list.size()));
		}
		map.put("list", list);
		map.put("path", PATH);
		return PATH + "myMembers";
	}

	/**
	 * @Title: editProfileView
	 * @Description: 修改个人资料请求vies
	 * @param model
	 *            会员信息
	 * @return Map<String,Object>
	 */
	@RequestMapping("editProfileView")
	public String editProfileView(ModelMap map) {
		Member model = memberService.get(this.getMid());
		map.put("path", PATH);
		map.put("model", model);

		return PATH + "editProfile";
	}

	/**
	 * @Title: checkPhone @Description: ajax验证手机号是否已经存在 @return @return:
	 *         Map<String,Object> @throws
	 */
	@ResponseBody
	@PostMapping("checkPhone")
	public Map<String, Object> checkPhone() {

		HashMap<String, Object> map = this.getMap();

		String mobile = this.getRequest().getParameter("mobile");
		logger.info("checkPhone:The paramemter mobile={}", mobile);

		Member member = memberService.getOne("mobile", mobile);

		if (null == member) {
			map.put("msg", "ok");
		} else {
			map.put("msg", "no");

		}

		logger.info("checkPhone:The Map map={}", JSON.toJSON(map));
		return map;

	}

	@ResponseBody
	@GetMapping("getVerificationCode/{mobile}")
	public Map<String, Object> getVerificationCode(@PathVariable String mobile) {
		logger.info("getVerificationCode:The paramemter mobile={}", mobile);

		HashMap<String, Object> map = this.getMap();

		Member curMember = this.getCurMember();
		logger.info("getVerificationCode:The Member curMember={}", JSON.toJSON(curMember));

		String param = RandomUtil.randomNumbers(6);
		Map<String, Object> sendSms = semdSms.sendSms(mobile, param);
		Integer status = (Integer) sendSms.get("status");

		if (status == 1) {

			this.getRequest().getSession().setAttribute(Const.verificationCode2Session, param);

			map.put("status", 1);
			map.put("msg", "验证码发送成功！");
		} else {
			map.put("status", 2);
			map.put("msg", "验证码发送失败！");

		}

		logger.info("getVerificationCode:The Map map={}", JSON.toJSON(map));
		return map;

	}

	/**
	 * @Title: updateAction
	 * @Description: 修改个人资料请求Action
	 * @param model
	 *            会员信息
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping("editProfile/{nickname}/{mobile}/{code}")
	public Map<String, Object> updateAction(@PathVariable String nickname, @PathVariable String mobile,
			@PathVariable String code) {
		logger.info("WxMyCenterController editProfileAction: the args nickname = {},mobile = {}, code = {}", nickname,
				mobile, code);

		Map<String, Object> map = this.getMap();

		Member curMember = this.getCurMember();
		String code2session = (String) this.getRequest().getSession().getAttribute(Const.verificationCode2Session);

		if (!StringUtils.isEmpty(code2session)) {
			if (code2session.equals(code)) {
				this.getRequest().getSession().setAttribute(Const.verificationCode2Session, null);

				curMember.setName(nickname);
				curMember.setMobile(mobile);
				memberService.update(curMember);
				map.put("status", 1);
				map.put("msg", "更改成功！");

			} else {
				map.put("status", 2);
				map.put("msg", "验证码错误，请认真输入！");

			}
		} else {
			map.put("status", 3);
			map.put("msg", "请输入验证码后保存！");

		}

		logger.info("updateAction: the Map to json is {}.", JSON.toJSON(map));

		return map;
	}

	/**
	 * 
	 * <p>
	 * Title:replyMessage
	 * </p>
	 * <p>
	 * Description:我的评论
	 * </p>
	 *
	 * @param map
	 * @param type
	 *            1： 评论 2：回复
	 * @return
	 */
	@RequestMapping("replyMessage/{type}")
	public String replyMessage(ModelMap map, @PathVariable Integer type) {
		Integer memberId = this.getMid();
		map.put("model", commodityAppraiseService.listEqDc("member.id", memberId, "createTime", "desc"));
		map.put("member", memberId);
		map.put("path", PATH);
		logger.info("会员评论列表 {}.",
				JSON.toJSONString(commodityAppraiseService.listEqDc("member.id", memberId, "createTime", "desc")));
		return PATH + "replyMessage";
	}

	/**
	 * 
	 * <p>
	 * Title:deleteComment
	 * </p>
	 * <p>
	 * Description:删除评论
	 * </p>
	 *
	 * @param map
	 * @param type
	 *            id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("deleteComment/{id}")
	public Map<String, Object> deleteComment(@PathVariable Integer id) {

		HashMap<String, Object> map = this.getMap();

		if (commodityAppraiseService.deleteById(id, true)) {
			map.put("status", 1);
			map.put("msg", "删除成功");
		} else {
			map.put("status", 2);
			map.put("msg", "删除失败");
		}

		logger.info("deleteComment:the Map to Json is map = {}", JSON.toJSON(map));

		return map;

	}

	@RequestMapping("genQrcode")
	@ResponseBody
	public String genQrcode(HttpServletRequest request) {
		Member member = getCurMember();
		member = memberService.genCodeAndQrCode(member, request);
		memberService.update(member);
		return member.getQrCode();
	}

	private static Map<Integer, Map<String, Object>> status = new HashMap<>();
	static {
		for (int i = 1; i <=6; ++i) {
			Map<String, Object> m = new HashMap<>();
			m.put("s", String.valueOf(1));
			status.put(i, m);
		}
	}
	/**
	 * @Title: editReferrerAction
	 * @Description: 修改推荐人
	 * @param referrerGeneralizeId
	 *            推荐人推荐ID
	 * @return Map<String,Object> 状态信息
	 */
	@ResponseBody
	@RequestMapping("editReferrerAction/{referrerGeneralizeId}")
	public Map<String, Object> editReferrerAction(@PathVariable String referrerGeneralizeId)
	{
		if (StringUtils.isEmpty(referrerGeneralizeId))
			return status.get(1);
		Member other = memberService.getOne("generalizeId", referrerGeneralizeId);
		if (other == null)
			return status.get(2);

		Member myself = getRealMember();
		if (myself.getChangReferrer().equals(1))
			return status.get(3);

		Member parent = memberService.getParent(other, 1);
		for (Set<Integer> visited = new HashSet<>();
			 parent != null;
			 parent = memberService.getParent(other, 1)) {
			if (parent.getId().equals(other.getId()))
				return status.get(4);
			if (visited.contains(parent.getId()))
				return status.get(5);
			visited.add(parent.getId());
		}

		myself.setReferrerGeneralizeId(referrerGeneralizeId);
		myself.setReferrerNickname(other.getNickname());
		myself.setChangReferrer(1);
		memberService.update(myself);

		return status.get(6);
	}

	/**
	 * <p>
	 * Description: 我的二维码
	 * </p>
	 * 
	 * @param session
	 * @param request
	 * @return
	 */
	/*
	 * @RequestMapping("myQrCode") public String myQrCode(HttpSession session,
	 * HttpServletRequest request) { Member member = getRealMember();
	 * 
	 * if (StringUtil.strNullOrEmpty(member.getQrCode())) {
	 * 
	 * if (!StringUtil.strNullOrEmpty(member.getGeneralizeId())) { member =
	 * memberService.genCodeAndQrCode(member, request);
	 * 
	 * memberService.update(member); session.setAttribute(Const.CUR_WX_MEMBER,
	 * member); } } return PATH + "myQrCode"; }
	 */

	@RequestMapping("myQrCode")
	public String myQrCode(HttpSession session, HttpServletRequest request) {
		Member member = getRealMember();
		if (!StringUtils.isEmpty(member)) {
			String generalizeId = member.getGeneralizeId();
			if (!StringUtil.strNullOrEmpty(generalizeId)) {
				if (!StringUtil.strNullOrEmpty(member.getQrCode())) {
					LocalDateTime lastUpdateQrCode = member.getLastUpdateQrCode();
					if (null == lastUpdateQrCode || lastUpdateQrCode.plusDays(25).isBefore(LocalDateTime.now())) {
						genQrCode(session, request, member, generalizeId);
					}
				} else {
					genQrCode(session, request, member, generalizeId);
				}
			}
		}
		return PATH + "myQrCode";
	}

	// 生成二维码
	private void genQrCode(HttpSession session, HttpServletRequest request, Member member, String generalizeId) {
		QrcodeResponse qrcode = WeiXinApi.getQrcodeAPI().createQrcode(QrcodeType.QR_SCENE, generalizeId, 2592000);
		String path = request.getServletContext().getRealPath(File.separator) + File.separator;
		path = path + "static" + File.separator + "member" + File.separator + "qrcode" + File.separator + generalizeId
				+ ".png";
		HttpUtil.downloadFile("https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + qrcode.getTicket(), path);
		member.setLastUpdateQrCode(LocalDateTime.now());
		member.setQrCode("/static/member/qrcode/" + generalizeId + ".png");
		memberService.update(member);
		session.setAttribute(Const.CUR_WX_MEMBER, member);
	}

}
