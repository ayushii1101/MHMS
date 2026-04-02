<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>

<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    background: #f5f5f5;
}

/* Navbar */
.navbar {
    <div class="user-profile" onclick="toggleDropdown()">

    display: flex;
    justify-content: flex-end;
    align-items: center;
    background: #2563eb;
    padding: 10px 20px;
    color: white;
}

/* User profile container */
.user-profile {
    <div class="dropdown" id="profileDropdown">

    position: relative;
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
}

.user-profile img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: 2px solid white;
}

.user-profile span {
    font-size: 14px;
}

/* Dropdown */
.dropdown {
    display: none;
    position: absolute;
    right: 0;
    top: 50px;
    background: white;
    min-width: 180px;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    z-index: 100;
}

.dropdown a {
    display: block;
    padding: 12px 18px;
    text-decoration: none;
    color: #333;
}

.dropdown a:hover {
    background: #f0f0f0;
}
</style>
</head>

<body>

<div class="navbar">
    <div class="user-profile" onclick="toggleDropdown()">
        <img src="https://images.unsplash.com/photo-1603415526960-f7fef4ef79fc?auto=format&fit=crop&w=80&q=80">
        <span>Student</span>

        <div class="dropdown" id="profileDropdown">
            <a href="editProfile.jsp">✏ Edit Profile</a>
            <a href="notifications.jsp">