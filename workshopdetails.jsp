<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>

<%
String id = request.getParameter("id");
if(id == null){
    out.println("Invalid workshop ID");
    return;
}

int workshopId = Integer.parseInt(id);

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
InputStream imageStream = null;

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh", "bns", "bns");

    ps = con.prepareStatement(
        "SELECT template_image FROM WORKSHOP WHERE workshop_id=? AND status='ACTIVE'"
    );
    ps.setInt(1, workshopId);
    rs = ps.executeQuery();

    if(rs.next()){
        imageStream = rs.getBinaryStream("template_image");
    } else {
        out.println("No image found for this workshop.");
        return;
    }

} catch(Exception e){
    out.println("Error: " + e.getMessage());
    return;
} finally {
    if(rs != null) try { rs.close(); } catch(Exception e){}
    if(ps != null) try { ps.close(); } catch(Exception e){}
    if(con != null) try { con.close(); } catch(Exception e){}
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Workshop Image</title>
    <style>
        body{
            margin:0;
            display:flex;
            align-items:center;
            justify-content:center;
            min-height:100vh;
            background:#f4f6fb;
            font-family: Arial, sans-serif;
        }
        img{
            max-width:90%;
            max-height:90vh;
            border-radius:16px;
            box-shadow:0 10px 25px rgba(0,0,0,0.2);
        }
        a.back-btn{
            position:fixed;
            top:20px;
            left:20px;
            text-decoration:none;
            color:white;
            background:#4c51bf;
            padding:10px 20px;
            border-radius:12px;
        }
        a.back-btn:hover{
            background:#4338ca;
        }
    </style>
</head>
<body>

<a href="workshop.jsp" class="back-btn">← Back to Workshops</a>

<%
if(imageStream != null){
    // Convert BLOB to Base64
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    byte[] buffer = new byte[1024];
    int bytesRead;
    while((bytesRead = imageStream.read(buffer)) != -1){
        baos.write(buffer, 0, bytesRead);
    }
    String base64Image = java.util.Base64.getEncoder().encodeToString(baos.toByteArray());
%>
    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Workshop Image">
<%
} else {
%>
    <p>No image available.</p>
<%
}
%>

</body>
</html>
