<%@ page import="java.sql.*" %>
<%
int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

Class.forName("org.apache.derby.jdbc.ClientDriver");
Connection con = DriverManager.getConnection(
    "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

// Update status to COMPLETED
PreparedStatement ps = con.prepareStatement(
    "UPDATE APPOINTMENT SET status='COMPLETED' WHERE id=?"
);
ps.setInt(1, appointmentId);
ps.executeUpdate();

con.close();
response.sendRedirect("CounselorAppointments.jsp");
%>
