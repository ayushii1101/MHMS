<%@ page import="java.sql.*" %>
<%
String email = request.getParameter("adminEmail");
String password = request.getParameter("password");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    // Load JDBC driver
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection("jdbc:derby://localhost:1527/ManSparsh", "bns", "bns");

    // Check if email exists
    ps = con.prepareStatement("SELECT password FROM ADMIN WHERE email=?");
    ps.setString(1, email);
    rs = ps.executeQuery();

    if(rs.next()) {
        String dbPass = rs.getString("password");

        if(dbPass.equals(password)) {
            // Login success ? redirect to dashboard
            response.sendRedirect("AdminDashboard.jsp");
        } else {
            // Wrong password
            request.setAttribute("loginError", "Invalid email or password");
            request.setAttribute("enteredEmail", email);
            request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
        }
    } else {
        // Email not found
        request.setAttribute("loginError", "Invalid email or password");
        request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
    }

} catch(Exception e) {
    e.printStackTrace();
    request.setAttribute("loginError", "Something went wrong. Please try again.");
    request.setAttribute("enteredEmail", email);
    request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
} finally {
    if(rs != null) try { rs.close(); } catch(Exception e) {}
    if(ps != null) try { ps.close(); } catch(Exception e) {}
    if(con != null) try { con.close(); } catch(Exception e) {}
}
%>
