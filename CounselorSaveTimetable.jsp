<%@ page import="java.sql.*" %>
<%
Integer counselorId = (Integer) session.getAttribute("counselor_id");
if(counselorId == null){
    out.print("Session expired");
    return;
}

String slotStr = request.getParameter("slots");
if(slotStr == null || slotStr.trim().isEmpty()){
    out.print("No slots selected");
    return;
}
String[] slots = slotStr.split(",");

Connection con = null;
PreparedStatement del = null;
PreparedStatement ins = null;
try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection("jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    del = con.prepareStatement("DELETE FROM counselor_timetable WHERE counselor_id=?");
    del.setInt(1, counselorId);
    del.executeUpdate();

    ins = con.prepareStatement("INSERT INTO counselor_timetable (counselor_id, day, time_slot) VALUES (?,?,?)");
    for(String s : slots){
        String[] parts = s.split("\\|");
        ins.setInt(1, counselorId);
        ins.setString(2, parts[0]);
        ins.setString(3, parts[1]);
        ins.addBatch();
    }
    ins.executeBatch();

    out.print("Timetable saved successfully");
}catch(Exception e){
    e.printStackTrace();
    out.print("Error saving timetable");
}finally{
    if(del!=null) del.close();
    if(ins!=null) ins.close();
    if(con!=null) con.close();
}
%>
