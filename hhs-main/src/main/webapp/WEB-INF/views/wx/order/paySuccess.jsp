<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>支付成功</title>
<%@ include file="/common/wx/mate.jsp"%>
<%@ include file="/common/wx/css.jsp"%>
</head>
<body>
<!-- 中间 -->
<!-- 一行 -->
<div class="showdtlist wpbox">
	<div class="showdtitem">
		<a href="###" class="dl">
			<p>
				<span class="secondtxt">购买套餐</span>后，再次消费所有商品，<span
					class="secondtxt">一律八折</span>
			</p>
		</a>
	</div>
</div>
<!-- end 一行 -->
<!-- 一行 -->
<ul class="stepbar">
	<li class="active cart stepbaritem"></li>
	<li class="active edit stepbaritem"></li>
	<li class="active success stepbaritem"></li>
</ul>
<!-- end 一行 -->
<!-- 一行 -->
<div class="ntbox">
	<div class="ntbox_dt"><i class="md_success_ntico ntico"></i>支付成功</div>
	<div class="ntbox_dd">本次付款金额：<ins>&yen;<span class="insm">${amount}</span></ins></div>
</div>
<div class="mt80 spcbtnrow">
	<div class="spcbtnrow_item"><a href="/wx/index" class="secondbtn mdbtn">继续逛逛</a></div>
	<div class="spcbtnrow_item"><a href="/wx/order/lookOrder/${orderId}" class="primarybtn mdbtn">查看订单</a></div>
</div>
<!-- end 一行 -->
<!--end 中间-->



<script>
document.addEventListener("touchstart", function(){}, true);
</script>


</body>
</html>