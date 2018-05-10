package com.gm.service;

import com.gm.service.IBaseService;

import java.util.List;
import java.util.Map;

import com.gm.base.enums.MsgTypeEnum;
import com.gm.base.model.Msg;

/**
 * 代码生成器生成代码<br/>
 * IMsgService
 * 
 * @author hw
 *
 */
public interface IMsgService extends IBaseService<Msg, Integer> {

	/**
	 * 获取聊天记录
	 * 
	 * @param userId
	 *            客服id
	 * @param memberId
	 *            会员id
	 * @return
	 */
	List<Msg> listOurChatMsgs(Integer userId, Integer memberId);

	/**
	 * 客服发消息给会员
	 * 
	 * @param userId
	 *            客服id
	 * @param memberId
	 *            会员 id
	 * @param type
	 *            消息类型
	 * @param text
	 *            消息内容
	 * @return
	 */
	Map<String, Object> snedToMember(Integer userId, Integer memberId, MsgTypeEnum type, String text);

	/**
	 * 会员发消息给客服
	 * 
	 * @param memberId
	 *            会员id
	 * @param userId
	 *            客服id
	 * @param type
	 *            消息类型
	 * @param text
	 *            消息内容
	 * @return
	 */
	Map<String, Object> snedToKf(Integer memberId, Integer userId, MsgTypeEnum type, String text);

	/**
	 * 通过会员获取聊天记录
	 * 
	 * @param memberId
	 *            会员id
	 * @return
	 */
	List<Msg> listMsgByMember(Integer memberId);

	/**
	 * 客服获取所有会员的发来的未读消息
	 * 
	 * @return
	 */
	List<Msg> getNotReadMemberToKfMsgs();

	/**
	 * 发送输入框文本消息给客服
	 * 
	 * @param msg
	 */
	void sendInputTextMsgToKf(Msg msg);

}