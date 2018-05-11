<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/wx/global.jsp"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title></title>
<link rel="stylesheet" type="text/css" href="/static/wx/css/css.css" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta name="format-detection" content="telephone=no" />
<meta name="format-detection" content="email=no" />
<meta name="msapplication-tap-highlight" content="no">
</head>
<body>
<!-- 中间 -->
<!-- 一行 -->
<nav class="htabhd">
	<a ${type==1?'class="on"':'' } href="/wx/myCenter/replyMessage/1">评&ensp;论</a>
	<a ${type==2?'class="on"':'' } href="/wx/myCenter/replyMessage/2">回&ensp;复</a>
</nav>
<!-- end 一行 -->
<!-- 一行 -->

<ul class="mt16 hasmtline comments" ${type==1?'':'style="display:none"'}>
	<c:forEach items="${model}" var="u">
		<li class="comment">
			<div class="comment_mt">
				<div class="comment_avator"><img src="${u.member.iocUrl}" alt=""></div>
				<div class="comment_mtcont">
					<span class="itm">${u.member.nickname }</span>
				</div>
				<span class="date">${u.createTime }</span>
			</div>
			<div class="comment_mc">
				<p class="para">${u.content }</p>
				<a href="###" class="scartpro">
					<div class="scartpro_pic"><img src="{u.commodity.imgerPath }" alt=""></div>
					<div class="scartpro_cont">
						<div class="cuth">{u.commodity.commodityClass.name }</div>
						<div class="cutd">{u.commodity.specifications }</div>
						<div class="cutd"></div>
						<div class="cutd">
							<div class="cutdcont"><ins>&yen;<span class="insm">{u.commodity.showPrice }</span></ins></div>
							<span>x<span class="insm">{u.orderItem.buyCount }</span></span>
						</div>
					</div>
				</a>
			</div>
			<div class="comment_mb">
				<div class="comment_mbcont">
					<span class="vitm"><span class="num">{u.browse }</span>浏览</span>
					<span class="vitm"><span class="num">{u.comment }</span>评论</span>
					<span class="vitm"><span class="num">{u.praise }</span>赞</span>
				</div>
				<a href="###" class="secondlinebtn radiusbtn msbtn">删&nbsp;除</a>
			</div>
		</li>
	</c:forEach>
</ul>

<ul class="mt16 hasmtline comments" ${type==2?'':'style="display:none"'}>
	<c:forEach items="${model}" var="u">
			<li class="comment">
				<div class="comment_mt">
					<div class="comment_avator"><img src="images/portrait/50/01.jpg" alt=""></div>
					<div class="comment_mtcont">
						<span class="itm">${u.member.nickname }</span><big class="itm">回复</big><span class="itm">${u.commodityEvaluation.member.nickname }</span>
					</div>
					<span class="date">${u.createTime }</span>
				</div>
				<div class="comment_mc">
					<div class="quote">${u.commodityEvaluation.evaluationDetails }</div>
					<p class="para">${u.content }</p>
				</div>
				<div class="comment_mb">
					<div class="comment_mbcont">
						<span class="vitm"><span class="num">3.8K</span>浏览</span>
						<span class="vitm"><span class="num">2.1K</span>评论</span>
						<span class="vitm"><span class="num">2150</span>赞</span>
					</div>
					<a href="###" class="secondlinebtn radiusbtn msbtn">删&nbsp;除</a>
				</div>
			</li>
	</c:forEach>
	<!-- <li class="comment">
		<div class="comment_mt">
			<div class="comment_avator"><img src="images/portrait/50/01.jpg" alt=""></div>
			<div class="comment_mtcont">
				<span class="itm">麦田的那边</span><span class="itm">提到了</span><span class="itm">我</span>
			</div>
			<span class="date">2018-04-08  03:05:45</span>
		</div>
		<div class="comment_mc">
			<p class="para">这纸到底怎么样，到底是不是正品？</p>
		</div>
		<div class="comment_mb">
			<div class="comment_mbcont">
				<span class="vitm"><span class="num">3.8K</span>浏览</span>
				<span class="vitm"><span class="num">2.1K</span>评论</span>
				<span class="vitm"><span class="num">2150</span>赞</span>
			</div>
			<a href="###" class="primarylinebtn radiusbtn msbtn">回&nbsp;复</a>
		</div>
	</li> -->
</ul>
<!-- end 一行 -->
<!--end 中间-->



<script>
document.addEventListener("touchstart", function(){}, true);
</script>


</body>
</html>