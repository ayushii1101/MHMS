<%@ page import="java.sql.*" %>
<%
Connection con = null;
PreparedStatement ps = null;

try {
    String id = request.getParameter("id");

    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    String sql = "UPDATE WORKSHOP SET status='CANCELLED' WHERE workshop_id=?";
    // OPTION 2 (Better): Soft delete
    // String sql = "UPDATE WORKSHOP SET status='CANCELLED' WHERE workshop_id=?";

    ps = con.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(id));

    int rows = ps.executeUpdate();

    if(rows > 0){
        response.sendRedirect("CounselorWorkshops.jsp?msg=Workshop deleted successfully!");
    } else {
        response.sendRedirect("CounselorWorkshops.jsp?msg=Error deleting workshop!");
    }

} catch(Exception e){
    e.printStackTrace();
    response.sendRedirect("CounselorWorkshops.jsp?msg=error");
} finally {
    try {
        if(ps != null) ps.close();
        if(con != null) con.close();
    } catch(Exception e){}
}
%>