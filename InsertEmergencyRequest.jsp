<%@ page import="java.sql.*, java.util.*" %>
<%
String studentEmail = (String) session.getAttribute("studentEmail");
if(studentEmail == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}

String preferredMode = request.getParameter("preferred_mode");
String note = request.getParameter("note");

try{
    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    // get student_id from email
    PreparedStatement ps1 = con.prepareStatement("SELECT student_id FROM STUDENT WHERE email=?");
    ps1.setString(1, studentEmail);
    ResultSet rs = ps1.executeQuery();

    int studentId = 0;
    if(rs.next()){
        studentId = rs.getInt("student_id");
    }

    // insert emergency request
    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO EMERGENCY_REQUEST(student_id, preferred_mode, note) VALUES(?,?,?)"
    );
    ps.setInt(1, studentId);
    ps.setString(2, preferredMode);
    ps.setString(3, note);

    ps.executeUpdate();
    con.close();

    response.sendRedirect("StudentDashboard.jsp?msg=Emergency request sent!");
}catch(Exception e){
    out.print("<div style='color:red;text-align:center;'>Error: "+e.getMessage()+"</div>");
}
%>
