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
String email = request.getParameter("facultyEmail");
String rawPassword = request.getParameter("password");
if(email == null || rawPassword == null) {
    request.setAttribute("loginError", "Please enter email and password");
    request.getRequestDispatcher("FacultyLogin.jsp").forward(request, response);
    return; // stop further execution
}
String password = hashPassword(rawPassword);   
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh", "bns", "bns");

    ps = con.prepareStatement(
        "SELECT faculty_id, name, email, password, specialization " +
        "FROM faculty WHERE email=? AND status='ACTIVE'"
    );

    ps.setString(1, email);
    rs = ps.executeQuery();

    if(rs.next()) {
        String dbHash = rs.getString("password");
        
        if(dbHash.equals(password)) {     
            session.setAttribute("facultyId", rs.getInt("faculty_id"));
            session.setAttribute("facultyName", rs.getString("name"));
            session.setAttribute("facultyEmail", rs.getString("email"));
            session.setAttribute("specialization", rs.getString("specialization"));
            session.setAttribute("role", "FACULTY");

            response.sendRedirect("FacultyDashboard.jsp");
        } else {
            request.setAttribute("loginError", "Invalid email or password");
            request.setAttribute("enteredEmail", email);
            request.getRequestDispatcher("FacultyLogin.jsp").forward(request, response);
        }
    }
    else {
        request.setAttribute("loginError", "Invalid email or password");
        request.setAttribute("enteredEmail", email);
        request.getRequestDispatcher("FacultyLogin.jsp").forward(request, response);
    }
}
catch(Exception e) {
    e.printStackTrace();
    request.setAttribute("loginError", "Server error. Please try again.");
    request.getRequestDispatcher("FacultyLogin.jsp").forward(request, response);
}
finally {
    if(rs!=null) try{rs.close();}catch(Exception e){}
    if(ps!=null) try{ps.close();}catch(Exception e){}
    if(con!=null) try{con.close();}catch(Exception e){}
}
%>
