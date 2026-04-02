<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
%>

<html>
<head>
<title>Suggest New Time</title>
<style>
body{font-family:Arial;background:#f4f6fb;}
.box{
    width:400px;margin:80px auto;padding:30px;
    background:white;border-radius:12px;
    box-shadow:0 10px 30px rgba(0,0,0,0.1);
}
input,button{
    width:100%;padding:10px;margin:10px 0;
}
button{background:#6f63ff;color:white;border:none;border-radius:8px;}
</style>
</head>

<body>
<div class="box">
<h2>Suggest New Time</h2>

<form action="CounselorSuggestTimeProcess.jsp" method="post">
    <input type="hidden" name="id" value="<%=id%>">

    New Date:
    <input type="date" name="date" required>

    New Time:
    <input type="time" name="time" required>

    <button type="submit">Send to Student</button>
</form>
</div>
</body>
</html>
