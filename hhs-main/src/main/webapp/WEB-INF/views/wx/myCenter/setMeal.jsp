<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/common/wx/global.jsp"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>购买套餐</title>
<%@ include file="/common/wx/mate.jsp"%>
<%@ include file="/common/wx/css.jsp"%>
</head>
<body>
<!-- 中间 -->
<!-- 一行 -->
<ul class="toselist">
	<li class="toselitem">
		<input type="radio" checked="checked" id="tosel01" name="tosel">
		<label for="tosel01" class="toselabel">
			<div class="toselabel_cont">
				<div class="name">竹语会员</div>
				<div class="info">成为会员，享受专属福利</div>
			</div>
			<span class="price"><ins>3500元</ins>/1套</span>
		</label>
	</li>
	<li class="toselitem">
		<input type="radio" id="tosel02" name="tosel">
		<label for="tosel02" class="toselabel">
			<div class="toselabel_cont">
				<div class="name">竹语会员</div>
				<div class="info">成为会员，享受专属福利</div>
			</div>
			<span class="price"><ins>3500元</ins>/1套</span>
		</label>
	</li>
</ul>
<!-- end 一行 -->
<!-- 一行 -->
<section class="binsbox">
	<h3 class="binsbox_dt">VIP专享分红佣金：</h3>
	<ul class="decimalist">
		<li>购买首页套餐成为会员</li>
		<li>会员直推10个会员，反自身全部套餐款作为佣金</li>
		<li>下级：不管下多少级，满足直推人员到10人，直系团队总人数到100人开始，以后每加1人，获得5元佣金。（特别说明：下级团队中的任意一个点，团队数满足100人，立即脱离上级团队）</li>
		<li>
			<div>满足条件：</div>
			<p>A、直推30人</p>
			<p>B、下级团队人数满1000人（包含脱离出去的）</p>
			<p>C.、推得团队中有3个人满足100人下级</p>
		</li>
		<li>会员升级后做在会员中心醒目位置坐LOGO标注</li>
	</ul>
</section>
<!-- end 一行 -->
<!--end 中间-->
<!-- 底部 -->
<div class="fbottom">
	<nav class="btool">
		<div class="btool_halfcont"><a onclick="setMeal()" class="primarybtn btoolbtn">立&nbsp;即&nbsp;购&nbsp;买</a></div>
	</nav>
</div>
<!--end 底部-->
<%@ include file="/common/wx/js.jsp"%>
<%@ include file="/common/wx/socket.jsp"%>
<script src="${ctx}static/wx/js/tool.js"></script>

<script>
document.addEventListener("touchstart", function(){}, true);

function goMyCenterPage() {
	window.location.href ="${ctx}wx/myCenter/index";//个人中心
} 
function goIndexPage() {
	window.location.href ="${ctx }wx/index";//首页
} 
	

function setMeal(){
	
	$.getJSON("${adp}setMealAction/${member.id}",function (date){
		
		if(date.msg == "ok"){
			$.alert("您已经购买套餐,请勿重新购买!", "温馨提示",function (){
				window.location.href ="${ctx }wx/index";//首页
			});
		
		}else if(date.msg == "no"){
			$.alert("恭喜您成为:业务经理!", "温馨提示",function (){
				window.location.href ="${ctx}wx/myCenter/index";//个人中心
			}); 
		
		}else{
			$.alert("网络出错,请稍后再试!", 2000);
			re();
			
		}
	});
}
</script>


</body>
</html>