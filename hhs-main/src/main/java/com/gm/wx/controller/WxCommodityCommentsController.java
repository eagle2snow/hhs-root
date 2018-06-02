package com.gm.wx.controller;

import java.io.File;
import java.io.IOException;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.gm.base.model.*;
import com.gm.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.service.ICommodityAppraiseService;
import com.gm.service.ICommodityService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.service.impl.CommodityAppraiseServiceImpl;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author eagle
 * @date 2018年5月3日
 * @description 商品评价控制器
 */
@Controller
@RequestMapping("wx/comments/")
public class WxCommodityCommentsController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WxCommodityCommentsController.class);
	private static final String PATH = "wx/comments/";

	@Resource
	private IOrderItemService itemService;

	@Autowired
	private ICommodityAppraiseService appraiseService;


	@Autowired
	private CommodityAppraiseServiceImpl appraiseServiceImpl;

	@Autowired
	private IOrderService orderService;

	@Autowired
	private ICommodityService commodityService;

	/**
	 * @Title: commentSucceedView
	 * @Description: 提交评价成功页面
	 * @return String
	 */
	@RequestMapping("commentSucceed")
	public String commentSucceedView() {

		return PATH + "commentSucceed";
	}

	/**
	 * @Title: commentFailureView
	 * @Description: 提交评价失败页面
	 * @param map
	 * @return String
	 */
	@RequestMapping("commentFailure/{orderId}")
	public String commentFailureView(@PathVariable String orderId, ModelMap map) {

		map.put("orderId", orderId);

		return PATH + "commentFailure";
	}

	/**
	 * @Title: toCommondityComment
	 * @Description: 去评价页面并显示商品图片
	 * @param map
	 * @param orderId
	 * @return String
	 */
	@RequestMapping("toCommondityComment/{orderId}")
	public String toCommondityComment(ModelMap map, @PathVariable Integer orderId) {

		if (null == orderId) {
			logger.error("toCommondityComment:the args orderId = null");

			return "error/403";

		}

		Order order = orderService.get(orderId);
		if (null !=order) {
			order.setAppraiseTime(new Date());
			order.setAppraise(1);
		}

		// List<OrderItem> orderItems = itemService.listEq("order.id", orderId);
		OrderItem orderItems = itemService.getOne("id", orderId);

		map.put("orderItems", orderItems);
		map.put("orderId", orderId);
		map.put("path", PATH);



		return PATH + "commodityComments";
	}

	//@RequestMapping("uploadFile")
	public String uploadFile(@RequestParam(value = "uploadFile") MultipartFile image, Integer orderId)
	{
		if (orderId == null)
			return "redirect:/error/404";
        try {
            if (File.separator.equals("/")) {
            	String fileName = String.format("/usr/static/comment/%s%s", orderId, image.getName());
                File file = new File(fileName);
                image.transferTo(file);
            } else
                logger.error("windows platform");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("uploadFile error", e);
            return "redirect:../commentFailure/" + orderId;
        }
        return "redirect:../commentSucceed";
	}

	@ResponseBody
	@RequestMapping("confirmComments")
	public String confirmComments(String xx, String text, Integer commodityid, Integer orderid)
	{
		OrderItem orderItem = itemService.getOne("id", orderid);
		if ("1".equals(orderItem.getAppraise()))
			return "no";

		Commodity commodity = commodityService.get(commodityid);
		Order order = orderService.get(orderItem.getOrder().getId());
		Member member = WXHelper.getMember(getCurMember());

		if (!member.getId().equals(order.getMember().getId())) {
			logger.error("!curMember.getId().equals(order.getMember().getId())");
			return "no";
		}

		CommodityAppraise t = new CommodityAppraise();
		t.setContent(text);
		t.setStarLevel(xx);
		t.setOrderItem(orderItem);
		t.setMember(member);
		t.setCommodity(commodity);

		if (appraiseService.add(t)) {
			if (commodity.getComment() != null)
				commodity.setComment(commodity.getComment() + 1);
			else
				commodity.setComment(1);
			commodityService.update(commodity);
			orderItem.setAppraise("1");
			itemService.update(orderItem);
			return "ok";
		} else {
			return "no";
		}
	}

	@RequestMapping("myComments")
	public String myComments(ModelMap map) {

		map.put("model", appraiseServiceImpl.listEq("openId", this.getMid()));
		map.put("member", this.getMid());
		map.put("path", PATH);
		logger.info("商品评论列表 {}.", JSON.toJSONString(appraiseServiceImpl.listEq("openId", this.getMid())));

		return PATH + "myComments";
	}

	/**
	 *
	 *<p>Title:allComments</p>
	 *<p>Description:查看全部评论</p>
	 *
	 * @param map
	 * @param type 商品id
	 * @return
	 */
	@RequestMapping("allComments/{type}")
	public String allComments(ModelMap map, @PathVariable Integer type) {
		map.put("model", appraiseService.listEqDc("commodity.id", type, "createTime", "desc"));
		map.put("path", PATH);
		map.put("cid", type);

		return PATH + "allComments";
	}
}
