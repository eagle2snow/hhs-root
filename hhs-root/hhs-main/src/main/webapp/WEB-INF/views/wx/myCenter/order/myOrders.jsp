<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/wx/global.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>我的订单</title>
<%@ include file="/common/wx/mate.jsp"%>
<%@ include file="/common/wx/css.jsp"%>
</head>
<body>
	<!-- 中间 -->
	<!-- 一行 -->
	<nav class="tabhd">
		<ul class="equaitemline hasline shortabhd">
			<li ${status==0?'class="on"':'' }><a href="${adp}myOrders/0">全部</a></li>
			<li ${status==1?'class="on"':'' }><a href="${adp}myOrders/1">待付款</a></li>
			<li ${status==2?'class="on"':'' }><a href="${adp}myOrders/2">待发货</a></li>
			<li ${status==3?'class="on"':'' }><a href="${adp}myOrders/3">待收货</a></li>
			<li ${status==4?'class="on"':'' }><a href="${adp}myOrders/4">待评价</a></li>
		</ul>
	</nav>
	<!-- end 一行 -->
	<!-- 一行 -->
	<ul class="mt16 orderlist">
		<c:forEach items="${orders }" var='order'>
			<li data-state="finish" class="orderitem" >
				<div class="order_mt">
					<span class="t">订单号：${order.orderNo }</span>
					<div class="order_mtcont">
						<ins>
							&yen;<span class="insm">${order.totalMoney }</span>
						</ins>
					</div>
					<span class="state"> <c:choose>
							<c:when test="${order.status eq 1 }">待付款</c:when>
							<c:when test="${order.status eq 2 }">待发货</c:when>
							<c:when test="${order.status eq 3 }">待收货</c:when>
							<c:when test="${order.status eq 4 }">已收货</c:when>
							<c:when test="${order.status eq 5 }">退换货申请中</c:when>
							<c:when test="${order.status eq 6 }">退换申请通过待发货</c:when>
							<c:when test="${order.status eq 7 }">退换申请通过已发货</c:when>
							<c:when test="${order.status eq 8 }">退换货申请没有通过</c:when>
							<c:when test="${order.status eq 9 }">订单已退款</c:when>
							<c:when test="${order.status eq 10 }">订单已完成</c:when>
						</c:choose>

					</span>
				</div> 
				<c:forEach items='${order.items }' var='item'>
					<div class="order_mc" ${item.appraise eq "1" and status==4? 'style="display:none"':''}>
						<a href="###" class="cartpro">
							<div class="cartpro_pic">
								<img src="${item.imgerPath }" alt="">
							</div>
							<div class="cartpro_cont">
								<div class="cuth">${item.name }</div>
								<div class="cutd">规格：${item.specifications }</div>
								<div class="cutd"></div>
								<div class="cutd">
								
									<div class="cutdcont">
										数量：${item.buyCount }
									</div>
									
									<c:if test="${order.status ne 1 and order.status ne 2 and order.status ne 4}">
										<span onclick="logisticsQuery(${order.id})"  class="defaultlinebtn radiusbtn msbtn">查看物流</span>
									</c:if>
									
									 <c:if test="${order.status==1}">
										<span onclick="payMoney(${order.id})" class="defaultlinebtn radiusbtn msbtn">马上付款</span> 
										<span onclick="cancelOrder(${order.id})" class="defaultlinebtn radiusbtn msbtn">取消订单</span>
									</c:if>
									
									 <c:if test="${order.status==2}">
										<span id="urgent" onclick="urgent(${order.id})"  class="defaultlinebtn radiusbtn msbtn">给我加急</span>
									</c:if>
									
									
									 <c:if test="${order.status==3}">
										<span onclick="confirmGoods(${order.id})"  class="defaultlinebtn radiusbtn msbtn">确认收货</span>
									</c:if>
									
									
									 <c:if test="${order.status==4 and order.appraise==0 }">
										<span onclick="comments(${item.id})" class="defaultlinebtn radiusbtn msbtn" ${item.appraise eq "1"? 'style="display:none"':''}>即刻评价</span>
										<span onclick="toBackOrder(${order.id})" class="defaultlinebtn radiusbtn msbtn">申请售后</span>
									</c:if>
									
									 <c:if test="${order.status==4 and order.appraise==1 }">
										<span <%-- onclick="lookAppraise(${order.id})" --%>  class="defaultlinebtn radiusbtn msbtn">查看评价</span>
										<span onclick="toBackOrder(${order.id})" class="defaultlinebtn radiusbtn msbtn">申请售后</span>
									</c:if>
									
									 <c:if test="${order.status==5}">
										<span  class="defaultlinebtn radiusbtn msbtn">退换货中</span>
									</c:if>
									
									 <c:if test="${order.status==6}">
										<span <%-- onclick="exitGoods(${order.id})" --%>  class="defaultlinebtn radiusbtn msbtn">我要退货</span>
									</c:if>
									
									<c:if test="${order.status==7}">
										<span  class="defaultlinebtn radiusbtn msbtn">待卖家收货</span>
									</c:if>
									
									
									<c:if test="${order.status==8}">
										<span class="defaultlinebtn radiusbtn msbtn">卖家不退货</span>
									</c:if>
									
									<c:if test="${order.status==9}">
										<span class="defaultlinebtn radiusbtn msbtn">退款成功</span>
									</c:if>
									
									<c:if test="${order.status==10}">
										<span class="defaultlinebtn radiusbtn msbtn">订单完成</span>
									</c:if>	
								
								</div>
								
							</div>
						</a>
					</div>
				</c:forEach> 

			</li>
		</c:forEach>

	</ul>
	<!-- end 一行 -->
	<!--end 中间-->

	<%@ include file="/common/wx/js.jsp"%>
	<%@ include file="/common/wx/socket.jsp"%>

	<script>
	
		
		//申请售后 1
		function toBackOrder(orderId){
			location.href='${adp}toBackOrder/'+orderId;
		}	
	
		document.addEventListener("touchstart", function() {
		}, true);
		
		//即刻评价 1
		function comments(orderId){
			//alert(orderId);
			location.href='${ctx}wx/comments/toCommondityComment/'+orderId;
		}
		
		//我要退货 
		function exitGoods(orderId){
			location.href="${ctx}wx/order/exitGoods/"+orderId
		}
		
		//确认收货 
		function confirmGoods(orderId){
			location.href="${ctx}wx/order/confirmGoods/"+orderId
		}
		
		//给我加急
		function urgent(orderId){
			$.getJSON("${ctx}wx/order/urgent/"+orderId,function (data){
				if(data.status){
					$.alert(data.msg);
					var urgent= document.getElementById("urgent");
					urgent.innerHTML("<span class='defaultlinebtn radiusbtn msbtn'>已加急</span>");
				}else{
					$.alert("网络出错，请稍后再试。");
					
				}
			});
		}
		
		//物流查询
		function logisticsQuery(orderId){
			location.href="${ctx}wx/order/logisticsQuery/"+orderId
		}
		
		
		//马上付款 1
		function payMoney(orderId){
			location.href="${ctx}wx/order/confirmOrder/"+orderId
		}
		
		//取消订单 1
		function cancelOrder(orderId){
			
			$.getJSON("${ctx}wx/order/cancelOrder/"+orderId,function (data){
				console.log(data);
				if(data.status == 1){
					layer.msg(data.msg,{icon:6});
					re();
				}
				if(data.status == 2){
					layer.msg(data.msg,{icon:5});
					re();
					
				}
			});
			
		}
	</script>


</body>
</html>