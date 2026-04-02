<%@ page import="java.sql.*, java.util.*" %>

<%
String dateStr = request.getParameter("date");
if(dateStr == null){
    return;
}

java.sql.Date sqlDate = java.sql.Date.valueOf(dateStr);

Calendar cal = Calendar.getInstance();
cal.setTime(sqlDate);

String[] days = {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
String day = days[cal.get(Calendar.DAY_OF_WEEK) - 1];

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns"
    );

    ps = con.prepareStatement(
        "SELECT counselor_id, time_slot " +
        "FROM counselor_timetable ct " +
        "WHERE day=? " +
        "AND time_slot NOT IN ( " +
        "   SELECT time_slot FROM appointment a " +
        "   WHERE a.appointment_date=? " +
        "   AND a.status='SCHEDULED' " +
        "   AND a.counselor_id = ct.counselor_id " +
        ")"
    );
    ps.setString(1, day);
    ps.setDate(2, sqlDate);
    rs = ps.executeQuery();

    out.print("<option value=''>Select Time Slot</option>");

    boolean found = false;

    // ==== Current time + 1 hour buffer ====
    Calendar nowBuffer = Calendar.getInstance();
    nowBuffer.add(Calendar.HOUR_OF_DAY, 1);
    int bufferHour = nowBuffer.get(Calendar.HOUR_OF_DAY);
    int bufferMinute = nowBuffer.get(Calendar.MINUTE);

    // ==== Compare only dates (ignore time) ====
    Calendar todayCal = Calendar.getInstance();
    todayCal.set(Calendar.HOUR_OF_DAY,0); todayCal.set(Calendar.MINUTE,0);
    todayCal.set(Calendar.SECOND,0); todayCal.set(Calendar.MILLISECOND,0);

    Calendar selectedCal = Calendar.getInstance();
    selectedCal.setTime(sqlDate);

    boolean isToday = todayCal.get(Calendar.YEAR) == selectedCal.get(Calendar.YEAR)
        && todayCal.get(Calendar.MONTH) == selectedCal.get(Calendar.MONTH)
        && todayCal.get(Calendar.DAY_OF_MONTH) == selectedCal.get(Calendar.DAY_OF_MONTH);

    while(rs.next()){
        String timeSlot = rs.getString("time_slot"); // "09-10" or "09:30-10:30"
        String startTime = timeSlot.split("-")[0].trim();

        int slotHour = 0;
        int slotMinute = 0;

        if(startTime.contains(":")){
            String[] hm = startTime.split(":");
            slotHour = Integer.parseInt(hm[0].trim());
            slotMinute = Integer.parseInt(hm[1].trim());
        } else {
            slotHour = Integer.parseInt(startTime);
            slotMinute = 0;
        }

        boolean showSlot = true;

        if(isToday){
            // Hide slots before current time + buffer
            if(slotHour < bufferHour || (slotHour == bufferHour && slotMinute < bufferMinute)){
                showSlot = false;
            }
        }

        if(showSlot){
            found = true;
            out.print("<option value='"+timeSlot+"' data-counselor='"+rs.getInt("counselor_id")+"'>"+timeSlot+"</option>");
        }
    }

    if(!found){
        out.print("<option>No slots available</option>");
    }

}catch(Exception e){
    out.print("<option>Error loading slots</option>");
}finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>