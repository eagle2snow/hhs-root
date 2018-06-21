<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/common/wx/global.jsp" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>明细</title>
		<link rel="stylesheet" type="text/css" href="/static/wx/css/bill.css" />
		<%@ include file="/common/wx/mate.jsp" %>

	</head>

	<body>

		<div class="content">
			<ul>
				<!--         <li id="list01"> -->
				<!--             <span class="sx">筛选 <img src="/static/wx/images/bill/bf01.png"/></span> -->
				<!--             <span class="fl">分类 <img src="/static/wx/images/bill/bf01.png"/></span> -->
				<!--         </li> -->
				<li class="beny">
					<span class="dangy">本月</span>
					<span class="span01">支出 <span class="span02">
						¥${outManoy > 0 ? outManoy : 0.00}
					</span> 收入 <span class="span02">
						¥${inManoy > 0 ? inManoy : 0.00}
					</span>
					</span>
				</li>
				<c:forEach items="${bills}" var='bill'>
					<li class="zhangd">
						<span>
		            		<c:if test="${bill.type == 1}">佣金</c:if>
			                <c:if test="${bill.type == 2}">佣金</c:if>
			                <c:if test="${bill.type == 3}">佣金</c:if>
			                <c:if test="${bill.type == 4}">佣金</c:if>
			                <c:if test="${bill.type == 6}">佣金</c:if>
			                <c:if test="${bill.type == 7}">买商品</c:if>
			                <c:if test="${bill.type == 8}">买套餐</c:if>
			                <c:if test="${bill.type == 9}">提现</c:if>
	                		<span class="jine"><span class="span03">
				                <c:if test="${bill.type == 1}">${bill.money}</c:if>
				                <c:if test="${bill.type == 2}">${bill.money}</c:if>
				                <c:if test="${bill.type == 3}">${bill.money}</c:if>
				                <c:if test="${bill.type == 4}">${bill.money}</c:if>
				                <c:if test="${bill.type == 6}">${bill.money}</c:if>
			                	<c:if test="${bill.type == 7}">-${bill.money}</c:if>
			                	<c:if test="${bill.type == 8}">-${bill.money}</c:if>
			                	<c:if test="${bill.type == 9}">-${bill.money}</c:if>
                				</span>元</span>
							</span>
						<br/>
						<span>
                			<span class="date">
                				<javatime:format value="${bill.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                			</span>
							<span class="nickname" style="color: rgb(240, 173, 78)">
								<c:if test="${bill.status eq 1 }">[直推]</c:if>
								<c:if test="${bill.status eq 2 }">[直系]</c:if>
							</span>
							<span class="nickname">
								${bill.selfName}
							</span>
						</span> 
					</li>
				</c:forEach>
			</ul>
		</div>
		<!-- <div class="saix"> -->
		<!--     <ul> -->
		<!--         <li onclick="thisMonth()">本月</li> -->
		<!--         <li>近一个月</li> -->
		<!--         <li>近三个月</li> -->
		<!--     </ul> -->
		<!-- </div> -->

		<!-- <div class="fenl"> -->
		<!--     <ul> -->
		<!--         <li>支出</li> -->
		<!--         <li>收入</li> -->
		<!--     </ul> -->
		<!-- </div> -->

		<%@ include file="/common/wx/js.jsp" %>
		<%@ include file="/common/wx/socket.jsp" %>

		<script>
			$(document).ready(function() {
				$(".sx").click(function() {
					$(".saix").slideToggle(300);
					$(".fenl").css("display", "none");
				});
				$(".fl").click(function() {
					$(".fenl").slideToggle(300);
					$(".saix").css("display", "none");
				});
			})
		</script>
		<script>
			//  本月
			function thisMonth() {
				$.getJSON("${adp}wx/myCenter/thisMonth",
					function(date) {
						alert(date.msg);
					});
			}
		</script>
	</body>

</html>