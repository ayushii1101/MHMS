<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up – ManSparsh</title>
    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #f3f4f6;
        }

        /* NAVBAR */
        .navbar {
            background-color: #6f63ff;
            height: 60px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            box-sizing: border-box;
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
            font-size: 16px;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }
        /* LOGIN DROPDOWN */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown > a {
            cursor: pointer;
        }

        /* Hidden menu */
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 180px;
            top: 100%;       /* instead of 45px */
            right: 0;
            border-radius: 6px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            z-index: 9999;
        }


        /* Links inside dropdown */
        .dropdown-content a {
            color: #333;
            padding: 12px 16px;
            display: block;
            text-decoration: none;
            font-size: 14px;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        /* Show dropdown on hover */
        .dropdown:hover .dropdown-content {
            display: block;
        }
        .dropdown > a {
            cursor: pointer;
            padding: 20px 15px;   /* hover area bada ho jayega */
            display: inline-block;
        }

        /* SIGNUP FORM */
        .signup-container {
            max-width: 400px;
            margin: 100px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        input { 
            width: 100%; 
            padding: 12px; 
            margin: 10px 0; 
            box-sizing: border-box; 
            border: 1px solid #ddd; 
            border-radius: 4px;
        }

        button { 
            background: linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%); 
            color: white; 
            padding: 14px; 
            width: 100%; 
            border: none; 
            cursor: pointer; 
            margin: 15px 0; 
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3);
        }

        button:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4);
            background: linear-gradient(135deg, #4338CA 0%, #6D28D9 100%);
        }

        p {
            text-align: center;
            margin-top: 10px;
        }

        a { 
            color: #4F46E5; 
            text-decoration: none; 
        }

        a:hover { 
            text-decoration: underline; 
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>
    <div class="nav-links">
        <a href="Home Page.jsp">Home</a>
        <a href="AboutUs.jsp">About Us</a>
        <a href="Features.jsp">Features</a>
        <div class="dropdown">
        <a>Login</a>
        <div class="dropdown-content">
            <a href="StudentLogin.jsp">Student</a>
            <a href="CounselorLogin.jsp">Counselor</a>
            <a href="FacultyLogin.jsp">Faculty</a>
            <a href="AdminLogin.jsp">Admin</a>
        </div>
        </div>
        <a href="ContactUs.jsp">Contact Us</a>
    </div>
</div>

<!-- SIGNUP FORM -->
<div class="signup-container">
    <h2>Create Account</h2>
    <form method="post" action="signupProcess.jsp" onsubmit="return validateForm();">

        <label>Email:</label>
        <input type="email" id="email" name="studentId" required>

        <p id="emailError" style="color:red; font-size:14px; display:none;">
        Only Banasthali email id allowed
        </p>

        <label>Name:</label>
        <input type="text" id="name" name="name" required>
        <p id="nameError" style="color:red; font-size:14px; display:none;">
            Invalid name
        </p>
                <%
        String err2 = request.getParameter("error");
        if("invalidname".equals(err2)){
        %>
        <script>
        window.onload = function() {
            document.getElementById("nameError").style.display = "block";
        };
        </script>
        <%
        }
        %>


        <label>Password:</label>
        <input type="password" id="password" name="password" required>

        <label>Confirm Password:</label>
        <input type="password" id="confirmPassword" required>

        <p id="passError" style="color:red; font-size:14px; display:none;">
        Passwords do not match
        </p>
        <p id="strengthError" style="color:red; font-size:14px; display:none;">
            Password must contain uppercase, lowercase, number & special character
        </p>

        <button type="submit">Create Account</button>

        <%
String err = request.getParameter("error");
if("exists".equals(err)){
%>
    <p style="color:red; text-align:center; font-weight:bold;">
        This email id is already registered.
    </p>
<%
}
%>

    </form>
    
</div>
<script>
function validateForm() {
    var email = document.getElementById("email").value;
    var name = document.getElementById("name").value;
    var pass = document.getElementById("password").value;
    var confirm = document.getElementById("confirmPassword").value;

    var emailPattern = /^[a-zA-Z0-9]+_[a-zA-Z]+@banasthali\.in$/;
    var strongPass = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/;
    // Only letters & space + no more than 2 consecutive same letters
    var namePattern = /^(?!.*([A-Za-z])\1\1)[A-Za-z ]+$/;
    
    // Hide all errors first
    document.getElementById("emailError").style.display = "none";
    document.getElementById("passError").style.display = "none";
    document.getElementById("strengthError").style.display = "none";
    document.getElementById("nameError").style.display = "none";
    
    // Email validation
    if (!emailPattern.test(email)) {
        document.getElementById("emailError").style.display = "block";
        return false;   // stop form
    }
    
    // Name validation
    if (!namePattern.test(name)) {
        document.getElementById("nameError").style.display = "block";
        return false;
    }
    
    // Password strength validation (only if password is entered)
    if (pass.length > 0 && !strongPass.test(pass)) {
        document.getElementById("strengthError").style.display = "block";
        return false;
    }
    
    // Confirm password check (only if new password is entered)
    if (pass.length > 0 && pass !== confirm) {
        document.getElementById("passError").style.display = "block";
        return false;
    }

    return true;  // allow submit
}
</script>

</body>
</html>