<%@ page import="java.sql.*" %>
<%
Integer userId = (Integer) session.getAttribute("user_id");
String role    = (String) session.getAttribute("user_role");   // STUDENT / COUNSELOR / FACULTY
String name    = (String) session.getAttribute("user_name");
String email   = (String) session.getAttribute("user_email");

String message = request.getParameter("feedback");
String ratingStr = request.getParameter("rating");

int rating = 0;
if(ratingStr != null && !ratingStr.trim().equals("")){
    rating = Integer.parseInt(ratingStr);
}

if(userId == null || role == null){
    response.sendRedirect("login.jsp");
    return;
}

Connection con = null;
PreparedStatement ps = null;

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns"
    );

    ps = con.prepareStatement(
      "INSERT INTO FEEDBACK " +
      "(user_id, user_role, user_name, user_email, message, rating, status) " +
      "VALUES (?,?,?,?,?,?,?)"
    );

    ps.setInt(1, userId);
    ps.setString(2, role);
    ps.setString(3, name);
    ps.setString(4, email);
    ps.setString(5, message);
    ps.setInt(6, rating);
    ps.setString(7, "NEW");

    ps.executeUpdate();

    request.setAttribute("feedbackSubmitted", true);
    RequestDispatcher rd = request.getRequestDispatcher("feedback.jsp");
    rd.forward(request, response);


}catch(Exception e){
    out.print("<h3>Error saving feedback</h3>");
    out.print(e);
}
finally{
    try{ if(ps!=null) ps.close(); }catch(Exception e){}
    try{ if(con!=null) con.close(); }catch(Exception e){}
}
%>