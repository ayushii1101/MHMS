<%@ page import="java.sql.*" %>
<%
int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

Class.forName("org.apache.derby.jdbc.ClientDriver");
Connection con = DriverManager.getConnection(
    "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

// Update status to IN_SESSION
PreparedStatement ps = con.prepareStatement(
    "UPDATE APPOINTMENT SET status='IN_SESSION' WHERE id=?"
);
ps.setInt(1, appointmentId);
ps.executeUpdate();

con.close();

// Redirect back to appointments page
response.sendRedirect("CounselorAppointments.jsp");
%>