package com.gm.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import com.github.sd4324530.fastweixin.api.response.GetUserInfoResponse;
import com.gm.base.model.Member;
import com.gm.base.model.PayBill;

/**
 * 代码生成器生成代码<br/>
 * IMemberService
 * 
 * @author guet
 *
 */
public interface IMemberService extends IBaseService<Member, Integer> {
	/**
	 * @Title: returnMeal @Description: 返套餐金额 @param mealMemberNumber
	 *         直推业务经理人数 @return 套餐金额 @return: BigDecimal @throws
	 */
	void returnMeal(String openId);

	/**
	 * @Title: tenReturnOne @Description: "十送一" @param memberId 会员ID @return
	 *         商品 @return: Commodity @throws
	 */
	void tenReturnOne(Integer orderId);

	/**
	 * 
	 * <p>
	 * Title: saveWeixinMember
	 * </p>
	 * 
	 * <p>
	 * Description: 保存微信会员
	 * </p>
	 * 
	 * @param openid
	 * @return
	 */
	Member saveWeixinMember(String openid);

	/**
	 * 
	 * <p>
	 * Title: saveWeixinMember
	 * </p>
	 * 
	 * <p>
	 * Description: 保存微信会员
	 * </p>
	 * 
	 * @param response
	 * @return
	 */
	Member saveWeixinMember(GetUserInfoResponse response);

	/**
	 * <p>
	 * Title: updateWeixinMember
	 * </p>
	 * 
	 * <p>
	 * Description: 更新微信会员
	 * </p>
	 * 
	 * @param member
	 * @param response
	 * @return
	 */
	Member updateWeixinMember(Member member, GetUserInfoResponse response);

	/**
	 * 
	 * <p>
	 * Title: genCodeAndQrCode
	 * </p>
	 * 
	 * <p>
	 * Description: 生成推广码和二维码，二维码保存路径到硬盘
	 * </p>
	 * 
	 * @param member
	 * @param request
	 * @return
	 */
	Member genCodeAndQrCode(Member member, HttpServletRequest request);

	/**
	 * <p>
	 * Title: genCodeAndQrCode
	 * </p>
	 * 
	 * <p>
	 * Description: 生成推广码和二维码，二维码为base64，保存到数据库
	 * </p>
	 * 
	 * @param member
	 * @return
	 */
	Member genCodeAndQrCode(Member member);

	/**
	 * 描述:购买会员套餐，支付成功
	 */
	void payMemberSuccess(String openid, PayBill payBill);

	/**
	 * 获取会员level级上家
	 * 例如 level == 1 是上家
	 * 		level == 2 是上上家
	 * @param member
	 * @param level
	 */
	Member getParent(Member member, int level);

	/**
	 * 获取会员level级下家
	 * 例如 level == 1 也称为直推会员
	 * @param member
	 * @param level
	 */
	List<Member> getChildren(Member member, int level);

	/**
	 * 获取直系会员
	 *
	 */
	List<Member> getIndirectChildren(Member member);

	/**
	 *<p>Title:updateGeneralizeCost</p>
	 *<p>Description:下家购买商品返上家订单总额1%到推广费</p>
	 *
	 * @param referrerGeneralizeId 推广id
	 * @param multiply 本次获得推广费
	 */
	void updateGeneralizeCost(String referrerGeneralizeId, BigDecimal multiply);


	/**
	 * 获取一个会员的所有下家个数
	 * @param memento 加速用 notnull
	 * @member 会员
	 */
	int getChildrenCount(Member member, Map<Integer, Integer> memento, Set<Integer> visited, Set<Integer> add);

	Member saveWeixinMember(String openid, String referrerGeneralizeId);

}