<%@ page import="java.sql.*, java.util.*, javax.mail.*, javax.mail.internet.*" %>
<%
String email = request.getParameter("email");
String newOtp = "" + (int)(Math.random()*900000 + 100000);

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/ManSparsh","bns","bns");

        // 1?? Check if email exists in otp_store
        PreparedStatement check = con.prepareStatement(
            "SELECT * FROM otp_store WHERE email=?"
        );
        check.setString(1, email);
        ResultSet rs = check.executeQuery();

        if(rs.next()) {
            // 2?? Update OTP and timestamp
            PreparedStatement ps = con.prepareStatement(
                "UPDATE otp_store SET otp=?, created_at=CURRENT_TIMESTAMP WHERE email=?"
            );
            ps.setString(1, newOtp);
            ps.setString(2, email);
            ps.executeUpdate();

            // 3?? Send OTP email
            try {
                Properties props = new Properties();
                props.put("mail.smtp.auth","true");
                props.put("mail.smtp.starttls.enable","true");
                props.put("mail.smtp.ssl.trust","smtp.gmail.com");
                props.put("mail.smtp.host","smtp.gmail.com");
                props.put("mail.smtp.port","587");
                props.put("mail.smtp.connectiontimeout","5000");
                props.put("mail.smtp.timeout","5000");

                Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("mansparshhelp@gmail.com","ckljdaezmmorsqcq");
                    }
                });

                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress("mansparshhelp@gmail.com"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("ManSparsh OTP Verification - Resent OTP");
                message.setText("Hello,\nYour new OTP for ManSparsh signup is: " + newOtp + "\nValid for 5 minutes.");

                Transport.send(message);

            } catch(Exception mailEx) {
                out.println("<h3 style='color:red'>Error sending OTP email: "+mailEx+"</h3>");
                return;
            }

            // 4?? Redirect to VerifyOtp.jsp with success
            response.sendRedirect("VerifyOtp.jsp?email=" + email + "&error=resent");

        } else {
            out.println("<h3 style='color:red'>Email not found. Please signup first.</h3>");
        }
        con.close();
} catch(Exception e) {
    out.println("<h3 style='color:red'>Server error: "+e+"</h3>");
}
%>
