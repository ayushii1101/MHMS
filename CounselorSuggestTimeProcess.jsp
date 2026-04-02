<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String date = request.getParameter("date");
String time = request.getParameter("time");

// Get logged-in counselor
Integer counselorId = (Integer) session.getAttribute("counselorId");

if(counselorId == null){
    response.sendRedirect("CounselorLogin.jsp");
    return;
}

Class.forName("org.apache.derby.jdbc.ClientDriver");
Connection con = DriverManager.getConnection(
"jdbc:derby://localhost:1527/ManSparsh","bns","bns");

PreparedStatement ps = con.prepareStatement(
"UPDATE APPOINTMENT " +
"SET proposed_date=?, proposed_time=?, status='TIME_PROPOSED', counselor_id=? " +
"WHERE id=?");

ps.setDate(1, Date.valueOf(date));
ps.setString(2, time);
ps.setInt(3, counselorId);
ps.setInt(4, Integer.parseInt(id));

ps.executeUpdate();
con.close();

response.sendRedirect("CounselorCaseDetails.jsp");
%>