<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*, javax.mail.internet.*" %>

<%
String email = request.getParameter("email");
String otp = "" + (int)(Math.random()*900000 + 100000);

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    // 1?? Check student email exists
    PreparedStatement ps = con.prepareStatement(
        "SELECT email FROM student WHERE email=?");
    ps.setString(1,email);
    ResultSet rs = ps.executeQuery();

    if(!rs.next()){
        response.sendRedirect(
          "ForgotPassword.jsp?msg=Invalid email&email=" +
          URLEncoder.encode(email,"UTF-8"));
        con.close();
        return;
    }

    // 2?? Remove old OTP (if any)
    PreparedStatement del = con.prepareStatement(
        "DELETE FROM otp_store WHERE email=?");
    del.setString(1,email);
    del.executeUpdate();

    // 3?? Insert new OTP (IMPORTANT FIX)
    PreparedStatement ins = con.prepareStatement(
        "INSERT INTO otp_store(email, otp, name, password, created_at) " +
        "VALUES(?, ?, '', '', CURRENT_TIMESTAMP)");
    ins.setString(1,email);
    ins.setString(2,otp);
    ins.executeUpdate();

    // 4?? Send OTP mail
    Properties props = new Properties();
    props.put("mail.smtp.auth","true");
    props.put("mail.smtp.starttls.enable","true");
    props.put("mail.smtp.host","smtp.gmail.com");
    props.put("mail.smtp.port","587");

    Session mailSession = Session.getInstance(props,
        new javax.mail.Authenticator(){
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(
                    "mansparshhelp@gmail.com",
                    "lcsacmtvnkbsnmgx"   // your APP PASSWORD
                );
            }
        }
    );

    Message message = new MimeMessage(mailSession);
    message.setFrom(new InternetAddress("mansparshhelp@gmail.com"));
    message.setRecipients(
        Message.RecipientType.TO,
        InternetAddress.parse(email)
    );
    message.setSubject("ManSparsh Password Reset OTP");
    message.setText(
        "Your OTP to reset your ManSparsh password is: " + otp +
        "\n\nThis OTP is valid for 5 minutes."
    );

    Transport.send(message);

    con.close();

    // 5?? Go to next page
    response.sendRedirect(
      "ResetPassword.jsp?email=" +
      URLEncoder.encode(email,"UTF-8")
    );

}catch(Exception e){
    e.printStackTrace(); // VERY IMPORTANT for debugging
    response.sendRedirect("ForgotPassword.jsp?msg=Server error");
}
%>
