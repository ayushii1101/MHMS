<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Counsellor Login</title>
    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #f3f4f6;
        }
        .login-container {
            max-width: 400px;
            margin: 120px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
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

        h2 {
            text-align: center;
        }
        input { 
            width: 100%; 
            padding: 12px; 
            margin: 8px 0; 
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
            margin: 12px 0; 
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
        .toggle { 
            display: flex; 
            gap: 12px; 
            margin: 20px 0; 
            background: rgba(79, 70, 229, 0.1); 
            border-radius: 10px; 
            padding: 4px;
        }
        .toggle button { 
            flex: 1; 
            background: transparent; 
            color: #4F46E5; 
            width: auto; 
            margin: 0; 
            padding: 12px 8px;
            font-weight: 500;
            box-shadow: none;
            border-radius: 6px;
        }
        .toggle button.active { 
            background: linear-gradient(135deg, #4F46E5, #7C3AED); 
            color: white; 
        }
        .tab { display: none; }
        .tab.active { display: block; }
        a { color: #4F46E5; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
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
        </div>
        </div>
        <a href="ContactUs.jsp">Contact Us</a>
    </div>
    </div>
    <div class="login-container">
    <h2>Counsellor Login</h2>
    
    <!-- Login Tab -->
    <div id="login" class="tab active">
        <form method="post" action="CounselorLoginProcess.jsp">
            <input type="hidden" name="role" value="counselor">
            
            <label>Email:</label>
            <input type="text" name="counselorEmail" id="emailBox" required value="<%= request.getAttribute("enteredEmail") != null ? request.getAttribute("enteredEmail") : "" %>">

            <label>Password:</label>
            <input type="password" name="password" required>
            
            <button type="submit">Login</button>
            
            <%
            String loginError = (String) request.getAttribute("loginError");
            if(loginError != null){
            %>
            <p style="color:red; text-align:center; font-weight:bold;"><%= loginError %></p>
            <% } %>
            <p style="text-align: center; margin-top: 15px;">
                <a href="#" onclick="goForgot()" style="font-size:15px; font-weight:400">
                    Forgot Password?
                </a>
            </p>
        </form>
    </div>
            </div>
            <script>
            function goForgot(){
                var email = document.getElementById("emailBox").value;

                if(email === ""){
                    alert("Please enter your email first.");
                    return;
                }

                window.location = "ForgotPassword.jsp?role=counselor&email=" + encodeURIComponent(email);
            }
            </script>

</body>
</html>