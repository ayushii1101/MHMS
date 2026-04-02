<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Hostel Management | ManSparsh</title>

<style>
body{
    margin:0;
    font-family:Segoe UI, Arial, sans-serif;
    background:#f4f7fb;
}
.container{
    padding:30px;
}
.header{
    background:#1f3c88;
    color:white;
    padding:15px 20px;
    font-size:20px;
    border-radius:10px 10px 0 0;
}
.box{
    background:white;
    padding:20px;
    border-radius:0 0 10px 10px;
    box-shadow:0 6px 18px rgba(0,0,0,0.1);
}

.add-hostel{
    margin-bottom:20px;
}
.add-hostel input{
    padding:8px;
    width:280px;
}
.add-hostel button{
    padding:8px 14px;
    background:#1f3c88;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
.add-hostel button:hover{
    background:#163172;
}

table{
    width:100%;
    border-collapse:collapse;
}
th,td{
    padding:12px;
    border-bottom:1px solid #eee;
}
th{
    background:#eef2ff;
    color:#1f3c88;
}

.remove{
    background:#e53935;
    color:white;
    border:none;
    padding:6px 10px;
    border-radius:6px;
    cursor:pointer;
}
.remove:hover{
    background:#c62828;
}
</style>

<script>
function updateNumbers(){
    let rows = document.querySelectorAll("#hostelTable tbody tr");
    rows.forEach((row, index) => {
        row.cells[0].innerText = index + 1;          // S.No
        row.cells[1].innerText = "H-" + (index + 1); // Hostel ID
    });
}

function addHostel(){
    let hostelName = document.getElementById("hostelName").value.trim();

    if(hostelName === ""){
        alert("Please enter hostel name");
        return;
    }

    let tbody = document.querySelector("#hostelTable tbody");

    let row = document.createElement("tr");
    row.innerHTML = `
        <td></td>
        <td></td>
        <td>${hostelName}</td>
        <td>
            <button class="remove" onclick="removeHostel(this)">Remove</button>
        </td>
    `;

    tbody.appendChild(row);
    document.getElementById("hostelName").value = "";
    updateNumbers();
}

function removeHostel(btn){
    btn.closest("tr").remove();
    updateNumbers();
}

window.onload = updateNumbers;
</script>

</head>

<body>

<div class="container">
    <div class="header">Hostel Management – Banasthali Vidyapith</div>

    <div class="box">

        <!-- ADD HOSTEL (NO FORM = NO REFRESH ISSUE) -->
        <div class="add-hostel">
            <input type="text" id="hostelName" placeholder="Enter new hostel name">
            <button type="button" onclick="addHostel()">Add Hostel</button>
        </div>

        <!-- HOSTEL LIST -->
        <table id="hostelTable">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Hostel ID</th>
                    <th>Hostel Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr><td></td><td></td><td>Shri Shanta Bai Shiksha Kutir</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Soudh</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Vishwa Needam</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Nilaya</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Bhuwnam</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Niwas</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Niketan</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Ayatan</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Vihar</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Dham</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Nikunj</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Puram</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Paleyam</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Alaya</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Geham</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Niveshanam</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Ajiram</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Gangotri</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Vasam</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Ayanam</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
                <tr><td></td><td></td><td>Shri Shanta Pattnam</td><td><button class="remove" onclick="removeHostel(this)">Remove</button></td></tr>
            </tbody>
        </table>

    </div>
</div>

</body>
</html>