<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/retrievePwd.css" type="text/css">

</head>
<body style="margin: 0px;background:#EBEEF5;">
<div class="container">
    <h1>找回密码</h1>
    <br>
    <form id="myForm" action="${pageContext.request.contextPath}/user/revisePwd" method="post">
        <br>
        <span class="p">*</span>
        <label for="username">用户名</label>
        <input type="text" name="username" id="username" placeholder="" class="register" value="${user.username}"
               style="width: 50%">
        <br><br>
        <span class="p">*</span>
        <label for="newpwd">新密码</label>
        <input type="password" name="password" id="newpwd" class="register" style="width: 50%"><br><br>
        <span class="q">*</span>
        <label for="repwd">确认密码</label>
        <input type="password" id="repwd" class="register" style="width: 50%"><br><br>
        <div class="msg">
            <span id="attention" style="color: crimson;font-size: 1.8rem;"></span>
        </div>
        <br><br>
        <input type="button" name="" value="提交" class="submit" onclick="retrieve()"><br>
    </form>
</div>
<script type="text/javascript">
    var checkPassword = document.getElementById('checkPwd')
    var waitTime = 60;
    var attention = document.getElementById("attention")

    function retrieve() {
        var username = document.getElementById("username").value;
        var pwd = document.getElementById("newpwd").value;
        var repwd = document.getElementById("repwd").value;
        if (username == "" || username == null) {
            attention.innerHTML = "用户名不能为空!";
            return;
        }
        if (pwd == null || pwd.length < 6) {
            attention.innerHTML = "密码不能小于6位数！"
            return;
        }
        if (repwd == "" || repwd == null) {
            attention.innerHTML = "请确认密码!";
            return;
        }
        if (repwd != pwd) {
            attention.innerHTML = "两次输入的密码不一致！!";
            return;
        }
         $('#myForm').submit();
    }
</script>
</body>
</html>
