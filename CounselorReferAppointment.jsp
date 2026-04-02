<%@ page import="java.sql.*" %>
<%
Integer counselorId = (Integer) session.getAttribute("counselorId");
if(counselorId == null){
    response.sendRedirect("CounselorLogin.jsp");
    return;
}

int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

Connection con = null;
PreparedStatement ps = null;

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    ps = con.prepareStatement(
        "UPDATE APPOINTMENT SET status='REFERRED' WHERE id=? AND counselor_id=?"
    );
    ps.setInt(1, appointmentId);
    ps.setInt(2, counselorId);
    ps.executeUpdate();

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
finally{
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}

// After referring ? go to referred list
response.sendRedirect("CounselorReferredCases.jsp");
%>
