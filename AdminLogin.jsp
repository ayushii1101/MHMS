<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
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
    <div class="login-container">
    <h2>Admin Login</h2>
    
    <!-- Login Tab -->
    <div id="login" class="tab active">
        <form method="post" action="AdminLoginProcess.jsp">
            <input type="hidden" name="role" value="admin">

            <label>Email:</label>
            <input type="email" name="adminEmail" required 
                   value="<%= request.getAttribute("enteredEmail") != null ? request.getAttribute("enteredEmail") : "" %>">

            <label>Password:</label>
            <input type="password" name="password" required>

            <button type="submit">Login</button>

            <%-- Show error if login failed --%>
            <%
            String loginError = (String) request.getAttribute("loginError");
            if(loginError != null){
            %>
            <p style="color:red; text-align:center; font-weight:bold;"><%= loginError %></p>
            <% } %>

            <p style="text-align: center; margin-top: 10px;">
                <a href="AdminSignup.jsp" style="font-size:15px; font-weight:400;">
                    New Admin?
                </a>
                <br>
                <a href="#" onclick="goForgot()" style="font-size:15px; font-weight:400">
                    Forgot Password?
                </a>
            </p>
        </form>
    </div>
</body>
</html>