<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
Connection con = null;
PreparedStatement ps = null;
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")) {

    String title = request.getParameter("workshop-name");
    String date = request.getParameter("workshop-date");
    String time = request.getParameter("workshop-time");
    String venue = request.getParameter("workshop-venue");
    Part imagePart = request.getPart("templateImage");
    Integer cid = (Integer) session.getAttribute("counselorId");

    if(cid == null){
        msg = "Session expired. Please login again.";
    }
    else if(imagePart == null || imagePart.getSize() == 0){
        msg = "Please upload workshop template image.";
    }
    else {
        int counselorId = cid;

        InputStream imageStream = imagePart.getInputStream();

        Class.forName("org.apache.derby.jdbc.ClientDriver");
        con = DriverManager.getConnection(
            "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

        ps = con.prepareStatement(
          "INSERT INTO WORKSHOP (title, workshop_date, workshop_time, venue, template_image, posted_by_role, posted_by_id) VALUES (?,?,?,?,?,?,?)");

        ps.setString(1, title);
        ps.setDate(2, java.sql.Date.valueOf(date));
        ps.setString(3, time);
        ps.setString(4, venue);
        ps.setBlob(5, imageStream);
        ps.setString(6, "COUNSELLOR");
        ps.setInt(7, counselorId);

        ps.executeUpdate();
        msg = "Workshop added successfully!";
        con.close();
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Faculty Workshops</title>
  <style>
    body{
      margin:0;
      font-family:Arial, sans-serif;
      background:#f4f6fb;
    }

    .container{
      max-width:450px;
      margin:80px auto;
      background:white;
      padding:35px;
      border-radius:16px;
      box-shadow:0 10px 25px rgba(0,0,0,0.15);
    }

    h2{
      text-align:center;
      margin-bottom:25px;
      color:#4f46e5;
    }

    label{
      font-weight:600;
      display:block;
      margin-bottom:5px;
    }

    input, select{
      width:100%;
      padding:10px;
      margin-bottom:15px;
      border-radius:8px;
      border:1px solid #ccc;
      box-sizing:border-box;
    }

    button{
      width:100%;
      padding:12px;
      background:#4f46e5;
      color:white;
      border:none;
      border-radius:20px;
      font-size:16px;
      cursor:pointer;
    }

    button:hover{
      background:#4338ca;
    }

    .success{
      text-align:center;
      color:green;
      margin-bottom:15px;
    }
    .auto-height {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border-radius: 8px;
    border: 1px solid #ccc;
    box-sizing: border-box;
    font-family: inherit;
    resize: vertical;
    min-height: 120px;  /* Minimum height matches placeholder */
    height: auto;       /* Grows with content */
}

.auto-height:focus {
    outline: none;
    border-color: #4f46e5;
    box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}

  </style>
</head>
<body>

  <div class="container">
    <h2>Add Workshop </h2>
    <% if(!msg.equals("")){ %>
        <div class="success"><%= msg %></div>
    <% } %>

    <!-- Optional success message -->
    <!-- <div class="success">Your workshop has been scheduled!</div> -->

    <form method="post" action="CounselorWorkshops.jsp" enctype="multipart/form-data">
       
      <label for="workshop-name">Workshop Name</label>
      <input type="text" id="workshop-name" name="workshop-name" placeholder="Enter workshop title" required>
     
      <label for="workshop-date">Date</label>
      <input type="date" id="workshop-date" name="workshop-date" required>

      <label for="workshop-time">Time</label>
      <input type="time" id="workshop-time" name="workshop-time" required>
     
      <label for="workshop-venue">Venue</label>
      <input type="text" id="workshop-venue" name="workshop-venue"
       placeholder="Enter venue"
       required>

      <label>Workshop Template (Image)</label>
      <input type="file" name="templateImage" accept="image/*" required>

      <button type="submit">Submit</button>
    </form>
  </div>

</body>
</html>