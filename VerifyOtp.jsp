<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Verify OTP - ManSparsh</title>
<style>
body{
    font-family: Arial;
    background:#eef1ff;
}
.box{
    width:350px;
    margin:120px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 15px rgba(0,0,0,0.1);
}
input,button{
    width:100%;
    padding:12px;
    margin-top:15px;
}
button{
    background:#6f63ff;
    color:white;
    border:none;
    font-size:16px;
    cursor:pointer;
}
.resend{
    margin-top:10px;
    text-align:center;
}
.error {
    color:red;
    text-align:center;
    margin-top:10px;
}
.success {
    color:green;
    text-align:center;
    margin-top:10px;
}
</style>
</head>

<body>

<div class="box">
<h2>Verify OTP</h2>

<p>OTP has been sent to your email</p>

<!-- Show friendly error message -->
<%
    String error = request.getParameter("error");
    if("invalid".equals(error)) {
%>
    <div class="error">Invalid or expired OTP. Please try again.</div>
<%
    } else if ("resent".equals(error)) {
%>
    <div class="success">OTP has been resent to your email.</div>
<% } %>

<form action="VerifyOtpProcess.jsp" method="post">
    <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
    <input type="text" name="otp" placeholder="Enter OTP" required>
    <button type="submit">Verify</button>
</form>

<div class="resend">
    <a href="ResendOtp.jsp?email=<%= request.getParameter("email") %>">Resend OTP</a>
</div>

</div>

</body>
</html>
