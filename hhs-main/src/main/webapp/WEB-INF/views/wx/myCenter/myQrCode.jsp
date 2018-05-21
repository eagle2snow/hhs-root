<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/wx/global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>我的二维码</title>
<link rel="stylesheet" type="text/css" href="/static/wx/css/css.css" />

<%@ include file="/common/wx/mate.jsp"%>
<%@ include file="/common/wx/css.jsp"%>

</head>
<body>
	<!-- 中间 -->
	<!-- cpop -->
	<div class="show cpop">
		<div class="cpopcenter">
			<div class="centerntbox">
				<div class="centernthead">
					<div class="tr">
						<span class="avator150"><img
							src="${curMember.iocUrl}" alt=""></span>
					</div>
					<div class="tr">
						<span class="name">${curMember.nickname}</span>
					</div>
				</div>
				<div class="myqrcodebox">
					<img src="${curMember.qrCode }" alt="">
				</div>
				<div class="ac dtrins">扫描二维码关注【竹语商城】</div>
			</div>
		</div>
	</div>
	<!-- cpop -->
	<!--end 中间-->

	<%@ include file="/common/wx/js.jsp"%>
	<%@ include file="/common/wx/socket.jsp"%>

	<script>
	 var qrCode = "${curMember.qrCode}";
	 console.log(qrCode);
	 if(!qrCode){
		 $.alert('您还没有消费体验产品 <br>不能使用二维码');
	 }
	
		document.addEventListener("touchstart", function() {
		}, true);
	</script>


</body>
</html>