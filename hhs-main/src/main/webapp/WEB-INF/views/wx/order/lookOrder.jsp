<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/wx/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>查看订单</title>
<%@ include file="/common/wx/mate.jsp"%>
<%@ include file="/common/wx/css.jsp"%>
<link rel="stylesheet" href="/static/wx/css/order_details.css" />
</head>
<body>

	<!--订单LOGO-->
	<div class="content">
		<img src="/static/wx/images/details/01.png" /> <span>查看订单</span>
	</div>

	<!--商品-->
	<div class="content1">

		<c:forEach items="${items}" var="oneItem">
			<div class="item">
				<img src=${oneItem["imgerPath"]} />
				<ul>
					<li>${oneItem["name"]}</li>
					<li style="margin-top: 1rem; color: #999999; font-size: 1.3rem;">
						${oneItem["specifications"]}</li>
					<li style="margin-top: 1rem; height: 5rem;">单价：${oneItem["originalPrice"]}<span>X
							${oneItem["buyCount"]}</span></li>
				</ul>
			</div>
		</c:forEach>

		<div
			style="width: 100%; height: 6rem; background: #fff; margin-top: 0.1rem;">
			<span
				style="float: right; margin-right: 2rem; margin-top: 2rem; font-size: 1.5rem">共
				${itemSize} 件商品 总计：￥ ${sum}</span>
		</div>
	</div>

	<!--价格-->
	<div class="content2">
		<ul>
			<li>运费（快递）<span>￥0.00</span></li>
			<li style="padding-top: 1.5rem;">优惠价<span>-￥ ${discount}
			</span></li>
			<li style="color: #333333; padding-bottom: 1.5rem">订单总价<span>￥
					${order["totalMoney"]}</span></li>
		</ul>
	</div>


	<div
		style="width: 100%; height: 4rem; background: #fff; margin-top: 0.1rem;">
		<span style="color: #333333; font-size: 1.5rem; margin-left: 2rem;">实付款</span>
		<span style="color: #8fbb26; font-size: 1.5rem; margin-left: 57%;">￥
			<span style="font-size: 2.5rem;">${order["totalMoney"]}</span>
		</span>


		<div
			style="width: 100%; height: 6rem; padding-top: 1rem; background: #fff; margin-top: 0.4rem;">
			<span class="span1"><img
				src="/static/wx/images/details/contentSeller.png" /><a>联系卖家</a></span> <span
				class="span2"><img
				src="/static/wx/images/details/personal.png" /><a>个人中心</a></span>
		</div>

	</div>

	<!--单号-->
	<div class="footer">
		<ul>
			<li style="padding-top: 2rem;">订单编号：<span>${order["orderNo"]}</span></li>
			<li>微信支付：<span>${order["orderNo"]}</span></li>
			<li>创建时间：<span> ${order["createTime"]}</span></li>
			<li style="margin-bottom: 2rem;">付款时间： <span>2018-05-21
					13：56：55</span></li>
		</ul>
	</div>

</body>
</html>
