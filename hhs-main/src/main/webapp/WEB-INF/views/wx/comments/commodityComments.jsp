<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/wx/global.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>商品评价</title>
    <%@ include file="/common/wx/mate.jsp" %>
    <%@ include file="/common/wx/css.jsp" %>
</head>
<body>
<div class="mbox">
    <div id="memberId" style="display: none">${orderItems.order.member.id}</div>
    <div id="orderid" style="display: none">${orderItems.id}</div>
    <div id="commodityid" style="display:none ">${orderItems.commodity.id}</div>
    <div class="simplecutproitem">
        <div class="simplecutpro">
            <div class="simplecutpro_pic"><img src="${orderItems.commodity.imgerPath}" alt=""></div>
            <span class="givescorebox">
					综合评价
					<span class="givescore">
						<i id="xx1" class="givescore_item"></i>
						<i id="xx2" class="givescore_item"></i>
						<i id="xx3" class="givescore_item"></i>
						<i id="xx4" class="givescore_item"></i>
						<i id="xx5" class="givescore_item"></i>
					</span>
            </span>
        </div>
    </div>
    <form id="form" method="post">
        <div class="textintbox">
            <textarea id="text" placeholder="点击此处，说说它的优点与美中不足吧~" class="remark_textint textint"></textarea>
            <div class="picthumbs">
                <div class="picthumbitm"><img src="${orderItems.imgerPath}" alt=""></div>
                <div class="picthumbitm"><img src="${orderItems.imgerPath}" alt=""></div>
            </div>
        </div>
    </form>

    <form id="uploadFile" enctype="multipart/form-data" action="${ctx}wx/comments/uploadFile/" method="post">
        <input type="file" name="uploadFile" class="takephoto_bsico bsico">
        <input type="text" hidden="hidden" class="orderid" name="orderId">
        <p>添加图片</p>
    </form>

    <form id="takenPicture" enctype="multipart/form-data" action="${ctx}wx/comments/uploadFile/" method="post">
        <input type="file" id='image' accept="image/*" capture='camera'>
        <input type="text" hidden="hidden" class="orderid" name="orderId">
        <p>照相机</p>
    </form>
</div>
<div class="fbottom">
    <nav class="btool">
        <div class="btool_halfcont"><a onclick="confirmComments()" class="primarybtn btoolbtn">确认评价</a></div>
    </nav>
</div>

<%@ include file="/common/wx/js.jsp" %>
<%@ include file="/common/wx/socket.jsp" %>

<script src="/static/wx/js/tool.js"></script>
<script type="text/javascript">
    function confirmComments() {
        if ($("#text").val() == "" || $.trim($("#text").val()) == '') {
            $.alert("请输入评价内容", "提示");
            return
        }

        new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: "${ctx}wx/comments/confirmComments/",
                data: {
                    "xx": a,
                    "text": $("#text").val(),
                    "memberId": $("#memberId").html(),
                    "orderid": $("#orderid").html(),
                    "commodityid": $("#commodityid").html()
                },
                dataType: "json",
                success: data => {
                    resolve(data)
                },
                error: data => {
                    $.alert('系统出错　请稍后再试')
                }
            })
        }).then(data => {
            if (data == 'ok') {
                let id = $("#orderid").html()
                let order = $(".orderid")
                order[0].value = id
                order[1].value = id

                var selectedPic = $("#uploadFile input")[0]
                if (selectedPic.files.length > 0) {
                    $("#uploadFile").submit()
                } else {
                    var takenPicture = $("#takenPicture input")[0]
                    if (takenPicture.files.length > 0)
                        takenPicture.submit()
                    else
                        location.href = '${ctx}wx/comments/commentSucceed';
                }
            } else
                location.href = '${ctx}wx/comments/commentFailure/' +${orderId};
        }).catch(data => {
            $.alert('系统出错　请稍后再试')
        })
    }

    var a = "";
    $('#xx1').click(function () {
        a = 1;
        $('#xx1').attr({class: "givescore_item1"});
        $('#xx2').attr({class: "givescore_item"});
        $('#xx3').attr({class: "givescore_item"});
        $('#xx4').attr({class: "givescore_item"});
        $('#xx5').attr({class: "givescore_item"});
    });
    $('#xx2').click(function () {
        a = 2;
        $('#xx1').attr({class: "givescore_item1"});
        $('#xx2').attr({class: "givescore_item1"});
        $('#xx3').attr({class: "givescore_item"});
        $('#xx4').attr({class: "givescore_item"});
        $('#xx5').attr({class: "givescore_item"});
    });
    $('#xx3').click(function () {
        a = 3;
        $('#xx1').attr({class: "givescore_item1"});
        $('#xx2').attr({class: "givescore_item1"});
        $('#xx3').attr({class: "givescore_item1"});
        $('#xx4').attr({class: "givescore_item"});
        $('#xx5').attr({class: "givescore_item"});
    });
    $('#xx4').click(function () {
        a = 4;
        $('#xx1').attr({class: "givescore_item1"});
        $('#xx2').attr({class: "givescore_item1"});
        $('#xx3').attr({class: "givescore_item1"});
        $('#xx4').attr({class: "givescore_item1"});
        $('#xx5').attr({class: "givescore_item"});
    });
    $('#xx5').click(function () {
        a = 5;
        $('#xx1').attr({class: "givescore_item1"});
        $('#xx2').attr({class: "givescore_item1"});
        $('#xx3').attr({class: "givescore_item1"});
        $('#xx4').attr({class: "givescore_item1"});
        $('#xx5').attr({class: "givescore_item1"});
    });

</script>


</body>
</html>