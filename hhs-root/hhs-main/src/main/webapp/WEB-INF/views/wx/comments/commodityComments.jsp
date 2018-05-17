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
<%-- <c:forEach items="${orderItems}" var="commodity"> --%>
		<div id="memberId" style="display: none">${orderItems.order.member.id}</div>
		<div id="orderid" style="display: none">${orderItems.id}</div>
		<div id="commodityid" style="display:none ">${orderItems.commodity.id}</div>
<%-- 	<span id="openid"  style="display:none">${commodity.member.openid}</span> --%>
		<!-- 一行 -->
		<div class="simplecutproitem">
			<div class="simplecutpro">
				<div class="simplecutpro_pic"><img src="${orderItems.commodity.imgerPath}" alt=""></div>
				<span class="givescorebox">
					综合评价
					<span class="givescore">
						<i id="xx1" class="givescore_item" ></i>
						<i id="xx2" class="givescore_item" ></i>
						<i id="xx3" class="givescore_item" ></i>
						<i id="xx4" class="givescore_item" ></i>
						<i id="xx5" class="givescore_item" ></i>
					</span>
					
				</span>
			</div>
		</div>
		<!-- end 一行 -->
		<!-- 一行 -->
		<from id="form" method="post">
		<div class="textintbox">
			<textarea id="text" placeholder="点击此处，说说它的优点与美中不足吧~" class="remark_textint textint"></textarea>
			<div class="picthumbs">
				<div class="picthumbitm"><img src="${orderItems.imgerPath}" alt=""></div>
				<div class="picthumbitm"><img src="${orderItems.imgerPath}" alt=""></div>
				<div onclick="pop('data/takephotocpop.html')" class="addpicthumbitm picthumbitm"><input type="file" class="hidel"><i onclick="addImages()" class="takephoto_bsico bsico"></i><p>添加图片</p></div>
			</div>
		</div>
		</from>
		<!-- end 一行 -->
<%-- </c:forEach> --%>
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
		 /* $.getJSON("${ctx}wx/comments/confirmComments/"+a,function (date){
			if(date.msg=='ok'){
				location.href='${ctx}wx/comments/commentSucceed';
			
			}else if(date.msg=='no'){
				location.href='${ctx}wx/comments/commentFailure/'+${orderId};
			
			}else{
				 $.alert("系统出错");
			}	
		});  */
		       alert($("#commodityid").html());   
	 	 $.ajax({
		      type: "POST",
		      url: "${ctx}wx/comments/confirmComments/",
		      data: {"xx":a,"text":$("#text").val(),"memberId":$("#memberId").html(),
		    	  	 "orderid":$("#orderid").html(),"commodityid":$("#commodityid").html()},
		      dataType : "json",
		      success: function(date){
		      alert(date);  
		    	   if(date=='ok'){
						location.href='${ctx}wx/comments/commentSucceed';
					
					}else if(date=='no'){
						location.href='${ctx}wx/comments/commentFailure/'+${orderId};
					
					}else{
						 $.alert("系统出错");
					}	   
		      },
		   });  
		
	}
	
	var a="";
	$('#xx1').click(function(){
		a=1;
		$('#xx1').attr({class:"givescore_item1"});
		$('#xx2').attr({class:"givescore_item"});
		$('#xx3').attr({class:"givescore_item"});
		$('#xx4').attr({class:"givescore_item"});
		$('#xx5').attr({class:"givescore_item"});
		});
	$('#xx2').click(function(){
		a=2;
		$('#xx1').attr({class:"givescore_item1"});
		$('#xx2').attr({class:"givescore_item1"});
		$('#xx3').attr({class:"givescore_item"});
		$('#xx4').attr({class:"givescore_item"});
		$('#xx5').attr({class:"givescore_item"});
		});
	$('#xx3').click(function(){
		a=3;
		$('#xx1').attr({class:"givescore_item1"});
		$('#xx2').attr({class:"givescore_item1"});
		$('#xx3').attr({class:"givescore_item1"});
		$('#xx4').attr({class:"givescore_item"});
		$('#xx5').attr({class:"givescore_item"});
		});
	$('#xx4').click(function(){
		a=4;
		$('#xx1').attr({class:"givescore_item1"});
		$('#xx2').attr({class:"givescore_item1"});
		$('#xx3').attr({class:"givescore_item1"});
		$('#xx4').attr({class:"givescore_item1"});
		$('#xx5').attr({class:"givescore_item"});
		});
	$('#xx5').click(function(){
		a=5;
		$('#xx1').attr({class:"givescore_item1"});
		$('#xx2').attr({class:"givescore_item1"});
		$('#xx3').attr({class:"givescore_item1"});
		$('#xx4').attr({class:"givescore_item1"});
		$('#xx5').attr({class:"givescore_item1"});
		});
	
</script>


</body>
</html>