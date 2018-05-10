<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/wx/global.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>商品评价</title>
<%@ include file="/common/wx/mate.jsp"%>
<%@ include file="/common/wx/css.jsp"%>
</head>
<body>
<!-- 中间 -->
<!-- 一行 -->
<div class="mbox">
<c:forEach items="${orderItems}" var="commodity">
		<!-- 一行 -->
		<div class="simplecutproitem">
			<div class="simplecutpro">
				<div class="simplecutpro_pic"><img src="${commodity.imgerPath}" alt=""></div>
				<span class="givescorebox">
					综合评价
					<i class="givescore">
						<i class="givescore_item"></i>
						<i class="givescore_item"></i>
						<i class="givescore_item"></i>
						<i class="givescore_item"></i>
						<i class="givescore_item"></i>
					</i>
				</span>
			</div>
		</div>
		<!-- end 一行 -->
		<!-- 一行 -->
		<div class="textintbox">
			<textarea placeholder="点击此处，说说它的优点与美中不足吧~" class="remark_textint textint"></textarea>
			<div class="picthumbs">
				<div class="picthumbitm"><img src="${commodity.imgerPath}" alt=""></div>
				<div class="picthumbitm"><img src="${commodity.imgerPath}" alt=""></div>
				<div onclick="pop('data/takephotocpop.html')" class="addpicthumbitm picthumbitm"><input type="file" class="hidel"><i onclick="addImages()" class="takephoto_bsico bsico"></i><p>添加图片</p></div>
			</div>
		</div>
		<!-- end 一行 -->
</c:forEach>
</div>
<!-- end 一行 -->
<!--end 中间-->
<!-- 底部 -->
<div class="fbottom">
	<nav class="btool">
		<div class="btool_halfcont"><a onclick="confirmComments()" class="primarybtn btoolbtn">确认评价</a></div>
	</nav>
</div>
<!--end 底部-->

<%@ include file="/common/wx/js.jsp"%>
<%@ include file="/common/wx/socket.jsp"%>

<script src="/static/wx/js/tool.js"></script>

<script type="text/javascript">

	function addImages(){
		
	}

	function confirmComments(){
		$.getJSON("${ctx}wx/comments/confirmComments",function (date){
			if(date.msg=='ok'){
				location.href='${ctx}wx/comments/commentSucceed';
			
			}else if(date.msg=='no'){
				location.href='${ctx}wx/comments/commentFailure/'+${orderId};
			
			}else{
				 $.alert("系统出错");
			}	
		});
	}
</script>


</body>
</html>