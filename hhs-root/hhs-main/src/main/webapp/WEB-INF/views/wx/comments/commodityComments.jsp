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

    <div>
        <img id="img1" hidden="hidden">
        <img id="img2" hidden="hidden">
        <img id="img3" hidden="hidden">
        <img id="img4" hidden="hidden">
        <img id="img5" hidden="hidden">
    </div>
    <img src="/static/wx/images/icon/cam.png" alt="  " id="cam">
    <div>
        <input id="upload1" name="file" accept="image/*" type="file" style="display: none">
        <input id="upload2" name="file" accept="image/*" type="file" style="display: none">
        <input id="upload3" name="file" accept="image/*" type="file" style="display: none">
        <input id="upload4" name="file" accept="image/*" type="file" style="display: none">
        <input id="upload5" name="file" accept="image/*" type="file" style="display: none">
    </div>


</div>
<div class="fbottom">
    <nav class="btool">
        <div class="btool_halfcont"><a onclick="confirmComments()" class="primarybtn btoolbtn">确认评价</a></div>
    </nav>
</div>

<%@ include file="/common/wx/js.jsp" %>
<%@ include file="/common/wx/socket.jsp" %>

<script src="/static/wx/js/tool.js"></script>
<script src="/static/tools/imageOp.js"></script>
<script type="text/javascript">
    const MAX_IMG = 5
    var imgCount = 0
    $(function () {
        $("#cam").click(function () {
            const input = $("#upload" + (imgCount + 1))
            if (imgCount >= MAX_IMG) {
                $.alert("最多只能上传" + MAX_IMG + "张图片!!!")
                return false
            }
            input.change(function() {
                if (imgCount >= MAX_IMG) {
                    $.alert("最多只能上传" + MAX_IMG + "张图片!")
                    return false
                }
                alert(this.files[0].name + "   " + this.files.length)
                const url = getObjectURL(this.files[0])
                const img = $("#img" + (imgCount + 1))
                img.attr("src", url).attr("width", "100rem").show()
                imgCount += 1
            })
            input.click()
        })
    });

    let kkk = 1
    function makePromise(file, form) {
        return new Promise((resolve) => {
            const fileSize = file.size / 1024
            if (fileSize > 100) {
                photoCompress(file, {
                    quality: 0.2
                }, function (base64Codes) {
                    const compressed = convertBase64UrlToBlob(base64Codes)
                    form.append(kkk, compressed, kkk);
                    ++kkk
                    resolve()
                })
            } else {
                form.append(kkk, file, kkk)
                ++kkk
                resolve()
            }
        })
    }

    let clicked = false
    function confirmComments() {
        const text = $("#text").val()
        if (text == "" || $.trim(text) == '') {
            $.alert("请输入评价内容", "提示");
            return
        }
        if (clicked) {
        	$.alert('正在上传文件  请稍等 ')
        	return
        }
        clicked = true

        const form = new FormData()
        const promises = []
        for (let i = 1; i <= imgCount; ++i) {
            const files = document.getElementById("upload" + i).files
            promises.push(makePromise(files[0], form, i * 100))
        }

        form.append("xx", a)
        form.append("text", text)
        form.append("memberId", $("#memberId").html())
        form.append("orderid", $("#orderid").html())
        form.append("commodityid", $("#commodityid").html())
        Promise.all(promises).then(() => {
            $.ajax({
                url : "${ctx}wx/comments/confirmComments",
                type : 'POST',
                data : form,
                contentType: false,
                processData: false,
                dataType: 'json',
                success: function(data) {
                    if (data == 'ok')
                        location.href = '${ctx}wx/comments/commentSucceed'
                    else
                        location.href = '${ctx}wx/comments/commentFailure/' +${orderId};
                },
                error: function() {
                    $.alert('系统出错　请稍后再试')
                }
            });
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