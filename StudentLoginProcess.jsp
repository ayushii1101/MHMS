<%! 
public static String hashPassword(String password) throws Exception {
    java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
    byte[] hash = md.digest(password.getBytes("UTF-8"));

    StringBuilder hexString = new StringBuilder();
    for (byte b : hash) {
        String hex = Integer.toHexString(0xff & b);
        if (hex.length() == 1) hexString.append('0');
        hexString.append(hex);
    }
    return hexString.toString();
}
%>

<%@ page import="java.sql.*" %>
<%
String email = request.getParameter("studentId");
String rawPassword = request.getParameter("password");
String password = hashPassword(rawPassword);

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh", "bns", "bns");

    PreparedStatement ps = con.prepareStatement(
    "SELECT student_id, name, email, password FROM STUDENT WHERE email = ?");


    ps.setString(1, email);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        int dbStudentId = rs.getInt("student_id");
        String dbPassword = rs.getString("password");
        String dbName = rs.getString("name");
        String dbEmail = rs.getString("email");
        if (dbPassword.equals(password)) {
            session.setAttribute("user_id", dbStudentId);
            session.setAttribute("user_role", "STUDENT");
            session.setAttribute("user_name", dbName);
            session.setAttribute("user_email", dbEmail); 
            //session.setAttribute("user_email", dbEmail);
            
            session.setAttribute("studentId", dbStudentId);
            session.setAttribute("studentEmail", email);
            session.setAttribute("studentName", dbName);
            response.sendRedirect("StudentDashboard.jsp");
        } else {
            //Password wrong
            response.sendRedirect("StudentLogin.jsp?error=invalid");
        }
    } else {
        //Email not registered
        response.sendRedirect("StudentLogin.jsp?error=invalid");
    }

    con.close();

} catch (Exception e) {
    response.sendRedirect("StudentLogin.jsp?error=invalid");
}
%>
