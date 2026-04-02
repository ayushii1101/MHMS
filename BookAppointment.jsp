<%@ page import="java.sql.*, java.util.*, java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String studentName = (String) session.getAttribute("studentName");
String studentEmail = (String) session.getAttribute("studentEmail");

if(studentEmail == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}
String rescheduleIdStr = request.getParameter("rescheduleId");
String editIdStr = request.getParameter("editId");
Integer editId = null;

if(editIdStr != null){
    try{
        editId = Integer.parseInt(editIdStr);
    }catch(Exception e){}
}
Integer rescheduleId = null;

if(rescheduleIdStr != null){
    try{
        rescheduleId = Integer.parseInt(rescheduleIdStr);
    }catch(Exception e){}
}
String message = "";
String dobVal = request.getParameter("dob");
String smartCardVal = request.getParameter("smartCard");
String appointmentDateVal = request.getParameter("appointmentDate");
String phoneVal = request.getParameter("phone");
String hostelVal = request.getParameter("hostel");
String modeVal = request.getParameter("mode");
String slotVal = request.getParameter("slot");
String[] concernsVal = request.getParameterValues("concern[]");
String otherTextVal = request.getParameter("otherText");

/* ===== Fetch Student Existing Details From DB ===== */
// ===== Load Existing Appointment For Update =====
String editSlot="";
String editMode="";
String editDate="";
String editConcern="";

if(editId != null){
    try{
        Connection conEdit = DriverManager.getConnection(
            "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

        PreparedStatement psEdit = conEdit.prepareStatement(
            "SELECT appointment_date, time_slot, preferred_mode, chief_concern " +
            "FROM appointment WHERE id=? AND status='SCHEDULED'"
        );
        psEdit.setInt(1, editId);

        ResultSet rsEdit = psEdit.executeQuery();

        if(rsEdit.next()){
            editDate = rsEdit.getDate("appointment_date").toString();
            editSlot = rsEdit.getString("time_slot");
            editMode = rsEdit.getString("preferred_mode");
            editConcern = rsEdit.getString("chief_concern");
        }

        conEdit.close();
    }catch(Exception e){}
}
String dbDob="";
String dbSmart="";
String dbPhone="";
String dbHostel="";

try{
Connection conFetch = DriverManager.getConnection(
"jdbc:derby://localhost:1527/ManSparsh","bns","bns");

PreparedStatement psFetch = conFetch.prepareStatement(
"SELECT dob, smart_card_id, phone, hostel FROM student WHERE email=?");

psFetch.setString(1, studentEmail);

ResultSet rsFetch = psFetch.executeQuery();

if(rsFetch.next()){
    if(rsFetch.getDate("dob")!=null)
        dbDob = rsFetch.getDate("dob").toString();

    dbSmart = rsFetch.getString("smart_card_id");
    dbPhone = rsFetch.getString("phone");
    dbHostel = rsFetch.getString("hostel");
}

conFetch.close();
}catch(Exception e){}

boolean hasScheduledAppointment = false;
try{
Connection conCheck = DriverManager.getConnection(
"jdbc:derby://localhost:1527/ManSparsh","bns","bns");
PreparedStatement psCheck = conCheck.prepareStatement(
"SELECT COUNT(*) FROM appointment " +
"WHERE student_id=(SELECT student_id FROM student WHERE email=?) " +
"AND status='SCHEDULED' AND appointment_date >= CURRENT_DATE"
);
psCheck.setString(1, studentEmail);
ResultSet rsCheck = psCheck.executeQuery();

if(rsCheck.next()){
    if(rsCheck.getInt(1) > 0){
        hasScheduledAppointment = true;
    }
}
conCheck.close();
}catch(Exception e){}

if(request.getParameter("submit") != null){
    
    String dob = request.getParameter("dob");
    String appointmentDate = request.getParameter("appointmentDate");
    java.sql.Date apptDate = java.sql.Date.valueOf(appointmentDate);
    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.setTime(apptDate);
    int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);

    String phone = request.getParameter("phone");
    String hostel = request.getParameter("hostel");
    String mode = request.getParameter("mode");
    String slot = request.getParameter("slot");

    if(dayOfWeek == java.util.Calendar.TUESDAY){
        message = "<div class='error'>Tuesday is a holiday. Please select another date.</div>";
    } 
    else{
        String[] concerns = request.getParameterValues("concern[]");
        String chiefConcern = "";
        if(concerns != null)
        {
            StringBuilder sb = new StringBuilder();
            for(String c : concerns){
                if(c.equals("Other")){
                    sb.append("Other(").append(otherTextVal).append(")");
                }else{
                    sb.append(c);
                }
                sb.append(", ");
            }
            chiefConcern = sb.substring(0, sb.length()-2);
        }
        try{
            Connection con = DriverManager.getConnection(
               "jdbc:derby://localhost:1527/ManSparsh","bns","bns");
            
            // get student_id from email
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT student_id FROM STUDENT WHERE email=?");
            ps1.setString(1, studentEmail);
            ResultSet rs = ps1.executeQuery();

            int studentId = 0;
            
            if(rs.next()){
                studentId = rs.getInt("student_id");
            }
            
            // ===== Prevent Multiple Future Scheduled Appointments =====
            PreparedStatement checkFuture = con.prepareStatement(
                "SELECT COUNT(*) FROM appointment " +
                "WHERE student_id=? AND status='SCHEDULED' AND appointment_date >= CURRENT_DATE"
            );
            checkFuture.setInt(1, studentId);

            ResultSet rsFuture = checkFuture.executeQuery();

            int futureCount = 0;
if(rsFuture.next()){
    futureCount = rsFuture.getInt(1);
}

// If updating, ignore current appointment
if(editId != null){
    PreparedStatement checkCurrent = con.prepareStatement(
        "SELECT COUNT(*) FROM appointment WHERE id=? AND student_id=? AND status='SCHEDULED'"
    );
    checkCurrent.setInt(1, editId);
    checkCurrent.setInt(2, studentId);
    ResultSet rsCurrent = checkCurrent.executeQuery();
    if(rsCurrent.next() && rsCurrent.getInt(1) > 0){
        futureCount--;  // subtract current appointment
    }
}

if(futureCount > 0 && editId == null){
    message = "<div class='error'>You already have a scheduled upcoming appointment.</div>";
    con.close();
    return;
}

           // ===== PROFESSIONAL RESCHEDULE VALIDATION =====
            if(rescheduleId != null){

                PreparedStatement checkOld = con.prepareStatement(
                    "SELECT status FROM appointment WHERE id=? AND student_id=?"
                );
                checkOld.setInt(1, rescheduleId);
                checkOld.setInt(2, studentId);

                ResultSet rsOld = checkOld.executeQuery();

                if(rsOld.next()){

                    String oldStatus = rsOld.getString("status");

                    if(!"SCHEDULED".equals(oldStatus)){
                        message = "<div class='error'>Only scheduled appointments can be rescheduled.</div>";
                        con.close();
                        return;
                    }

                    // Update ONLY if status is SCHEDULED
                    PreparedStatement psUpdateOld = con.prepareStatement(
                        "UPDATE appointment SET status='RESCHEDULED' WHERE id=? AND status='SCHEDULED'"
                    );
                    psUpdateOld.setInt(1, rescheduleId);
                    psUpdateOld.executeUpdate();

                } else {
                    message = "<div class='error'>Invalid appointment selected.</div>";
                    con.close();
                    return;
                }
            }

            String counselorIdStr = request.getParameter("counselorId");

if(counselorIdStr == null || counselorIdStr.trim().isEmpty()){
    message = "<div class='error'>Please select a valid time slot.</div>";
}
else{
int counselorId = Integer.parseInt(counselorIdStr);

            PreparedStatement updateStudent = con.prepareStatement(
            "UPDATE student SET dob=?, smart_card_id=?, phone=?, hostel=? WHERE student_id=?"
            );

            updateStudent.setDate(1, java.sql.Date.valueOf(dob));
            updateStudent.setString(2, smartCardVal);
            updateStudent.setString(3, phone);
            updateStudent.setString(4, hostel);
            updateStudent.setInt(5, studentId);

            updateStudent.executeUpdate();

            // ===== Generate Meeting Link Automatically =====
            String meetingLink = null;

            if("VIDEO_CALL".equalsIgnoreCase(mode)){
                meetingLink = "https://meet.google.com/" +
                        UUID.randomUUID().toString().substring(0,10);
            }

            if(editId != null){

    // UPDATE EXISTING APPOINTMENT
    PreparedStatement psUpdate = con.prepareStatement(
        "UPDATE appointment SET " +
        "counselor_id=?, appointment_date=?, preferred_mode=?, time_slot=?, chief_concern=?, meeting_link=? " +
        "WHERE id=? AND status='SCHEDULED'"
    );

    psUpdate.setInt(1, counselorId);
    psUpdate.setDate(2, java.sql.Date.valueOf(appointmentDate));
    psUpdate.setString(3, mode);
    psUpdate.setString(4, slot);
    psUpdate.setString(5, chiefConcern);
    psUpdate.setString(6, meetingLink);
    psUpdate.setInt(7, editId);

    psUpdate.executeUpdate();

}
else{

    // NORMAL INSERT
    PreparedStatement ps = con.prepareStatement(
    "INSERT INTO APPOINTMENT " +
    "(student_id, counselor_id, appointment_date, preferred_mode, time_slot, chief_concern, status, created_at, meeting_link) " +
    "VALUES(?,?,?,?,?,?, 'SCHEDULED', CURRENT_TIMESTAMP, ?)"
    );

    ps.setInt(1, studentId);
    ps.setInt(2, counselorId);
    ps.setDate(3, java.sql.Date.valueOf(appointmentDate));
    ps.setString(4, mode);
    ps.setString(5, slot);
    ps.setString(6, chiefConcern);
    ps.setString(7, meetingLink);

    ps.executeUpdate();
}

            response.sendRedirect("StudentAppointments.jsp");
            return;
        }
            con.close();

        }catch(Exception e){
            message = "<div class='error'>"+e.getMessage()+"</div>";
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Book Appointment | ManSparsh</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: url("https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=1600&q=80")
                center / cover no-repeat fixed;
    min-height: 100vh;
}

.dashboard-bg {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: 80px 20px;
}

.container {
    width: 500px;
    max-width: 95%;
    background: rgba(255,255,255,0.95);
    padding: 40px 30px;
    border-radius: 20px;
    box-shadow: 0 25px 50px rgba(0,0,0,0.3);
}

.form-title {
    text-align: center;
    font-size: 26px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 20px;
}

label { font-weight: 600; color: #333; }

input, select {
    width: 100%;
    padding: 12px;
    margin: 6px 0 14px;
    border-radius: 8px;
    border: 1px solid #ccc;
}

.checkbox-group {
    display: grid;
    grid-template-columns: repeat(2,1fr);
    gap: 6px;
    margin-bottom: 14px;
}

.checkbox-label {
    display: flex;
    align-items: center;
    gap: 8px;
}

.checkbox-label input {
    width: 18px;
    height: 18px;
    accent-color: #2563eb;
}

button {
    width: 100%;
    padding: 14px;
    background: #2563eb;
    border: none;
    color: white;
    font-size: 16px;
    border-radius: 25px;
    cursor: pointer;
}

button:hover { background: #1e40af; }

.success { text-align: center; color: green; font-weight: bold; }
.error { text-align: center; color: red; font-weight: bold; }
</style>
</head>

<body>
<div class="dashboard-bg">
<div class="container">

<div class="form-title">Book Appointment</div>
<%= message %>
<form method="post" onsubmit="return validateAppointment();">
<label>Student Name</label>
<input type="text" value="<%= studentName %>" readonly>

<label>Email</label>
<input type="text" value="<%= studentEmail %>" readonly>

<label>Smart Card ID</label>
<input type="text" name="smartCard"
       placeholder="Enter your Smart Card ID" 
       value="<%= smartCardVal!=null?smartCardVal:(dbSmart!=null?dbSmart:"") %>"
       required>



<label>Date of Birth</label>
<input type="date" name="dob" 
       value="<%= dobVal!=null?dobVal:(dbDob!=null?dbDob:"") %>" required>

<label>Appointment Date</label>
<input type="date" name="appointmentDate" 
       value="<%= appointmentDateVal != null ? appointmentDateVal : (editId!=null?editDate:"") %>" required>
<p style="font-size:13px;color:#666;">* Tuesday is a holiday. Appointments cannot be booked on Tuesday.</p>

<label>Phone</label>
<input type="text" name="phone" value="<%= phoneVal!=null?phoneVal:(dbPhone!=null?dbPhone:"") %>" required>

<label>Hostel</label>
<select name="hostel" required>
    <option value="">Select Hostel</option>
    <option <%= "Shri Shanta Bai Shiksha Kutir".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Bai Shiksha Kutir
    </option>
    <option <%= "Shri Shanta Soudh".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Soudh
    </option>
    <option <%= "Shri Shanta Vishwa Needam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Vishwa Needam
    </option>
    <option <%= "Shri Shanta Nilaya".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Nilaya
    </option>
    <option <%= "Shri Shanta Bhuwnam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Bhuwnam
    </option>
    <option <%= "Shri Shanta Niwas".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Niwas
    </option>
    <option <%= "Shri Shanta Niketan".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Niketan
    </option>
    <option <%= "Shri Shanta Ayatan".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Ayatan
    </option>
    <option <%= "Shri Shanta Vihar".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Vihar
    </option>
    <option <%= "Shri Shanta Dham".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Dham
    </option>
    
    <option <%= "Shri Shanta Nikunj".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Nikunj
    </option>
    <option <%= "Shri Shanta Puram".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Puram
    </option>
    <option <%= "Shri Shanta Paleyam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Paleyam
    </option>
    <option <%= "Shri Shanta Alaya".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Alaya
    </option>
    <option <%= "Shri Shanta Geham".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Geham
    </option>
    <option <%= "Shri Shanta Niveshanam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Niveshanam
    </option>
    <option <%= "Shri Shanta Ajiram".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Ajiram
    </option>
    <option <%= "Shri Shanta Gangotri".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Gangotri
    </option>
    <option <%= "Shri Shanta Vasam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Vasam
    </option>
    <option <%= "Shri Shanta Ayanam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Ayanam
    </option>
    <option <%= "Shri Shanta Pattnam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Pattnam
    </option>
    <option <%= "Shri Shanta Lok".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Lok
    </option>
    
    <option <%= "Shri Shanta Nagram".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Nagram
    </option>
    <option <%= "Shri Shanta Kulam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Kulam
    </option>
    <option <%= "Shri Shanta Neri".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Neri
    </option>
    <option <%= "Shri Shanta Gram".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Gram
    </option>
    <option <%= "Shri Shanta Puri".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Puri
    </option>
    <option <%= "Shri Shanta Peetham".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Peetham
    </option>
    <option <%= "Shri Shanta Nigam".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Nigam
    </option>
    <option <%= "Shri Shanta Vatika".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Vatika
    </option>
    <option <%= "Shri Shanta Aagar".equals(hostelVal!=null?hostelVal:dbHostel)?"selected":"" %>>
        Shri Shanta Aagar
    </option>
</select>

<label>Preferred Mode</label>
<select name="mode" required>
    <option value="">Select Mode</option>
    <option value="VIDEO_CALL" 
    <%= "VIDEO_CALL".equals(modeVal!=null?modeVal:editMode)?"selected":"" %>>Video Call</option>
    <option value="PHONE_CALL" 
    <%= "PHONE_CALL".equals(modeVal!=null?modeVal:editMode)?"selected":"" %>>Phone Call</option>
    <option value="IN_PERSON" 
    <%= "IN_PERSON".equals(modeVal!=null?modeVal:editMode)?"selected":"" %>>In-Person</option>
</select>

<label>Time Slot</label>
<select name="slot" id="slot" required>
    <option value="">Select Appointment Date First</option>
</select>

<input type="hidden" name="counselorId" id="counselorId">

<label>Chief Concern</label>
<div class="checkbox-group">

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Appetite"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Appetite")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Appetite")){
    out.print("checked");
}
%>
> Appetite
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Family Conflict"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Family Conflict")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Family Conflict")){
    out.print("checked");
}
%>
> Family Conflict
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Interpersonal Relations"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Interpersonal Relations")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Interpersonal Relations")){
    out.print("checked");
}
%>
> Interpersonal Relations
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Burnout"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Burnout")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Burnout")){
    out.print("checked");
}
%>
> Burnout
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Emotional Breakdown"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Emotional Breakdown")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Emotional Breakdown")){
    out.print("checked");
}
%>
> Emotional Breakdown
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Concentration"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Concentration")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Concentration")){
    out.print("checked");
}
%>
> Concentration
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Time Management"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Time Management")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Time Management")){
    out.print("checked");
}
%>
> Time Management
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Stress"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Stress")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Stress")){
    out.print("checked");
}
%>
> Stress
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Career"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Career")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Career")){
    out.print("checked");
}
%>
> Career
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Academic"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Academic")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Academic")){
    out.print("checked");
}
%>
> Academic
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Sleep"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.equals("Sleep")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Sleep")){
    out.print("checked");
}
%>
> Sleep
</label>

<label class="checkbox-label">
<input type="checkbox" name="concern[]" value="Other" id="otherChk"
<%
if(concernsVal != null){
    for(String c: concernsVal){
        if(c.startsWith("Other")) out.print("checked");
    }
}
else if(editId!=null && editConcern!=null && editConcern.contains("Other(")){
    out.print("checked");
}
%>
> Other
</label>

<div id="otherBox" style="display:none; margin-top:8px;">
<textarea name="otherText" id="otherText"
placeholder="Enter (max 20 chars)"
maxlength="20"
style="width:100%;padding:10px;border-radius:8px;border:1px solid #ccc;"><%= 
editId!=null && editConcern!=null && editConcern.contains("Other(")
? editConcern.substring(editConcern.indexOf("Other(")+6, editConcern.indexOf(")"))
: "" %></textarea>

<div style="font-size:12px;color:#666;text-align:right;">
<span id="charCount">0</span>/20
</div>
</div>

</div>

<button type="submit" name="submit">Submit Request</button>
</form>

</div>
</div>
    
    <script>
        const otherChk = document.getElementById("otherChk");
        const otherBox = document.getElementById("otherBox");
        const otherText = document.getElementById("otherText");
        const charCount = document.getElementById("charCount");

        otherChk.addEventListener("change", function(){
            if(this.checked){
                otherBox.style.display = "block";
                otherText.required = true;
            }else{
                otherBox.style.display = "none";
                otherText.value = "";
                charCount.innerText = "0";
                otherText.required = false;
            }
        });

        otherText.addEventListener("input", function(){
            charCount.innerText = this.value.length;
        });
        // Show Other automatically in edit mode
window.addEventListener("load", function(){
    <% if(editId!=null && editConcern!=null && editConcern.contains("Other(")){ %>
        otherBox.style.display = "block";
        otherText.required = true;
        charCount.innerText = otherText.value.length;
    <% } %>
});
    </script>

<script>
const appointmentDate = document.querySelector("input[name='appointmentDate']");
const slotSelect = document.getElementById("slot");
const counselorInput = document.getElementById("counselorId");

appointmentDate.addEventListener("change", function(){

    if(this.value === ""){
        slotSelect.innerHTML = "<option value=''>Select Appointment Date First</option>";
        slotSelect.disabled = true;
        return;
    }

    fetch("GetAvailableSlots.jsp?date=" + this.value)
    .then(res => res.text())
    .then(data => {

        slotSelect.innerHTML = data;
        slotSelect.disabled = false;

        <% if(editId != null){ %>
        const oldSlot = "<%= editSlot %>";

        for(let i=0;i<slotSelect.options.length;i++){

            if(slotSelect.options[i].value === oldSlot){

                slotSelect.selectedIndex = i;

                counselorInput.value =
                    slotSelect.options[i].getAttribute("data-counselor");

                break;
            }
        }
        <% } %>

    })
    .catch(err => {
        slotSelect.innerHTML = "<option>Error loading slots</option>";
        console.error(err);
    });

});

slotSelect.addEventListener("change", function () {

    const selectedOption = this.options[this.selectedIndex];

    const cid = selectedOption.getAttribute("data-counselor");

    counselorInput.value = cid ? cid : "";

});


/* ===== Auto Load Slots in Edit Mode ===== */
window.addEventListener("load", function(){

    <% if(editId != null){ %>

        if(appointmentDate.value !== ""){
            appointmentDate.dispatchEvent(new Event('change'));
        }

    <% } %>

});
</script>

<script>
var hasScheduledAppointment = <%= hasScheduledAppointment %>;
function validateAppointment(){

    if(hasScheduledAppointment){

        alert("⚠️ You already have a scheduled appointment.\n\nPlease cancel or reschedule your existing appointment before booking another.");

        return false;
    }

    return true;
}
</script>

</body>
</html>