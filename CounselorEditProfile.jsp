<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String counselorName = (String) session.getAttribute("counselorName");
String counselorEmail = (String) session.getAttribute("counselorEmail");

Integer counselorId = (Integer) session.getAttribute("counselor_id");

if(counselorId == null){
    response.sendRedirect("CounselorLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile – ManSparsh</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: #f3f4f6;
}

/* NAVBAR (same) */
.navbar {
    background-color: #6f63ff;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
}

.logo {
    color: white;
    font-size: 26px;
    font-weight: bold;
}

.nav-links a {
    color: white;
    text-decoration: none;
    margin: 0 15px;
}

/* FORM */
.signup-container {
    max-width: 400px;
    margin: 80px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

input {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 4px;
}

button {
    background: linear-gradient(135deg, #4F46E5, #7C3AED);
    color: white;
    padding: 14px;
    width: 100%;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}

button:hover {
    background: linear-gradient(135deg, #4338CA, #6D28D9);
}

.error {
    color: red;
    font-size: 14px;
    text-align: center;
}

.success {
    color: green;
    text-align: center;
}
</style>
</head>

<body>

<div class="navbar">
    <div class="logo">ManSparsh</div>
</div>

<div class="signup-container">
    <h2>Edit Profile</h2>
<% if(request.getAttribute("success") != null){ %>
    <p class="success">Profile updated successfully!</p>
<% } %>
    <form method="post" action="CounselorEditProfileProcess.jsp" >

        <label>Full Name</label>
        <input type="text" id="name" name="name" value="<%= counselorName %>" required>

        <label>Email</label>
        <input type="email" value="<%= counselorEmail %>" readonly>

        <hr>

        <h3 style="text-align:center;">Change Password</h3>

        <label>Current Password</label>
        <input type="password" name="currentPassword">
       

        <label>New Password</label>
        <input type="password" id="password" name="newPassword">

        <label>Confirm New Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword">

        <p id="passError" class="error" style="display:none;">
            Passwords do not match
        </p>

        <p id="strengthError" class="error" style="display:none;">
            Password must contain uppercase, lowercase, number & special character
        </p>

        <button type="submit">Save Changes</button>

        <% if(request.getAttribute("passwordError") != null){ %>
            <p class="error"><%= request.getAttribute("passwordError") %></p>
        <% } %>

       

    </form>
</div>

<script>
function validateForm() {

    var pass = document.getElementById("password").value;
    var confirm = document.getElementById("confirmPassword").value;

    var strongPass = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/;

    document.getElementById("passError").style.display = "none";
    document.getElementById("strengthError").style.display = "none";

    // Only validate if user enters new password
    if(pass.length > 0){

        if(!strongPass.test(pass)){
            document.getElementById("strengthError").style.display = "block";
            return false;
        }

        if(pass !== confirm){
            document.getElementById("passError").style.display = "block";
            return false;
        }
    }

    return true;
}
</script>

</body>
</html>
