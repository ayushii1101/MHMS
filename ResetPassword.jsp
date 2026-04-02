<%@ page contentType="text/html; charset=UTF-8" %>
<%
String email = request.getParameter("email");
if(email==null) email="";
String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
<title>Reset Password</title>
<style>
body{background:#f3f4f6;font-family:Arial;}
.box{
    max-width:400px;
    margin:120px auto;
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 0 20px rgba(0,0,0,0.2);
}
input{width:100%;padding:12px;margin:10px 0;}
button{width:100%;padding:14px;background:#6f63ff;color:white;border:none;border-radius:8px;}
.msg{color:red;text-align:center;font-weight:bold;}
</style>
</head>

<body>
<div class="box">
<h2>Reset Password</h2>

<form method="post" action="ResetPasswordProcess.jsp">
    <input type="hidden" name="email" value="<%= email %>">

    <label>OTP</label>
    <input type="text" name="otp" required>

    <label>New Password</label>
    <input type="password" name="password" required>

    <label>Confirm Password</label>
    <input type="password" name="confirm" required>

    <button type="submit">Update Password</button>
</form>

<% if(msg!=null){ %>
<div class="msg"><%= msg %></div>
<% } %>

</div>
</body>
</html>
