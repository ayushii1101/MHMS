<%@ page import="java.sql.*, java.util.*, java.util.regex.*" %>
<%@ page import="javax.mail.*, javax.mail.internet.*" %>
<%
String name = request.getParameter("name");
/* Name validation: no 3 consecutive same letters */
String namePattern = "^(?!.*([A-Za-z])\\1\\1)[A-Za-z ]+$";

if (!Pattern.matches(namePattern, name)) {
    response.sendRedirect("StudentSignup.jsp?error=invalidname");
    return;
}

String email = request.getParameter("studentId");
String password = request.getParameter("password");

/* Generate OTP */
String otp = "" + (int)(Math.random()*900000 + 100000);

/* Email validation */
String emailPattern = "^[a-zA-Z0-9]+_[a-zA-Z]+@banasthali\\.in$";
if (!Pattern.matches(emailPattern, email)) {
    out.println("Only Banasthali email allowed");
    return;
}

/* Password validation */
String passPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";
if (!Pattern.matches(passPattern, password)) {
    out.println("Weak password");
    return;
}

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");
    PreparedStatement chkUser = con.prepareStatement(
    "SELECT email FROM STUDENT WHERE email=?");
    chkUser.setString(1, email);
    ResultSet rsUser = chkUser.executeQuery();

    if(rsUser.next()) {
    response.sendRedirect("StudentSignup.jsp?error=exists");
    con.close();
    return; 
    }

    // Remove old OTP if exists (safety)
    PreparedStatement del = con.prepareStatement(
        "DELETE FROM otp_store WHERE email=?"
    );
    del.setString(1, email);
    del.executeUpdate();

    /* Insert OTP in DB */
    PreparedStatement check = con.prepareStatement(
        "SELECT email FROM otp_store WHERE email=?"
    );

check.setString(1, email);
ResultSet rs = check.executeQuery();

if(rs.next()) {
    // Email already exists ? update OTP
    PreparedStatement ps = con.prepareStatement(
        "UPDATE otp_store SET otp=?, name=?, password=?, created_at=CURRENT_TIMESTAMP WHERE email=?"
    );
    ps.setString(1, otp);
    ps.setString(2, name);
    ps.setString(3, password);
    ps.setString(4, email);
    ps.executeUpdate();
}
else {
    // New email ? insert
    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO otp_store(email,otp,name,password,created_at) VALUES(?,?,?,?,CURRENT_TIMESTAMP)"
    );
    ps.setString(1,email);
    ps.setString(2,otp);
    ps.setString(3,name);
    ps.setString(4,password);
    ps.executeUpdate();
}


    /* -------- Send OTP email -------- */
    try {
        Properties props = new Properties();
props.put("mail.smtp.auth","true");
props.put("mail.smtp.starttls.enable","true");
props.put("mail.smtp.ssl.trust","smtp.gmail.com");
props.put("mail.smtp.host","smtp.gmail.com");
props.put("mail.smtp.port","587");
props.put("mail.smtp.connectiontimeout","5000");
props.put("mail.smtp.timeout","5000");

        Session mailSession = Session.getInstance(props,new javax.mail.Authenticator(){
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication("mansparshhelp@gmail.com","lcsacmtvnkbsnmgx");
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress("mansparshhelp@gmail.com"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("ManSparsh OTP Verification");
        message.setText("Hello "+name+",\nYour OTP for ManSparsh signup is: "+otp+"\nValid for 5 minutes.");

        Transport.send(message);
    } catch(Exception mailEx){
        out.println("Error sending OTP email: "+mailEx);
        con.close();
        return;
    }

    con.close();

    /* Redirect to OTP verification page */
    response.sendRedirect("VerifyOtp.jsp?email=" + email);

}catch(Exception e){
    response.sendRedirect("StudentSignup.jsp?error=db");
}
%>
