<%@ page import="java.sql.*,java.security.*" %>

<%
String email = request.getParameter("email");
String otp = request.getParameter("otp");
String pass = request.getParameter("password");
String confirm = request.getParameter("confirm");

if(!pass.equals(confirm)){
    response.sendRedirect("ResetPassword.jsp?email="+email+"&msg=Passwords do not match");
    return;
}

// Hash password
MessageDigest md = MessageDigest.getInstance("SHA-256");
byte[] hash = md.digest(pass.getBytes());
StringBuilder sb = new StringBuilder();
for(byte b:hash){
    sb.append(String.format("%02x",b));
}
String hashed = sb.toString();

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection(
      "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    // verify OTP
    PreparedStatement ps = con.prepareStatement(
      "SELECT * FROM otp_store WHERE email=? AND otp=?");
    ps.setString(1,email);
    ps.setString(2,otp);
    ResultSet rs = ps.executeQuery();

    if(!rs.next()){
        response.sendRedirect("ResetPassword.jsp?email="+email+"&msg=Invalid OTP");
        return;
    }

    // update password
    PreparedStatement up = con.prepareStatement(
      "UPDATE student SET password=? WHERE email=?");
    up.setString(1,hashed);
    up.setString(2,email);
    up.executeUpdate();

    // delete OTP
    PreparedStatement del = con.prepareStatement(
      "DELETE FROM otp_store WHERE email=?");
    del.setString(1,email);
    del.executeUpdate();

    con.close();

    response.sendRedirect("StudentLogin.jsp?msg=reset");

}catch(Exception e){
    response.sendRedirect("ResetPassword.jsp?email="+email+"&msg=Server error");
}
%>
