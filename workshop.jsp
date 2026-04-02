<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.io.InputStream, java.io.ByteArrayOutputStream, sun.misc.BASE64Encoder" %>

<!DOCTYPE html>
<html>
<head>
<title>Workshops</title>

<style>
body{
    margin:0;
    font-family: "Segoe UI", Arial, sans-serif;
    background-image:url("https://images.unsplash.com/photo-1529333166437-7750a6dd5a70?auto=format&fit=crop&w=1600&q=80");
    background-size:cover;
    background-position:center;
    min-height:100vh;
}
.overlay{
    background:rgba(255,255,255,0.75);
    backdrop-filter: blur(4px);
    min-height:100vh;
    padding:60px 20px;
}
.container{
    max-width:800px;
    margin:auto;
    background:rgba(255,255,255,0.95);
    border-radius:16px;
    box-shadow:0 15px 35px rgba(0,0,0,0.25);
    padding:35px;
}
h1{
    text-align:center;
    color:#4c51bf;
    margin-bottom:35px;
}
table{
    width:100%;
    border-collapse:collapse;
    font-size:16px;
}
th, td{
    padding:14px;
    border-bottom:1px solid #eee;
}
th{
    background:#eef2ff;
    color:#4c51bf;
}
tr:hover{
    background:#f1f5ff;
    cursor:pointer;
}
</style>
</head>

<body>
<div class="overlay">
<div class="container">

<h1>Workshops</h1>
<h2 style="color:#4c51bf;">Upcoming Workshops</h2>

<table>
<tr>
    <th>#</th>
    <th>Workshop Name</th>
    <th>Date</th>
    <th>Time</th>
    <th>Venue</th>
</tr>

<%
int count = 1;
boolean found = false;
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

String pastSql =
"SELECT workshop_id, title, workshop_date, workshop_time, venue, template_image " +
"FROM WORKSHOP " +
"WHERE status='ACTIVE' AND TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) < CURRENT_TIMESTAMP " +
"ORDER BY TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) DESC";
try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    String upcomingSql =
    "SELECT workshop_id, title, workshop_date, workshop_time, venue, template_image " +
    "FROM WORKSHOP " +
    "WHERE status='ACTIVE' AND TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) >= CURRENT_TIMESTAMP " +
    "ORDER BY TIMESTAMP(workshop_date, CAST(workshop_time AS TIME)) ASC";
    ps = con.prepareStatement(upcomingSql);
    rs = ps.executeQuery();
    while(rs.next()){
        found = true;
%>
<%
InputStream imageStream = rs.getBinaryStream("template_image");
String base64Image = "";
if(imageStream != null){
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    byte[] buffer = new byte[1024];
    int bytesRead;
    while((bytesRead = imageStream.read(buffer)) != -1){
        baos.write(buffer, 0, bytesRead);
    }
    sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
    base64Image = encoder.encode(baos.toByteArray());
    // remove all newlines
    base64Image = base64Image.replaceAll("\\r|\\n", "");
}
%>

<tr onclick="showImage('<%= base64Image %>')">
    <td><%= count++ %></td>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getDate("workshop_date") %></td>
    <td><%= rs.getString("workshop_time") %></td>
    <td><%= rs.getString("venue") %></td>
</tr>

<%
    }

    if(!found){
        out.println("<tr><td colspan='5' style='text-align:center; color:#666; padding:20px;'>No workshops are currently scheduled.</td></tr>");
    }


%>

</table>

<h2 style="color:#4c51bf; margin-top:40px;">Past Workshops</h2>

<table>
   
<tr>
    <th>#</th>
    <th>Workshop Name</th>
    <th>Date</th>
    <th>Time</th>
    <th>Venue</th>
</tr>

<%
int pastCount = 1;
boolean pastFound = false;

ps = con.prepareStatement(pastSql);
rs = ps.executeQuery();

while(rs.next()){
    pastFound = true;
%>

<%
InputStream imageStream = rs.getBinaryStream("template_image");
String base64Image = "";
if(imageStream != null){
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    byte[] buffer = new byte[1024];
    int bytesRead;
    while((bytesRead = imageStream.read(buffer)) != -1){
        baos.write(buffer, 0, bytesRead);
    }
    sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
    base64Image = encoder.encode(baos.toByteArray());
    base64Image = base64Image.replaceAll("\\r|\\n", "");
}
%>

<tr onclick="showImage('<%= base64Image %>')">
    <td><%= pastCount++ %></td>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getDate("workshop_date") %></td>
    <td><%= rs.getString("workshop_time") %></td>
    <td><%= rs.getString("venue") %></td>
</tr>

<%
}

if(!pastFound){
    out.println("<tr><td colspan='5' style='text-align:center; color:#666; padding:20px;'>No past workshops.</td></tr>");
}
if(rs != null) rs.close();
if(ps != null) ps.close();
if(con != null) con.close();
}
catch(Exception e){
    e.printStackTrace();
    out.println("<tr><td colspan='5' style='color:red;text-align:center;'>Error loading workshops</td></tr>");
}
%>

</table>

</div>
</div>

<script>
function showImage(base64){
    var modal = document.getElementById('imgModal');
    var img = document.getElementById('modalImage');
    img.src = "data:image/jpeg;base64," + base64;
    modal.style.display = "flex";
}
</script>

<!-- Image Modal -->
<div id="imgModal" onclick="this.style.display='none'" style="display:none;position:fixed;z-index:1000;left:0;top:0;width:100%;height:100%;background: rgba(0,0,0,0.7);align-items:center;justify-content:center;">
    <span onclick="document.getElementById('imgModal').style.display='none'" style="position:absolute;top:20px;right:30px;font-size:40px;color:white;cursor:pointer;">&times;</span>
    <img id="modalImage" src="" style="max-width:90%;max-height:90%;border-radius:12px;box-shadow:0 10px 25px rgba(0,0,0,0.3);">
</div>

</body>
</html>
