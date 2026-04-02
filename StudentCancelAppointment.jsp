<%@ page import="java.sql.*" %>
<%
Integer studentId = (Integer) session.getAttribute("studentId");

if(studentId == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}

String idStr = request.getParameter("id");

if(idStr == null){
    response.sendRedirect("StudentAppointments.jsp");
    return;
}

Connection con = null;
PreparedStatement psCheck = null;
PreparedStatement psUpdate = null;

try {

    int appointmentId = Integer.parseInt(idStr);

    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    // 1?? Verify appointment belongs to this student AND is scheduled
    String checkSql =
        "SELECT status FROM appointment WHERE id=? AND student_id=?";

    psCheck = con.prepareStatement(checkSql);
    psCheck.setInt(1, appointmentId);
    psCheck.setInt(2, studentId);

    ResultSet rs = psCheck.executeQuery();

    if(rs.next()){

        String status = rs.getString("status");

        if("SCHEDULED".equals(status)){

            // 2?? Update status to CANCELLED_BY_STUDENT
            String updateSql =
                "UPDATE appointment SET status=?, meeting_link=NULL WHERE id=?";

            psUpdate = con.prepareStatement(updateSql);
            psUpdate.setString(1, "CANCELLED_BY_STUDENT");
            psUpdate.setInt(2, appointmentId);
            psUpdate.executeUpdate();

            session.setAttribute("successMsg",
                "Appointment cancelled successfully.");

        } else {

            session.setAttribute("errorMsg",
                "Only scheduled appointments can be cancelled.");
        }

    } else {

        session.setAttribute("errorMsg",
            "Invalid appointment.");
    }

    rs.close();

} catch(Exception e){

    session.setAttribute("errorMsg",
        "Cancellation failed: " + e.getMessage());

} finally {

    try{ if(psCheck!=null) psCheck.close(); }catch(Exception e){}
    try{ if(psUpdate!=null) psUpdate.close(); }catch(Exception e){}
    try{ if(con!=null) con.close(); }catch(Exception e){}
}

response.sendRedirect("StudentAppointments.jsp");
%>