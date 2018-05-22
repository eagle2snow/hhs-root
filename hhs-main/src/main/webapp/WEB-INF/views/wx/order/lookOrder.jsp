<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/common/wx/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>查看订单</title> <%@ include file="/common/wx/mate.jsp"%> 
<%@ include file="/common/wx/css.jsp"%>
<link rel="stylesheet" href="css/order_details.css" />
</head>
<body>

	<!--订单LOGO-->
	<div class="content">
		<img src="img/01.png" /> <span>查看订单</span>
	</div>

	<!--商品-->
	<div class="content1">
		<img src="img/02.png" />
		<ul>
			<li style="padding-top: 2rem;">白酒</li>
			<li style="margin-top: 2.5rem; color: #999999; font-size: 2rem;">9瓶/箱</li>
			<li
				style="margin-top: 2.5rem; border-bottom: 1px solid #eeeeee; height: 5rem;">单价：198<span>X1</span></li>
			<li style="float: right; margin-right: 2rem; margin-top: 2rem;">共1件商品
				总计：￥59.90</li>
		</ul>
	</div>

	<!--价格-->
	<div class="content2">
		<ul>
			<li>运费（快递）<span>￥0.00</span></li>
			<li style="padding-bottom: 1.5rem; padding-top: 1.5rem;">优惠价<span>-￥140.00</span></li>
			<li style="color: #333333; border-bottom: 1px solid #eeeeee;">订单总价<span>￥59.90</span></li>
			<li
				style="color: #333333; padding-bottom: 3rem; padding-top: 3rem; border-bottom: 1px solid #eeeeee;">实付款<span
				style="color: #8fbb26; font-size: 2.5rem;">￥<span
					style="font-size: 3.5rem;">59.90</span></span></li>
			<li style="height: 6rem;"><span class="span2"><img
					src="img/06.png" /><a>个人中心</a></span> <span class="span1"><img
					src="img/05.png" /><a>联系卖家</a></span></li>
		</ul>
	</div>

	<!--单号-->
	<div class="footer">
		<ul>
			<li style="padding-top: 2rem;">订单编号：<span>
					15624598252165362063</span></li>
			<li>微信支付： <span>2018052115624598252165362063</span></li>
			<li>创建时间：<span> 2018-05-21 13：56：55</span></li>
			<li style="margin-bottom: 2rem;">付款时间： <span>2018-05-21
					13：56：55</span></li>
		</ul>
	</div>

</body>
</html>
