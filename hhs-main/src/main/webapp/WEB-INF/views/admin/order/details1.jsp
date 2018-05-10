<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>订单表 </title>

<%@ include file="/common/admin/head.jsp"%>


</head>

<body>
	<section class="content" style="width: 90%">
	<form class="form-horizontal" method="post" id="form-admin-add" action="${adp}update.json">
		<input type="hidden" name="id" value="${model.id}"/>	
		<div class="row">
			<div class="col-md-12">
			
			<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">订单详情</h3>
					</div>
													

                     
                        
						
						
									<div >
										<div ><br>
												<c:if test="${model.status == '0'}">待付款</c:if>
												<c:if test="${model.status == '1'}">待发货</c:if>
												<c:if test="${model.status == '2'}">待收货</c:if>
												<c:if test="${model.status == '3'}">已收货</c:if>
												<c:if test="${model.status == '4'}">退换货申请中</c:if>
												<c:if test="${model.status == '5'}">退换货申请通过，待买家发货</c:if>
												<c:if test="${model.status == '6'}">退换货申请通过，买家已发货</c:if>
												<c:if test="${model.status == '7'}">退换货申请不通过</c:if>
												<c:if test="${model.status == '8'}">订单已退款</c:if>
												<c:if test="${model.status == '9'}">订单已完成</c:if> <br>
											 	订单金额(含运费)：¥${model.totalMoney}
										</div>
								
								</div>
								
								<div >
										<div ><hr>
												
										</div>
								
								</div>
                        
			                
			                
			                <div >
										<div >
										${model.member.name}<br>
										</div>
								</div>
								
								<div >
										<div >
										${model.memberAddress.province},	
										${model.memberAddress.city},
										${model.memberAddress.area},
										${model.memberAddress.address}<br><hr>
										</div>
								</div>
								
								<div >
										<div >
								        	竹语优品<br><hr>
								        	<div style="float: left;"><img src="${model.commodity.imgerPath}" ></div>
								        	<div >
								        	
											<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${model.commodity.name}： <span style="float:right">¥${model.commodity.showPrice}</span><br><br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;规格： <span style="float:right">x${model.cart.buyCount}</span><br><br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：${model.commodity.showRemarks}<span style="float:right">${model.commodity.showRemarks}</span>
												<th></th>
											</tr> 
											</div>
								      			<hr>					        		
										</div>
								</div>
								
								
								<div >
										<div >
										商品小计
										<span style="float:right">¥${model.totalMoney}</span>
										</div>
								</div>
								
								<div >
										<div >
										运费
										<span style="float:right">¥${model.commodity.freight}</span>	
										</div>
								</div>
			                
							    <div >
										<div >
										实付费(含运费)
										<span style="float:right">¥${model.totalMoney}${model.commodity.freight}</span><hr>	
										</div>
								</div>
								
							
							
							   <div >
										<div >
										订单编号：${model.id}	
										</div>
								</div>
								
								<div >
										<div >
										创建时间：${model.createTime}<hr>	
										</div>
								</div>
								
								<div >
										<div >
										备注：${model.orderRemarks}<hr>	
										</div>
								</div>
							
				
							
							
			                
							<div class="box-body">
							<div class="form-group">
								<div >
									<!-- <button type="submit" class="btn_sub btn btn-success">提交</button> -->
									<button type="button" onClick="closeAll();" class="btn_reset btn btn-primary">关闭</button>
								</div>
							</div>
						</div>
				</div>
					<!--end .box .box-info -->
				
					</div> 
					<!--end .col-md-12-->
				</div>
				 <!-- end .row -->
	</form>
</section>	
			<%@ include file="/common/admin/my_js.jsp"%>
				 



	<script>
		 $(".form-horizontal").Validform({
			btnSubmit: ".btn_sub",
			btnReset: ".btn_reset",
			tiptype: 3,
			ignoreHidden: false,
			dragonfly: false,
			tipSweep: true,
			label: ".label",
			showAllError: false,
			postonce: true,
			ajaxPost: true,

			beforeCheck: function (curform) {
				//在表单提交执行验证之前执行的函数，curform参数是当前表单对象。
				//这里明确return false的话将不会继续执行验证操作;	
			},
			beforeSubmit: function (curform) {
				//在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
				//这里明确return false的话表单将不会提交;
				var time = $('.auto-kal');
				 	$('#paymentTime').val(time);
				 	$('#shipmentsTime').val(time);
				 	$('#receivingTime').val(time);
				 	$('#applyForTime').val(time);
				 	$('#checkTime').val(time);
				 	$('#buyerDshipmentsTime').val(time);
				 	$('#refundTime').val(time);
				 	$('#finishTime').val(time);
				 	$('#appraiseTime').val(time);
			},	
			callback : updateResult
		});
		
			
		
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
	</script>	
	</body>
</html>
					
