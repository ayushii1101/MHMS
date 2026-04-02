<%@ page import="java.sql.*, java.util.*, java.security.MessageDigest" %>
<%
String email = request.getParameter("email");
String userOtp = request.getParameter("otp");
Connection con = null;
PreparedStatement ps = null;
PreparedStatement ps2 = null;
PreparedStatement ps3 = null;
ResultSet rs = null;

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection("jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    ps = con.prepareStatement("SELECT * FROM otp_store WHERE email=?");
    ps.setString(1, email);
    rs = ps.executeQuery();

    if(rs.next()) {
        String dbOtp = rs.getString("otp").trim();
        java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
        long diffMinutes = (System.currentTimeMillis() - createdAt.getTime()) / (60 * 1000);

        if(!dbOtp.equals(userOtp.trim()) || diffMinutes > 5) {
            response.sendRedirect("VerifyOtp.jsp?email=" + email + "&error=invalid");
        } else {
            String name = rs.getString("name");
            String password = rs.getString("password");

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for(byte b : hash) sb.append(String.format("%02x", b));
            String hashedPassword = sb.toString();

            ps2 = con.prepareStatement("INSERT INTO student(name,email,password,created_by,created_date) VALUES(?,?,?, ?, CURRENT_TIMESTAMP)");
            ps2.setString(1, name);
            ps2.setString(2, email);
            ps2.setString(3, hashedPassword);
            ps2.setString(4, "STUDENT_SELF");
            ps2.executeUpdate();

            ps3 = con.prepareStatement("DELETE FROM otp_store WHERE email=?");
            ps3.setString(1, email);
            ps3.executeUpdate();
            /* ---------- AUTO LOGIN AFTER OTP ---------- */
            session.setAttribute("studentEmail", email);
            session.setAttribute("studentName", name);

            /* Go to dashboard */
            response.sendRedirect("StudentDashboard.jsp");
        }
    } else {
        response.sendRedirect("VerifyOtp.jsp?email=" + email + "&error=invalid");
    }

} catch(Exception e) {
    e.printStackTrace();
    out.println("<h3 style='color:red'>Server error occurred. Please try again later.</h3>");
} finally {
    try { if(rs != null) rs.close(); } catch(Exception e){}
    try { if(ps != null) ps.close(); } catch(Exception e){}
    try { if(ps2 != null) ps2.close(); } catch(Exception e){}
    try { if(ps3 != null) ps3.close(); } catch(Exception e){}
    try { if(con != null) con.close(); } catch(Exception e){}
}
%>