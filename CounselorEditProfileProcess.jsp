<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%! 
String hash(String password) throws Exception {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] bytes = md.digest(password.getBytes("UTF-8"));
    StringBuilder sb = new StringBuilder();
    for (byte b : bytes) {
        sb.append(String.format("%02x", b));
    }
    return sb.toString();
}
%>

<%
/* ---------- Session check ---------- */
Integer counselorId = (Integer) session.getAttribute("counselor_id");
String sessionEmail = (String) session.getAttribute("counselorEmail");

if (counselorId == null) {
    response.sendRedirect("CounselorLogin.jsp");
    return;
}

/* ---------- Get form data ---------- */
String name = request.getParameter("name");
String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword");

Connection con = null;

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh", "bns", "bns"
    );

    /* ---------- Update NAME ---------- */
    PreparedStatement ps1 = con.prepareStatement(
        "UPDATE COUNSELOR SET name=? WHERE counselor_id=?"
    );
    ps1.setString(1, name);
    ps1.setInt(2, counselorId);
    ps1.executeUpdate();

    session.setAttribute("counselorName", name);

    /* ---------- Change PASSWORD (only if filled) ---------- */
    if (
        currentPassword != null && !currentPassword.isEmpty() &&
        newPassword != null && !newPassword.isEmpty() &&
        confirmPassword != null && !confirmPassword.isEmpty()
    ) {
        PreparedStatement ps2 = con.prepareStatement(
            "SELECT password FROM COUNSELOR WHERE counselor_id=?"
        );
        ps2.setInt(1, counselorId);
        ResultSet rs = ps2.executeQuery();
        
        if (rs.next()) {
            String dbPassword = rs.getString("password");

            if (!dbPassword.equals(hash(currentPassword))) {
                request.setAttribute("passwordError", "Current password is wrong");

                RequestDispatcher rd = request.getRequestDispatcher("CounselorEditProfile.jsp");
                rd.forward(request, response);
                return;
            }
        }
        String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";
        if (!newPassword.matches(pattern)) {
            request.setAttribute("passwordError",
                "Password must contain uppercase, lowercase, number & special character");

            RequestDispatcher rd = request.getRequestDispatcher("CounselorEditProfile.jsp");
            rd.forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("passwordError", "Passwords do not match");

            RequestDispatcher rd = request.getRequestDispatcher("CounselorEditProfile.jsp");
            rd.forward(request, response);
            return;
        }
        PreparedStatement ps3 = con.prepareStatement(
            "UPDATE COUNSELOR SET password=? WHERE counselor_id=?"
        );
        ps3.setString(1, hash(newPassword));
        ps3.setInt(2, counselorId);
        ps3.executeUpdate();
    }

    request.setAttribute("success", "true");

    RequestDispatcher rd = request.getRequestDispatcher("CounselorEditProfile.jsp");
    rd.forward(request, response);

} catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("passwordError", "Something went wrong. Try again.");

    RequestDispatcher rd = request.getRequestDispatcher("CounselorEditProfile.jsp");
    rd.forward(request, response);
} finally {
    if (con != null) con.close();
}
%>
