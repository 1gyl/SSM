<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/webjars/jquery/3.3.1/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css" type="text/css">
</head>
<body background="${pageContext.request.contextPath}/img/back_01.jpg" style="background-repeat:no-repeat; background-size:100% 100%; background-attachment: fixed; margin: 0px">
<div class="container">
    <form id="myForm" action="${pageContext.request.contextPath}/user/registerUser" method="post">
        <br>
        <h1>新用户注册</h1>
        <br>
        <span class="p">*</span>
        <label for="username">用户名</label>
        <input type="text" name="username" id="username" placeholder="" class="register" style="width: 50%"
               onblur="checkUsername()" value="${user.username}">&nbsp;
        <span class="checkUser" id="checkUser"></span><br><br>
        <span class="q">*</span>
        <label for="pwd">登录密码</label>
        <input type="password" name="password" id="pwd" class="register" style="width: 50%" value="${user.password}"><br><br>
        <span class="q">*</span>
                <label for="repwd">确认密码</label>
                <input type="password" name="confirmPassword" id="repwd" class="register" style="width: 50%" value="${user.password}"><br><br>
                <div class="msg">
                    <span id="attention" style="color: crimson; font-size: 1.8rem;">${error1}</span>
                </div>
                <br><br>
                <input type="button" onclick="check()" value="注册" class="submit"><br>
                <a href="${pageContext.request.contextPath}/user/login" class="left">返回登录</a>
            </form>
        </div>
        <script type="text/javascript">
            var checkUserSpan = document.getElementById("checkUser");
            var attention = document.getElementById("attention");
            function checkUsername() {
                var username = $('#username').val();
                if (username == "") {
                    checkUserSpan.style.color = "crimson";
                    checkUserSpan.innerHTML = "请输入用户名！";
                    return;
                }
                $.ajax({
                    type: "POST",
                    data: {"username": username},
                    url: "${pageContext.request.contextPath}/user/checkUsername",
                    dataType: "text",
                    success: function (data) {
                        if (data == "已存在") {
                            checkUserSpan.style.color = "crimson";
                            checkUserSpan.innerHTML = '已存在!';
                        } else {
                            checkUserSpan.style.color = "green";
                            checkUserSpan.innerHTML = '可用';
                        }
                    },
                    error: function () {
                        alert("服务器繁忙！");
                    }
                });
            }

            function check() {
                var username = document.getElementById("username").value;
                var pwd = document.getElementById("pwd").value;
                var repwd = document.getElementById("repwd").value;
                var checkUserStatus = checkUserSpan.innerHTML.trim();
                if (username == "") {
                    attention.innerHTML = "用户名不能为空!";
                    return;
                }
                if (checkUserStatus !== "可用") {
                    attention.innerHTML = "请输入有效用户名!";
                    return;
                }
                if (pwd.length < 6) {
                    attention.innerHTML = "密码不能小于6位数！";
                    return;
                }
                if (repwd == "") {
                    attention.innerHTML = "请确认密码!";
                    return;
                }
                if (repwd !== pwd) {
                    attention.innerHTML = "两次输入的密码不一致！";
                    return;
                }
                $('#myForm').submit();
            }
        </script>
        </body>
        </html>