<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
Integer studentId = (Integer) session.getAttribute("studentId");
if(studentId == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}

// Use old-style ArrayList and HashMap
List appointments = new ArrayList(); // no <>
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
boolean hasScheduled = false;
try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection("jdbc:derby://localhost:1527/ManSparsh","bns","bns");

    String sql =
    "SELECT a.id, a.appointment_date, a.time_slot, a.preferred_mode, a.status, a.meeting_link, " +
    "c.name AS counselor_name " +
    "FROM APPOINTMENT a " +
    "LEFT JOIN COUNSELOR c ON a.counselor_id = c.counselor_id " +
    "WHERE a.student_id=? " +
    "AND a.status IN ('SCHEDULED','MISSED_BY_STUDENT','MISSED_BY_COUNSELOR','CANCELLED_BY_STUDENT','CANCELLED_BY_COUNSELOR') " +
    "ORDER BY a.appointment_date DESC";


    ps = con.prepareStatement(sql);
    ps.setInt(1, studentId);
    rs = ps.executeQuery();
    
    while(rs.next()){

        int apptId = rs.getInt("id");
        java.sql.Date apptDate = rs.getDate("appointment_date");
        String timeSlot = rs.getString("time_slot");
        String status = rs.getString("status");
        if("SCHEDULED".equals(status)){
            hasScheduled = true;
        }
        // REAL-TIME MISSED CHECK (Professional Version)
        if("SCHEDULED".equals(status) && apptDate != null && timeSlot != null){

            java.util.Date now = new java.util.Date();

            String[] times = timeSlot.split("-");

            java.text.SimpleDateFormat sdf =
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

            String apptDateStr =
                new java.text.SimpleDateFormat("yyyy-MM-dd").format(apptDate);

            String endHour = times[1].trim() + ":00";

            java.util.Date endDateTime =
                sdf.parse(apptDateStr + " " + endHour);

            if(now.after(endDateTime)){

                String updateSql =
                    "UPDATE appointment SET status='MISSED_BY_STUDENT' WHERE id=?";

                PreparedStatement updatePs = con.prepareStatement(updateSql);
                updatePs.setInt(1, apptId);
                updatePs.executeUpdate();
                updatePs.close();

                status = "MISSED_BY_STUDENT";
            }
        }
        Map appt = new HashMap();
        appt.put("id", apptId);
        appt.put("date", apptDate);
        appt.put("time", timeSlot);
        appt.put("mode", rs.getString("preferred_mode"));
        appt.put("status", status);
        appt.put("meetingLink", rs.getString("meeting_link"));
        appt.put("counselorName", rs.getString("counselor_name"));

        appointments.add(appt);
    }
    int missCount = 0;

    for(int i=0; i<appointments.size(); i++){
        Map row = (Map) appointments.get(i);
        String st = (String) row.get("status");
        if("MISSED_BY_STUDENT".equals(st)){
            missCount++;
        }
    }

    pageContext.setAttribute("missCount", missCount);

} catch(Exception e) {
    out.println("<p style='color:red;'>DB Error: " + e.getMessage() + "</p>");
} finally {
    try { if(rs != null) rs.close(); } catch(Exception e){}
    try { if(ps != null) ps.close(); } catch(Exception e){}
    try { if(con != null) con.close(); } catch(Exception e){}
}

pageContext.setAttribute("hasScheduled", hasScheduled);
pageContext.setAttribute("appointments", appointments);
%>


<html>
<head>
    <title>My Appointments</title>
    <style>
        body{ font-family: Arial, sans-serif; background:#f4f6fb; margin:0; padding:0; }
        .container { max-width:1200px; margin: 50px auto; padding: 20px; background:white; border-radius:12px; box-shadow:0 12px 30px rgba(0,0,0,0.1); }
        h1{ text-align:center; color:#4a5568; margin-bottom:30px; }
        table{ width:100%; border-collapse:collapse; }
        th, td{ padding:16px; text-align:left; border-bottom:1px solid #f1f5f9; }
        th{ background: linear-gradient(135deg, #6f63ff, #8b7eff); color:white; position:sticky; top:0; }
        tr:hover{ background:#f8fafc; transform: scale(1.01); transition: all 0.2s; }
        .status{ padding:6px 12px; border-radius:20px; font-weight:600; font-size:13px; display:inline-block; }
        .pending{ background:#dbeafe; color:#1e40af; }
        .accepted{ background:#dcfce7; color:#166534; }
        .completed{ background:#f3f4f6; color:#64748b; }
        .time-proposed{ background:#fef3c7; color:#92400e; }
        a.button{ padding:6px 12px; border-radius:12px; text-decoration:none; font-weight:600; margin-right:6px; }
        a.accept{ background:#16a34a; color:white; }
        a.reject{ background:#ef4444; color:white; }
        .button.join{
            background:#2563eb;
            color:white;
        }
        .booked{ background:#dbeafe; color:#1e40af; }
        .cancelled{ background:#fee2e2; color:#991b1b; }
        .missed { background:#fee2e2; color:#991b1b; }
        .scheduled { background:#dbeafe; color:#1e40af; }
        .modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
}

.modal-content {
    background: white;
    padding: 25px;
    border-radius: 12px;
    width: 350px;
    text-align: center;
    margin: 15% auto;
    box-shadow: 0 15px 40px rgba(0,0,0,0.2);
}

.modal-content h3 {
    margin-bottom: 10px;
    color: #1e293b;
}

.modal-content button {
    margin-top: 15px;
    padding: 8px 16px;
    background: #2563eb;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}
    </style>
</head>
<body>
    <div class="container">
    <h1> My Appointments</h1>

    <c:if test="${missCount >= 3}">
        <div style="background:#fee2e2;
                    color:#991b1b;
                    padding:12px;
                    border-radius:8px;
                    margin-bottom:15px;
                    font-weight:600;">
            Warning: You have missed multiple sessions.
            Continued absence may restrict future bookings.
        </div>
    </c:if>
        <c:choose>
            <c:when test="${!hasScheduled}">
                <div style="text-align:right; margin-bottom:15px;">
                    <a href="BookAppointment.jsp" 
                       style="background:#2563eb;color:white;padding:10px 16px;
                              border-radius:20px;text-decoration:none;font-weight:600;">
                        Book New Appointment
                    </a>
                </div>
            </c:when>
        </c:choose>
        <table>
            <thead>
                <tr>
                    <th>Counselor</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Mode</th>
                    <th>Status</th>
                    <th>Join</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${appointments}">
                    <tr>
                        <!-- Counselor -->
                        <td>${a.counselorName != null ? a.counselorName : '-'}</td>

                        <!-- Date -->
                        <td>${a.date}</td>

                        <!-- Time -->
                        <td>${a.time}</td>

                        <!-- Mode -->
                        <td>
                            <c:choose>
                                <c:when test="${a.mode == 'VIDEO_CALL'}">Video Call</c:when>
                                <c:when test="${a.mode == 'PHONE_CALL'}">Phone Call</c:when>
                                <c:when test="${a.mode == 'IN_PERSON'}">In Person</c:when>
                            </c:choose>
                        </td>
                        <!-- Status -->
                        <td>
                            
                            <c:choose>
                                <c:when test="${a.status == 'SCHEDULED'}">
                                    <span class="status pending">Scheduled</span>
                                </c:when>

                                <c:when test="${a.status == 'CANCELLED_BY_STUDENT'}">
                                    <span class="status cancelled">Cancelled (You)</span>
                                </c:when>

                                <c:when test="${a.status == 'CANCELLED_BY_COUNSELOR'}">
                                    <span class="status cancelled">Cancelled (Counselor)</span>
                                </c:when>

                                <c:when test="${a.status == 'MISSED_BY_STUDENT'}">
                                    <span class="status cancelled">Missed (You)</span>
                                    <br/>
                                    <small style="color:#991b1b;">
                                    You did not attend the scheduled session.
                                    </small>

                                </c:when>

                               <c:when test="${a.status == 'MISSED_BY_COUNSELOR'}">
                                    <span class="status cancelled">Missed (Counselor)</span>
                               </c:when>


                                <c:otherwise>
                                    ${a.status}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <%
                            Map row = (Map) pageContext.findAttribute("a");

                            java.sql.Date apptDate = null;
                            String timeSlot = null;

                            if(row != null){
                                apptDate = (java.sql.Date) row.get("date");
                                timeSlot = (String) row.get("time");
                            }

                            boolean allowJoin = false;
                            boolean allowCancel = false;
                            boolean allowUpdate = false;

                            if(apptDate != null && timeSlot != null){

                                java.util.Date now = new java.util.Date();

                                String[] times = timeSlot.split("-");

                                java.text.SimpleDateFormat sdf =
                                    new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

                                String apptDateStr =
                                    new java.text.SimpleDateFormat("yyyy-MM-dd").format(apptDate);

                                String startHour = times[0].trim() + ":00";
                                String endHour = times[1].trim() + ":00";

                                java.util.Date startDateTime =
                                    sdf.parse(apptDateStr + " " + startHour);

                                java.util.Date endDateTime =
                                    sdf.parse(apptDateStr + " " + endHour);

                                // JOIN → 10 min before
                                java.util.Calendar joinCal = java.util.Calendar.getInstance();
                                joinCal.setTime(startDateTime);
                                joinCal.add(java.util.Calendar.MINUTE, -10);

                                java.util.Date joinStart = joinCal.getTime();

                                if(now.after(joinStart) && now.before(endDateTime)){
                                    allowJoin = true;
                                }

                                // CANCEL & UPDATE → 1 hour before
                                java.util.Calendar actionCal = java.util.Calendar.getInstance();
                                actionCal.setTime(startDateTime);
                                actionCal.add(java.util.Calendar.HOUR_OF_DAY, -1);

                                java.util.Date actionDeadline = actionCal.getTime();

                                if(now.before(actionDeadline)){
                                    allowCancel = true;
                                    allowUpdate = true;
                                }
                            }

                            row.put("allowJoin", allowJoin);
                            row.put("allowCancel", allowCancel);
                            row.put("allowUpdate", allowUpdate);
                        %>

                        <td> 
                        <c:choose>
                            <c:when test="${a.status == 'SCHEDULED'}">
                                <c:choose>

                                <c:when test="${a.mode == 'VIDEO_CALL'}">

                                    <c:choose>
                                        <c:when test="${a.allowJoin && a.meetingLink != null}">
                                            <a href="${a.meetingLink}" target="_blank" class="button join">
                                                Join
                                            </a>
                                        </c:when>

                                        <c:otherwise>
                                            <span style="color:gray;">Join Not Available</span>
                                        </c:otherwise>
                                    </c:choose>

                                </c:when>

                                <c:when test="${a.mode == 'PHONE_CALL'}">

                                    <span style="color:#1e40af; font-weight:600;">
                                        Counselor will call you
                                    </span>

                                </c:when>

                                <c:when test="${a.mode == 'IN_PERSON'}">
                                    <div style="color:#166534; font-weight:600; margin-bottom:6px;">
                                        Venue: Vani Mandir<br>
                                        Room: 305
                                    </div>
                                </c:when>

                                </c:choose>
                                <div style="margin-top:6px;">
                                <c:if test="${a.allowUpdate}">
                                    <a href="BookAppointment.jsp?editId=${a.id}" 
                                       class="button accept">
                                        Update
                                    </a>
                                </c:if>

                                <c:if test="${a.allowCancel}">
                                    <a href="#"
                                       class="button reject"
                                       onclick="openCancelModal(${a.id}); return false;">
                                       Cancel
                                    </a>
                                </c:if>
                                </div>
                            </c:when>

                            <c:when test="${a.status == 'MISSED_BY_COUNSELOR'}">
                                <a href="BookAppointment.jsp?rescheduleId=${a.id}" 
                                   class="button accept"
                                   onclick="return checkReschedule();">
                                    Reschedule
                                </a>
                            </c:when>

                            <c:otherwise>
                                -
                            </c:otherwise>

                        </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>

        </table>
    </div>
    <div id="rescheduleModal" class="modal">
    <div class="modal-content">
        <h3>Action Not Allowed</h3>
        <p>You already have a scheduled appointment.</p>
        <button onclick="closeModal()">OK</button>
    </div>
</div>
    <div id="cancelModal" class="modal">
    <div class="modal-content">
        <h3>Cancel Appointment?</h3>
        <p>Are you sure you want to cancel this appointment?</p>

        <button onclick="closeCancelModal()">No</button>
        <button onclick="confirmCancel()" 
                style="background:#ef4444;">
            Yes, Cancel
        </button>
    </div>
</div>
    <script>
function checkReschedule() {

    var hasScheduled = ${hasScheduled};

    if (hasScheduled) {
        document.getElementById("rescheduleModal").style.display = "block";
        return false;
    }

    return true;
}

function closeModal() {
    document.getElementById("rescheduleModal").style.display = "none";
}
</script>
<script>

let cancelAppointmentId = null;

function openCancelModal(id){
    cancelAppointmentId = id;
    document.getElementById("cancelModal").style.display = "block";
}

function closeCancelModal(){
    document.getElementById("cancelModal").style.display = "none";
}

function confirmCancel(){
    window.location.href = 
        "StudentCancelAppointment.jsp?id=" + cancelAppointmentId;
}

</script>
</body>
</html>