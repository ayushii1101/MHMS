<%@ page contentType="text/html; charset=UTF-8" %>
<%
String msg = request.getParameter("msg");
String emailVal = request.getParameter("email");
if(emailVal == null) emailVal = "";
boolean isInvalid = "Invalid email".equals(msg);
%>
<!DOCTYPE html>
<html>
<head>
<title>Forgot Password</title>

<style>
body{
    margin:0;
    font-family:Arial;
    background:#f3f4f6;
}
.box{
    max-width:400px;
    margin:120px auto;
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 0 25px rgba(0,0,0,0.15);
}
h2{text-align:center;}
input{
    width:100%;
    padding:12px;
    margin:10px 0;
    border:1px solid #ddd;
    border-radius:5px;
}
button{
    width:100%;
    padding:14px;
    border:none;
    background:#6f63ff;
    color:white;
    border-radius:8px;
    font-size:16px;
    cursor:pointer;
}
button:hover{background:#5a52d5;}
.msg{
    text-align:center;
    margin-top:10px;
    color:red;
    font-weight:bold;
}
</style>
</head>

<body>
<div class="box">
    <h2>Forgot Password</h2>

    <form method="post" action="ForgotPasswordProcess.jsp">
        <label>Email:</label>
        <input type="email" name="email"
        value="<%= emailVal %>"
        <%= isInvalid ? "" : "readonly" %>
        required>

        <button type="submit">Send OTP</button>
    </form>

    <% if(msg != null){ %>
        <div class="msg"><%= msg %></div>
    <% } %>
</div>
</body>
</html>
