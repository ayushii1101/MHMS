<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
Integer studentId = (Integer) session.getAttribute("studentId");
if(studentId == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}

List history = new ArrayList();

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    String sql =
      "SELECT a.appointment_date, a.time_slot, a.preferred_mode, a.status, " +
      "c.name AS counselor_name " +
      "FROM APPOINTMENT a " +
      "LEFT JOIN COUNSELOR c ON a.counselor_id = c.counselor_id " +
      "WHERE a.student_id=? AND a.status IN ('COMPLETED','REFERRED') " +
      "ORDER BY a.appointment_date DESC";

    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, studentId);

    ResultSet rs = ps.executeQuery();
    while(rs.next()){
        Map row = new HashMap();
        row.put("date", rs.getDate("appointment_date"));
        row.put("time", rs.getString("time_slot"));
        row.put("mode", rs.getString("preferred_mode"));
        row.put("status", rs.getString("status"));
        row.put("counselor", rs.getString("counselor_name"));
        history.add(row);
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    out.println("<p style='color:red'>"+e.getMessage()+"</p>");
}

pageContext.setAttribute("history", history);
%>

<!DOCTYPE html>
<html>
<head>
<title>Session History</title>
<style>
body{ font-family: Arial; background:#f4f6fb; margin:0; padding:0; }
.container{
    max-width:1000px;
    margin:50px auto;
    background:white;
    padding:30px;
    border-radius:14px;
    box-shadow:0 12px 30px rgba(0,0,0,0.1);
}
h1{
    text-align:center;
    color:#4a5568;
    margin-bottom:30px;
}
table{
    width:100%;
    border-collapse:collapse;
}
th,td{
    padding:14px;
    border-bottom:1px solid #f1f5f9;
    text-align:left;
}
th{
    background:#6f63ff;
    color:white;
}
tr:hover{
    background:#f8fafc;
}
.badge{
    padding:6px 12px;
    border-radius:20px;
    font-size:13px;
    font-weight:600;
}
.completed{ background:#dcfce7; color:#166534; }
.referred{ background:#fef3c7; color:#92400e; }
</style>
</head>

<body>
<div class="container">
<h1>Session History</h1>

<table>
<tr>
    <th>Counselor</th>
    <th>Date</th>
    <th>Time</th>
    <th>Mode</th>
    <th>Status</th>
</tr>

<c:forEach var="h" items="${history}">
<tr>
    <td>${h.counselor != null ? h.counselor : '-'}</td>
    <td>${h.date}</td>
    <td>${h.time}</td>
    <td>${h.mode}</td>
    <td>
<c:choose>
    <c:when test="${h.status=='COMPLETED'}">
        <span class="badge completed">Completed</span>
    </c:when>
    <c:when test="${h.status=='REFERRED'}">
        <span class="badge referred">Referred</span>
    </c:when>
    <c:otherwise>
        <span class="badge">${h.status}</span>
    </c:otherwise>
</c:choose>
</td>

</tr>
</c:forEach>

</table>

</div>
</body>
</html>
