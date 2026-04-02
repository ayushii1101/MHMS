<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.xml.bind.DatatypeConverter" %>
<%
Connection con = null;
PreparedStatement ps = null;
String msg = request.getParameter("msg");
if(msg == null) msg = "";
Connection con2 = null;
PreparedStatement ps2 = null;
ResultSet rs2 = null;
Integer cid2 = (Integer) session.getAttribute("counselor_id");
if(request.getMethod().equalsIgnoreCase("POST")) {

    String title = request.getParameter("workshop-name");
    String date = request.getParameter("workshop-date");
    String time = request.getParameter("workshop-time");
    String venue = request.getParameter("workshop-venue");
    Part imagePart = request.getPart("templateImage");
    Integer cid = (Integer) session.getAttribute("counselor_id");

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

        ps = con.prepareStatement("INSERT INTO WORKSHOP (title, workshop_date, workshop_time, venue, template_image, posted_by_role, posted_by_id, status) VALUES (?,?,?,?,?,?,?,?)");  

        ps.setString(1, title);
        ps.setDate(2, java.sql.Date.valueOf(date));
        ps.setString(3, time);
        ps.setString(4, venue);
        ps.setBlob(5, imageStream);
        ps.setString(6, "COUNSELLOR");
        ps.setInt(7, counselorId);
        ps.setString(8, "ACTIVE");

        ps.executeUpdate();
        msg = "Workshop added successfully!";
        con.close();
        ps.close();
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Counselor Workshops</title>
  <style>
    body{
      margin:0;
      font-family:Arial, sans-serif;
      background:#f4f6fb;
    }

    .container{
      max-width:900px;
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
  background:#4f46e5;
  color:white;
  border:none;
  cursor:pointer;
  padding:6px 12px;
  margin:2px;
  border-radius:6px;
  font-size:14px;
  width:90px;
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
table{
  width:100%;
  border-collapse:collapse;
  background:white;
}

th{
  background:#eef2ff;
  color:#4f46e5;
}

td, th{
  padding:12px;
  border-bottom:1px solid #ddd;
}
tr:hover{
  background:#f1f5ff;
  cursor:pointer;
}
  </style>
</head>
<body>

  <div class="container" style="max-width:450px;">
    <h2>Add Workshop </h2>
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
   
    <div class="container" style="max-width:1100px; margin-top:40px;">

        <h2 style="text-align:center; color:#4f46e5;">Upcoming Workshops</h2>
        <table border="1" width="100%" cellpadding="10">
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Date</th>
                <th>Time</th>
                <th>Venue</th>
                <th>Action</th>
            </tr>
           
            <%
                if(cid2 == null){
                out.println("<h3 style='color:red;text-align:center;'>Session expired. Please login again.</h3>");
                return;
            }
            int ucount = 1;
            boolean ufound = false;

            try{
                Class.forName("org.apache.derby.jdbc.ClientDriver");

                con2 = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

                String upcomingSql =
                "SELECT workshop_id, title, workshop_date, workshop_time, venue, template_image FROM WORKSHOP WHERE posted_by_role='COUNSELLOR' AND posted_by_id=? " +
                "AND status='ACTIVE' AND TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) >= CURRENT_TIMESTAMP " +
                "ORDER BY TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) ASC";

                ps2 = con2.prepareStatement(upcomingSql);
                ps2.setInt(1, cid2);

                rs2 = ps2.executeQuery();
               
                while(rs2.next()){
                    ufound = true;
                InputStream imageStream = rs2.getBinaryStream("template_image");
                String base64Image = "";

                if(imageStream != null){
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while((bytesRead = imageStream.read(buffer)) != -1){
                        baos.write(buffer, 0, bytesRead);
                    }
                   
                    base64Image = DatatypeConverter.printBase64Binary(baos.toByteArray());
                    base64Image = base64Image.replaceAll("\\r|\\n", "");
                }    
            %>

            <tr onclick="showImage('<%= base64Image %>')">
                <td><%= ucount++ %></td>
                <td><%= rs2.getString("title") %></td>
                <td><%= rs2.getDate("workshop_date") %></td>
                <td><%= rs2.getString("workshop_time") %></td>
                <td><%= rs2.getString("venue") %></td>
                <td>
                    <button onclick="event.stopPropagation(); confirmCancel(<%= rs2.getInt("workshop_id") %>)">Cancel</button>
                </td>
            </tr>
            <%
                }

                if(!ufound){
            %>
            <tr><td colspan="6" style="text-align:center;">No upcoming workshops</td></tr>
            <%
                }

            }catch(Exception e){
                e.printStackTrace();
            }
            %>
        </table>

        <h2 style="text-align:center; margin-top:40px; color:#4f46e5;">Past Workshops</h2>
        <table border="1" width="100%" cellpadding="10">
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Date</th>
                <th>Time</th>
                <th>Venue</th>
            </tr>
            <%
                int pcount = 1;
                boolean pfound = false;
                try{
                    Class.forName("org.apache.derby.jdbc.ClientDriver");

                    if(con2 == null || con2.isClosed()){
                        con2 = DriverManager.getConnection(
                            "jdbc:derby://localhost:1527/ManSparsh","bns","bns");
                    }
                    String pastSql =
                    "SELECT workshop_id, title, workshop_date, workshop_time, venue, template_image FROM WORKSHOP WHERE posted_by_role='COUNSELLOR' AND posted_by_id=? " +
                    "AND status='ACTIVE' AND TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) < CURRENT_TIMESTAMP " +
                    "ORDER BY TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) DESC";

                    ps2 = con2.prepareStatement(pastSql);
                    ps2.setInt(1, cid2);

                    rs2 = ps2.executeQuery();

                    while(rs2.next()){
                        pfound = true;
                    InputStream imageStream = rs2.getBinaryStream("template_image");
                    String base64Image = "";

                    if(imageStream != null){
                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while((bytesRead = imageStream.read(buffer)) != -1){
                            baos.write(buffer, 0, bytesRead);
                        }
                        base64Image = DatatypeConverter.printBase64Binary(baos.toByteArray());
                        base64Image = base64Image.replaceAll("\\r|\\n", "");
                    }    
            %>
            <tr onclick="showImage('<%= base64Image %>')">
                <td><%= pcount++ %></td>
                <td><%= rs2.getString("title") %></td>
                <td><%= rs2.getDate("workshop_date") %></td>
                <td><%= rs2.getString("workshop_time") %></td>
                <td><%= rs2.getString("venue") %></td>
            </tr>
            <%
                }
                if(!pfound){
            %>
            <tr><td colspan="5" style="text-align:center;">No past workshops</td></tr>
            <%
                }
                    if(rs2 != null) rs2.close();
                    if(ps2 != null) ps2.close();
                    if(con2 != null) con2.close();
                }catch(Exception e){
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
        <script>
function showImage(base64){
    var modal = document.getElementById('imgModal');
    var img = document.getElementById('modalImage');
    img.src = "data:image/jpeg;base64," + base64;
    modal.style.display = "flex";
}
function confirmCancel(id){
    var confirmBox = document.getElementById("confirmBox");
    confirmBox.style.display = "flex";
    document.getElementById("workshopId").value = id;
}
window.onload = function(){
    var msg = "<%= msg %>";

    if(msg && msg !== ""){
        var popup = document.getElementById("popupMsg");
        var text = document.getElementById("popupText");
        var icon = document.getElementById("popupIcon");

        text.innerText = msg;

        if(msg.toLowerCase().includes("error")){
            icon.innerHTML = "❌";
            icon.style.color = "red";
        } else {
            icon.innerHTML = "✔";
            icon.style.color = "green";
        }

        popup.style.display = "block";

        setTimeout(function(){
            popup.style.display = "none";
        }, 1000);
    }
}
</script>

<div id="imgModal" onclick="this.style.display='none'"
style="display:none;position:fixed;z-index:1000;left:0;top:0;width:100%;height:100%;background: rgba(0,0,0,0.7);align-items:center;justify-content:center;">
   
    <span style="position:absolute;top:20px;right:30px;font-size:40px;color:white;cursor:pointer;">&times;</span>
   
    <img id="modalImage" src=""
    style="max-width:90%;max-height:90%;border-radius:12px;">
</div>
<div id="confirmBox" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;
background:rgba(0,0,0,0.5);justify-content:center;align-items:center;">

    <div style="background:white;padding:30px;border-radius:10px;text-align:center;">
        <h3>Are you sure you want to delete this workshop?</h3>

        <form method="post" action="CancelWorkshop.jsp">
            <input type="hidden" name="id" id="workshopId">
            <button type="submit">Yes</button>
            <button type="button" onclick="document.getElementById('confirmBox').style.display='none'">No</button>
        </form>
    </div>
</div>
<div id="popupMsg" style="
display:none;
position:fixed;
top:50%;
left:50%;
transform:translate(-50%, -50%);
background:white;
padding:25px 40px;
border-radius:12px;
box-shadow:0 10px 25px rgba(0,0,0,0.2);
text-align:center;
z-index:2000;
">
    <div id="popupIcon" style="font-size:40px;"></div>
    <div id="popupText" style="margin-top:10px;font-size:16px;font-weight:600;"></div>
</div>
</body>
</html>