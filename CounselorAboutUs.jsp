<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us</title>
    <style>
        body{ margin:0; font-family:Arial, sans-serif; background:#f4f6fb; }

        .navbar{
            background:#6f63ff; height:60px; display:flex;
            align-items:center; justify-content:space-between;
            padding:0 40px; color:white; position:relative;
        }

        .logo{ font-size:26px; font-weight:bold; }
        .nav-right{ display:flex; align-items:center; gap:20px; }

        .nav-links a{
            color:white; text-decoration:none; margin:0 12px; font-size:16px;
        }

        .student-mini{
            display:flex; align-items:center; gap:8px;
            background:rgba(255,255,255,0.2); padding:5px 12px;
            border-radius:20px; cursor:pointer; position:relative;
        }

        .student-mini img{ width:30px; height:30px; border-radius:50%; }

        .profile-dropdown{
            display:none; position:absolute; top:45px; right:0;
            background:white; min-width:200px; border-radius:12px;
            box-shadow:0 12px 30px rgba(0,0,0,0.25); overflow:hidden; z-index:1000;
        }

        .profile-dropdown a{
            display:block; padding:12px 18px; text-decoration:none;
            color:#333; font-size:15px;
        }

        .profile-dropdown a:hover{ background:#f1f5f9; }
        /* PURE CSS DROPDOWN - No JavaScript */
        .profile-section {
            position: relative;
            cursor: pointer;
        }

        .faculty-mini {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.2);
            padding: 8px 16px;
            border-radius: 25px;
            transition: all 0.3s;
        }

        .faculty-mini:hover {
            background: rgba(255,255,255,0.3);
        }

        /* CSS-ONLY CHECKBOX HACK */
        .profile-dropdown {
            display: none;
            position: absolute;
            top: 100%; right: 0;
            margin-top: 8px;
            min-width: 220px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 16px 40px rgba(0,0,0,0.2);
            border: 1px solid #f1f5f9;
            overflow: hidden;
            z-index: 1000;
            opacity: 0;
            transform: translateY(-8px);
            transition: all 0.25s ease-out;
        }

        /* SHOW ON HOVER */


        /* HOVER OUT DELAY (Smooth) */
        .profile-section {
            --close-delay: 0.2s;
        }

        .profile-dropdown a {
            display: block;
            padding: 16px 20px;
            color: #475569;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            border-bottom: 1px solid #f8fafc;
            transition: all 0.2s;
        }

        .profile-dropdown a:last-child { border-bottom: none; }

        .profile-dropdown a:hover {
            background: linear-gradient(90deg, #f8fafc, #f1f5f9);
            color: #6f63ff;
            padding-left: 28px;
        }
        /* MAGIC: SHOW WHEN CHECKBOX CHECKED */
        .profile-section #profileToggle:checked ~ .profile-dropdown {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }
        .toggle-checkbox {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .profile-dropdown {
                right: auto;
                left: 0;
                min-width: 200px;
            }
        }

        /* HERO IMAGE */
        .hero {
            width: 100%;
            height: 600px;
            background: url('images/Hero.png') top center / cover no-repeat;
            display: flex;
            align-items: flex-start;   /* ⬅ instead of center */
            justify-content: center;
            padding-top: 60px;        /* ⬅ controls how far from top */
            color: white;
            text-align: center;
            position: relative;
            margin-top: 0;          /* keeps it below navbar */
        }

        .hero h1 {
            font-size: 48px;
            background-color: rgba(0,0,0,0.5); /* semi-transparent box behind text */
            padding: 20px 40px;
            border-radius: 10px;
        }
        /* MAIN CONTENT */
        .content {
            max-width: 900px;
            margin: 50px auto;
            padding: 0 20px;
            text-align: left;
        }

        .content h2 {
            color: #4F46E5;
            margin-bottom: 20px;
        }

        .content p {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 20px;
            color: #333;
        }

        .section {
            margin-bottom: 40px;
        }

        .section h3 {
            color: #4F46E5;
            margin-bottom: 10px;
        }

        .footer {
            background-color: #6f63ff;
            color: white;
            padding: 20px;
            text-align: center;
        }

        @media(max-width: 768px) {
            .hero h1 {
                font-size: 32px;
                padding: 10px 20px;
            }
            .nav-links a {
                margin: 0 8px;
            }
        }
        .footer-desc{
    max-width: 100vw;
    margin: 0 auto;
    font-size: 16px;
    line-height: 1.7;
    text-align: center;
    background: #6f63ff;
    color: white;
    display: flex;
    justify-content: center;   /* Horizontal centering of flex items */
}
    </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>

    <div class="nav-right">
        <div class="nav-links">
            <a href="CounselorDashboard.jsp">Home</a>
            <a href="CounselorAboutUs.jsp">About Us</a>
            <a href="CounselorFeatures.jsp#">Features</a>
            <a href="CounselorContactUs.jsp">Contact</a>
        </div>

    <div class="profile-section">
        <input type="checkbox" id="profileToggle" class="toggle-checkbox">
        <label for="profileToggle" class="student-mini">
            <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
            <span><%= session.getAttribute("counselorName") != null ? session.getAttribute("counselorName") : "Peer Counselor" %></span>
        </label>
        <div class="profile-dropdown" id="profileDropdown">
            <a href="<%= request.getContextPath() %>/CounselorEditProfile.jsp">Edit Profile</a>
            <a href="<%= request.getContextPath() %>/help.jsp">Help</a>
            <a href="<%= request.getContextPath() %>/feedback.jsp">Send Feedback</a>
            <a href="<%= request.getContextPath() %>/homepage.jsp">Logout</a>
        </div>
    </div>


    </div>
</div>

<!-- HERO IMAGE -->
<div class="hero">
    <h1>About Us</h1>
</div>

<!-- MAIN CONTENT -->
<div class="content">
    <div class="section">
        <div class="content">

    <div class="section">
        <div class="section">
    <h2>Welcome to ManSparsh</h2>

    <p>
        ManSparsh is a dedicated Mental Health First Aid platform created with the vision of making mental well-being
        as accessible, acceptable, and essential as physical health care. Just as we seek immediate treatment for a
        physical injury, ManSparsh believes emotional pain also deserves timely care, understanding, and support.
    </p>

    <p>
        In India, mental health is still surrounded by stigma, silence, and uncertainty. Many people struggle not
        because help does not exist, but because they do not know who to talk to, what kind of support they need,
        or whether their problem is “serious enough.” ManSparsh was built to remove this gap by offering a safe,
        reliable, and easy-to-access space where individuals can seek guidance the moment they need it.
    </p>

    <p>
        ManSparsh works on a simple yet powerful idea: mental health is first aid, not a last resort.
        When stress, anxiety, confusion, or emotional pain appears, a timely conversation and the right guidance
        can prevent it from growing into something deeper and more difficult to heal.
    </p>

    <p>
        Designed as a student-centric and responsive platform, ManSparsh provides immediate support through
        counselors and mental health professionals. It helps users understand what they are feeling, what kind
        help is available, and how to access it without fear, hesitation, or judgment.
    </p>

    <p>
        This platform has been specially developed for the students of <strong>Banasthali Vidyapith</strong>,
        keeping in mind their academic environment, emotional challenges, and support needs within the campus.
    </p>

    <p>
        At its core, ManSparsh is committed to building a supportive academic environment where mental
        well-being is prioritized, stigma is reduced, and seeking help is seen as a sign of strength.
        Whether someone needs emotional relief, guidance, or professional counselling,
        <strong>ManSparsh is their first safe step.</strong>
    </p>
</div>

    </div>

</div>

    </div>
</div>

<footer class="footer-desc">
             © 2026 ManSparsh Online Counseling &amp; Therapy. All rights reserved.
         </footer>

</body>
</html>
