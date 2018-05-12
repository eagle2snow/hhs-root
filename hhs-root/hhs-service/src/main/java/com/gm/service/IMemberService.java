package com.gm.service;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import com.github.sd4324530.fastweixin.api.response.GetUserInfoResponse;
import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.base.model.Order;

/**
 * 代码生成器生成代码<br/>
 * IMemberService
 * 
 * @author guet
 *
 */
public interface IMemberService extends IBaseService<Member, Integer> {
	
	/**
	 * @Title: returnMeal   
	 * @Description: 返 5(元/人)
	 * @param mealMemberNumber 直推业务经理人数
	 * @return 套餐金额  
	 * @return: BigDecimal      
	 * @throws
	 */
	BigDecimal returnFiveMoney(Integer mealMemberNumber);
	
	/**
	 * @Title: returnMeal   
	 * @Description: 返套餐金额
	 * @param mealMemberNumber 直推业务经理人数
	 * @return 套餐金额  
	 * @return: BigDecimal      
	 * @throws
	 */
	BigDecimal returnMeal(Integer mealMemberNumber);
	
	
	/**
	 * @Title: tenReturnOne   
	 * @Description: "十送一"
	 * @param memberId 会员ID
	 * @return   商品   
	 * @return: Commodity      
	 * @throws
	 */
	Commodity tenReturnOne(Integer memberId);

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
	 * 
	 * <p>
	 * 描述:购买会员套餐，支付成功
	 * </p>
	 * 
	 * @author 灰灰
	 * 
	 * @date 2018年5月4日
	 * 
	 * @version 1.0
	 */
	void payMemberSuccess(String openid);


	/**
	 * 
	 * <p>
	 * 描述: 获取上一级
	 * </p>
	 * 
	 * @author 灰灰
	 * 
	 * @date 2018年5月4日
	 * 
	 * @version 1.0
	 */
	Member getParent1(Member member);

	/**
	 * <p>
	 * 描述: 获取上两级
	 * </p>
	 * 
	 * @author 灰灰
	 * 
	 * @date 2018年5月4日
	 * 
	 * @version 1.0
	 */
	Member getParent2(Member member);

	/**
	 * 
	 * <p>
	 * 描述:获取上三级
	 * </p>
	 * 
	 * @author 灰灰
	 * 
	 * @date 2018年5月4日
	 * 
	 * @version 1.0
	 */
	Member getParent3(Member member);

}