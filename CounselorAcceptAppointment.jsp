<%@ page import="java.sql.*" %>
<%
int id = Integer.parseInt(request.getParameter("id"));
int counselorId = (Integer) session.getAttribute("counselorId");

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    PreparedStatement ps = con.prepareStatement(
   "UPDATE APPOINTMENT " +
   "SET status='ACCEPTED', counselor_id=? " +
   "WHERE id=? AND (counselor_id IS NULL OR counselor_id=?)"
);


    ps.setInt(1, counselorId);  // assign to me
    ps.setInt(2, id);          // appointment id
    ps.setInt(3, counselorId); // allow only me if already assigned

    ps.executeUpdate();

    con.close();
}catch(Exception e){
    out.println(e);
}

response.sendRedirect("CounselorCaseDetails.jsp");
%>
