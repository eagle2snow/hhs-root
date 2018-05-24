<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>直推会员信息</title>
    <%@ include file="/common/admin/head.jsp" %>
</head>
<body>
<section class="content">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>昵称</th>
            <th>性别</th>
            <th>国家</th>
            <th>省份</th>
            <th>城市</th>
            <th>手机号</th>
            <th>最后登录时间</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${direceChild}" var="one">
            <tr>
                <td>${one.nickname}</td>
                <td>${one.gender eq 1?'男':(one.gender eq 2?'女':'不详')}</td>
                <td>${one.country}</td>
                <td>${one.province}</td>
                <td>${one.city}</td>
                <td>${one.mobile}</td>
                <td>${one.loginTime}</td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
</section>
<%@ include file="/common/admin/my_js.jsp" %>
</body>
</html>
