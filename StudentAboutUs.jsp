<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String studentName = (String) session.getAttribute("studentName");
if(studentName == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us</title>
    <style>
        body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
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
            position: relative;
            z-index: 2000;
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
        .nav-right{display:flex;align-items:center;gap:20px;}
        .student-mini{display:flex;align-items:center;gap:8px;background:rgba(255,255,255,0.2);padding:5px 12px;border-radius:20px;cursor:pointer;position:relative;}
        .student-mini span{
            color: white;
            font-weight: 500;
        }

        .student-mini img{width:30px;height:30px;border-radius:50%;}
        .profile-dropdown{display:none;position:absolute;top:45px;right:0;background:white;min-width:180px;border-radius:12px;box-shadow:0 12px 25px rgba(0,0,0,0.25);overflow:hidden;z-index:999;}
        .profile-dropdown a{display:block;padding:12px 16px;text-decoration:none;color:#333;font-size:14px;}
        .profile-dropdown a:hover{background:#f1f5f9;}

        /* LOGIN DROPDOWN */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown > a {
            cursor: pointer;
            padding: 20px 15px;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 180px;
            top: 100%;
            right: 0;
            border-radius: 6px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            z-index: 9999;
        }

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

        .dropdown:hover .dropdown-content {
            display: block;
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


        @media(max-width: 768px) {
            .hero h1 {
                font-size: 32px;
                padding: 10px 20px;
            }
            .nav-links a {
                margin: 0 8px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
  <div class="logo">ManSparsh</div>
    <div class="nav-right">
    <div class="nav-links">
      <a href="StudentDashboard.jsp">Home</a>
      <a href="StudentAboutUs.jsp">About Us</a>
      <a href="StudentFeatures.jsp">Features</a>
      <a href="StudentContactUs.jsp">Contact Us</a>
    </div>

    <div class="student-mini" onclick="toggleProfile()">
      <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png">
      <span><%= studentName %></span>
      <div class="profile-dropdown" id="profileDropdown">
        <a href="StudentEditProfile.jsp">Edit</a>
        <a href="help.jsp">Help</a>
        <a href="feedback.jsp">Send Feedback</a>
        <a href="logout.jsp">Logout</a>
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
<script>
function toggleProfile(){
  const d=document.getElementById("profileDropdown");
  d.style.display=(d.style.display==="block")?"none":"block";
}
document.addEventListener("click",function(e){
  const p=document.querySelector(".student-mini");
  const d=document.getElementById("profileDropdown");
  if(!p.contains(e.target)){ d.style.display="none"; }
});
function sendMsg(){
  var i=document.getElementById("msg"), c=document.getElementById("chatBox");
  if(i.value.trim()=="") return;
  c.innerHTML+="<p><b>You:</b> "+i.value+"</p><p><b>Saathi:</b> I’m listening.</p>";
  i.value=""; c.scrollTop=c.scrollHeight;
}
</script>
</body>
</html>
