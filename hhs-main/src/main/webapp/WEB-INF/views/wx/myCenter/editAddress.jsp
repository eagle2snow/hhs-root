<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/wx/global.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>修改收货地址</title>
<%@ include file="/common/wx/mate.jsp"%>
<%@ include file="/common/wx/css.jsp"%>

<style type="text/css">
.Validform_title {
	display: none;
}
</style>

</head>
<body>
	<!-- 中间 -->
	<!-- 一行 -->

	<form class="form" method="post" action="${adp}editAddressAction">
		<input type="hidden" value = "${model.id}" name="id">
		<input type="hidden" value = "${model.member.id}" name="member.id">
		<div class="setlist">
			<div class="setitem">
				<div class="dl">
					<div class="min120 dt">收货人</div>
					<div class="dd">
						<input type="text" value="${model.name}" class="dtint"
							name="name">
					</div>
				</div>
			</div>
			<div class="setitem">
				<div class="dl">
					<div class="min120 dt">联系方式</div>
					<div class="dd">
						<input type="tel" value="${model.mobile}" class="dtint mmobile" name="mobile">
					</div>
				</div>
			</div>
			<div class="setitem">
				<div class="selint dl">
					<div class="min120 dt">省市区/县</div>
					<div class="dd">
						<input type="text" id='city-picker' value="${model.pca}" readonly class="dtint"
							name="pca" />
					</div>
				</div>
			</div>
			<div class="setitem">
				<div class="dd">
					<input type="text" value="${model.address}" class="dtint"
						name="address">
				</div>
			</div>
		</div>
		<div class="cherow">
			<input type="checkbox" id="defautlocal" name="defautlocal"><label
				for="defautlocal">设为默认地址</label>
		</div>
		<div class="mt80 spcbtnrow">
			<div class="spcbtnrow_item">
				<a href="javascript:void(0);" class="primarybtn radiusbtn mdbtn">保存修改</a>
			</div>
		</div>
		<!-- end 一行 -->
		<!--end 中间-->
	</form>
	<%@ include file="/common/wx/js.jsp"%>
	<%@ include file="/common/wx/socket.jsp"%>

	<script src="/static/wx/js/city-picker.min.js" charset="utf-8"></script>
	<script src="/static/plugins/Validform/5.3.2/Validform.min.js"></script>
	<!-- <script src="/static/wx/js/PCASClass.js" charset="GB2312"></script> -->


	<script>
		$("#city-picker").cityPicker({
			title : "请选择收货地址"
		});

		$(".form").Validform({
			btnSubmit : ".primarybtn",
			btnReset : ".secondbtn",
			tiptype : 3,
			ignoreHidden : false,
			dragonfly : false,
			tipSweep : true,
			label : ".label",
			showAllError : true,
			postonce : true,
			ajaxPost : true,
			beforeCheck : function(curform) {
                var str = curform.find('.mmobile')[0].value
                str = str.replace(/\s+/g, "")
                curform.find('.mmobile')[0].value = str
                if (!(/^1[34578]\d{9}$/.test(str))) {
                    $.alert("手机号格式不正确，请重新输入！");
                    return false;
                }
			},
			beforeSubmit : function(curform) {

            },
			callback : function(res) {
				if(res.msg=="ok"){
				   to('${adp}shippingAddress');
				}else{
				   alert("添加失败，请认真填写信息");
				   re();
				}
			}
		});
	</script>



</body>
</html>