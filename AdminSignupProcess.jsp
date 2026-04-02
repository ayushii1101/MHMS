<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("adminEmail");
String password = request.getParameter("password");
String confirm = request.getParameter("confirmPassword");

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con=DriverManager.getConnection("jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    // Check if email already exists
    ps=con.prepareStatement("SELECT email FROM ADMIN WHERE email=?");
    ps.setString(1,email);
    rs=ps.executeQuery();

    if(rs.next()){
        request.setAttribute("signupError","This email is already registered.");
        request.setAttribute("emailError","1");  
        request.setAttribute("enteredEmail",email);
        request.setAttribute("enteredName",name);
        request.getRequestDispatcher("AdminSignup.jsp").forward(request,response);
        return;
    }
    rs.close();
    // ===== PASSWORD VALIDATION AFTER EMAIL CHECK =====
    String passRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";

    if(!password.matches(passRegex)){
        request.setAttribute("signupError",
           "Password must contain uppercase, lowercase, number & special character");
        request.setAttribute("enteredEmail",email);
        request.setAttribute("enteredName",name);
        request.getRequestDispatcher("AdminSignup.jsp").forward(request,response);
        return;
    }
    // ===== PASSWORD MATCH CHECK =====
    if(!password.equals(confirm)){
        request.setAttribute("signupError","Passwords do not match");
        request.setAttribute("enteredEmail",email);
        request.setAttribute("enteredName",name);
        request.getRequestDispatcher("AdminSignup.jsp").forward(request,response);
        return;
    }
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hashBytes = md.digest(password.getBytes("UTF-8"));

    StringBuilder hashedPassword = new StringBuilder();
    for(byte b : hashBytes){
        hashedPassword.append(String.format("%02x", b));
    }
    // Insert admin
    ps=con.prepareStatement(
      "INSERT INTO ADMIN(email,name,password,created_date) VALUES(?,?,?,CURRENT_TIMESTAMP)");
    ps.setString(1,email);
    ps.setString(2,name);
    ps.setString(3,password);
    ps.executeUpdate();
    rs.close();
    response.sendRedirect("AdminDashboard.jsp");

}
catch(Exception e){
    e.printStackTrace();
    request.setAttribute("signupError","Something went wrong. Please try again.");
    request.setAttribute("enteredEmail",email);
    request.setAttribute("enteredName",name);
    request.getRequestDispatcher("AdminSignup.jsp").forward(request,response);
}
finally{
    if(rs!=null)rs.close();
    if(ps!=null)ps.close();
    if(con!=null)con.close();
}
%>

