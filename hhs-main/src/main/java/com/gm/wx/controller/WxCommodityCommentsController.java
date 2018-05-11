package com.gm.wx.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.base.model.CommodityAppraise;
import com.gm.base.model.Order;
import com.gm.base.model.OrderItem;
import com.gm.service.ICommodityAppraiseService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.service.impl.CommodityAppraiseServiceImpl;
import com.gm.service.impl.CommodityEvaluationServiceImpl;

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

	@Autowired
	private IOrderItemService itemService;
	
	@Autowired
	private ICommodityAppraiseService appraiseService;

	@Autowired
	private CommodityEvaluationServiceImpl commodityEvaluationService;
	
	@Autowired
	private CommodityAppraiseServiceImpl appraiseServiceImpl;
	
	@Autowired
	private IOrderService orderService;

	/**
	 * @Title: commentSucceedView
	 * @Description: 提交评价成功页面
	 * @param map
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
		logger.info("toCommondityComment:the args orderId = {}", orderId);

		if (null == orderId) {
			logger.error("toCommondityComment:the args orderId = null");

			return "error/403";

		}

		List<OrderItem> orderItems = itemService.listEq("order.id", orderId);
		logger.info("toCommondityComment:the pojo OrderItem = {}", JSON.toJSON(orderItems));

		map.put("orderItems", orderItems);
		map.put("orderId", orderId);
		map.put("path", PATH);

		return PATH + "commodityComments";
	}

	/**
	 * 
	 *<p>Title:confirmComments</p>
	 *<p>Description:会员评价</p>
	 *
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("confirmComments")
	public String confirmComments(HttpServletRequest request) {
		Map map = request.getParameterMap();
		String xx = request.getParameter("xx");
		String text = request.getParameter("text");
		String memberId = request.getParameter("memberId");
		String orderNo = request.getParameter("orderNo");
		logger.info("request列表 {}.", JSON.toJSONString(map));
		
		Order order = orderService.getOne("orderNo", orderNo);
		
		CommodityAppraise t = new CommodityAppraise();
		t.setContent(text);
		t.setStarLevel(xx);
		t.setOrderNo(orderNo);
		t.setOrder(order);
		t.setMember(this.getCurMember());
		if(appraiseService.add(t)) {
			return "ok";
			
		}else {
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

}
