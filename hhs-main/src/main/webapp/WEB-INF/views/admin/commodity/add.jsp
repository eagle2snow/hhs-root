<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>商品表新增 </title>

<%@ include file="/common/admin/head.jsp"%>

</head>

<body>
	<section class="content">
	<form class="form-horizontal" method="post" id="form-admin-add" action="${adp}add.json">
		<div class="row">
			<div class="col-md-12">
			
			<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">添加</h3>
					</div>
						 	
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label"><i class="red">*</i>名称:</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" 
								        placeholder="名称" id="name" name="name" datatype="*" errormsg="请输入名称"         />
									</div>
								</div>
							</div>	
                        
						
						
						
                        
                        
						<div class="box-body">
									<div class="form-group">
										<label class="col-sm-2 control-label"><i class="red">*</i>归类:</label>
										<div class="col-sm-8">
											<select name="code" style="width: 100% !important;" class="form-control select2" id="code">
													<option >
														
													</option>
												
													<option value="1">
														抽纸
													</option>
													<option value="2">
														手帕纸
													</option>
 
											</select>
										</div>
									</div>
								</div>
							
							
							
							
							
						 	
                        
						
						
						
                        
	                 <!--            <div class="box-body">
	                               <div class="form-group">
										<label class="col-sm-2 control-label">内容:</label>
										<div class="col-sm-8">
											 <script id="content" name="content" type="text/plain" class="ue-editor" style="width: 100%; height: 400px;"></script>
										</div>
									</div>
								</div> -->
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                        
                        
						
								<div class="box-body">
									<div class="form-group">
										<label class="col-sm-2 control-label">分类:</label>
										<div class="col-sm-8">
											<select name="commodityClass.id" style="width: 100% !important;" class="form-control select2" id="commodityClass">
												<c:forEach items="${commodityClassList}" var="m">
												
													<option value="${m.id}">
														${m.name}
													</option>
												</c:forEach> 
											</select>
										</div>
									</div>
								</div>
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品主页显示价格:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品主页显示价格" id="showPrice" name="showPrice"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品主页显示折扣价:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品主页显示折扣价" id="showDiscount" name="showDiscount"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品主页显示原价:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品主页显示原价" id="originalPrice" name="originalPrice"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品邮费:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品邮费" id="freight" name="freight"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品备注:</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" 
								        placeholder="商品备注" id="remarks" name="remarks"           />
									</div>
								</div>
							</div>	
                        
						
						
						
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品总库存:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品总库存" id="totalStock" name="totalStock"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
	                        <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品主页显示图片:</label>
									<div class="col-sm-8">
									
									
										<input class="file" type="file" id='imgerPath'> <input
											name="imgerPath" id="imgerPath_input" type="hidden" />
										<div style="overflow: hidden;" class="imgerPath"></div>
									</div>
								</div>
							</div>
						
						
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						<div class="box-body">
						    <div class="form-group">
									<label class="col-sm-2 control-label">商品图片展示列表:</label>
									<div class="col-sm-8">
										<input class="files" type="file" id='imgeListShow' multiple> <input
											name="imgeListShow" id="imgeListShow_input" type="hidden" />
										<div style="overflow: hidden;" class="imgeListShow"></div>
									</div>
								</div>
						</div>
						
					
						
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                        
                        
						
							
							
							
								<div class="box-body">
									<div class="form-group">
										<label class="col-sm-2 control-label">是否是活动商品:</label>
										<div class="col-sm-8">
											<label><input value="1" type="radio" class="minimal" name="activity">是</label>
											<label><input value="2" type="radio" class="minimal" name="activity">否</label>
										</div>
									</div>
								</div>
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品销量:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品销量" id="salesVolume" name="salesVolume"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品多少件包邮:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品多少件包邮" id="freePostage" name="freePostage"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品成本:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="商品成本" id="cost" name="cost"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">评价数量:</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="评价数量" id="appraiseCount" name="appraiseCount"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">商品在前台显示的备注:</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" 
								        placeholder="商品在前台显示的备注" id="showRemarks" name="showRemarks"           />
									</div>
								</div>
							</div>	
                        
						
						
						
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">默认重量:</label>
									<div class="col-sm-8">
										<input type="text" class="form-control"
							        	placeholder="默认重量" id="defaultWeight" name="defaultWeight"          />
									</div>
								</div>
							</div>
                        
                        
						
							
							
							
							
							
						 	
                        
						
						
						
                            <div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">默认体积:</label>
									<div class="col-sm-8">
										<input type="text" class="form-control"
							        	placeholder="默认体积" id="defaultBulk" name="defaultBulk"          />
									</div>
								</div>
							</div>
							
							
							
							
							
							
							
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">规格:</label>
									<div class="col-sm-8">
										<input type="text" class="form-control"
							        	placeholder="规格" id="specifications" name="specifications"          />
									</div>
								</div>
							</div>
                        
                        
						
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">提成(元):</label>
									<div class="col-sm-8">
										<input type="number" class="form-control"
							        	placeholder="提成" id="extract" name="extract"          />
									</div>
								</div>
							</div>
							
							
							
							
							<div class="box-body">
							<div class="form-group">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-8">
									<button type="submit" class="btn_sub btn btn-success">提交</button>
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
			},		
			callback : addResult
		});
		
				 	var ue =  UE.getEditor('content');
		
		
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
	</script>	
	</body>
</html>
					
