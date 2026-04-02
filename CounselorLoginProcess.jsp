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
String email = request.getParameter("counselorEmail");
String rawPassword = request.getParameter("password");
if(email == null || rawPassword == null) {
    request.setAttribute("loginError", "Please enter email and password");
    request.getRequestDispatcher("CounselorLogin.jsp").forward(request, response);
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
        "SELECT counselor_id, name, email, password, specialization " +
        "FROM counselor WHERE email=? AND status='ACTIVE'"
    );

    ps.setString(1, email);
    rs = ps.executeQuery();

    if(rs.next()) {
        String dbHash = rs.getString("password");
        
        if(dbHash.equals(password)) {  
            session.setAttribute("counselor_id", rs.getInt("counselor_id"));
            session.setAttribute("counselorName", rs.getString("name"));
            session.setAttribute("counselorEmail", rs.getString("email"));
            session.setAttribute("specialization", rs.getString("specialization"));
            session.setAttribute("userRole", "COUNSELOR");

            response.sendRedirect("CounselorDashboard.jsp");
        } else {
            request.setAttribute("loginError", "Invalid email or password");
            request.setAttribute("enteredEmail", email);
            request.getRequestDispatcher("CounselorLogin.jsp").forward(request, response);
        }
    }
    else {
        request.setAttribute("loginError", "Invalid email or password");
        request.setAttribute("enteredEmail", email);
        request.getRequestDispatcher("CounselorLogin.jsp").forward(request, response);
    }
}
catch(Exception e) {
    e.printStackTrace();
    request.setAttribute("loginError", "Server error. Please try again.");
    request.getRequestDispatcher("CounselorLogin.jsp").forward(request, response);
}
finally {
    if(rs!=null) try{rs.close();}catch(Exception e){}
    if(ps!=null) try{ps.close();}catch(Exception e){}
    if(con!=null) try{con.close();}catch(Exception e){}
}
%>
