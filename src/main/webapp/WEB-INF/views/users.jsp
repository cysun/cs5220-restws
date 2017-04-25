<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Users</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
function viewUser(){
    var userId = $(this).closest("tr").attr("data-user-id");
    $.ajax({
        url: "service/user/" + userId,
        dataType: "json",
        success: function(data) {
            $("#user-display td:eq(0)").html(data.id);
            $("#user-display td:eq(1)").html(data.firstName);
            $("#user-display td:eq(2)").html(data.lastName);
            $("#user-display td:eq(3)").html(data.email);
            $("#user-display td:eq(4)").html(data.enabled);
        }
    });
    $("#user-display").dialog("open");
}
function deleteUser(){
    var userId = $(this).closest("tr").attr("data-user-id");
    $.ajax({
        url: "service/user/" + userId,
        method: "DELETE",
        context: $(this),
        success: function(){
            $(this).closest("tr").remove();
        }
    });
}
function addUser() {
    $.ajax({
        url: "service/users",
        method: "POST",
        dataType: "json",
        processData: false,
        contentType: "application/json",
        data: JSON.stringify({
            firstName: $("input[name='firstname']").val(),
            lastName: $("input[name='lastname']").val(),
            email: $("input[name='email']").val()
        }),
        success: function(data){
            var row = $("<tr data-user-id='" + data.id + "'></tr>");
            row.append("<td>" + data.id + "</td>")
               .append("<td>" + data.firstName + "</td>")
               .append("<td>" + data.lastName + "</td>");
            var viewBtn = $("<button class='view'>View</button>").click(viewUser);
            var editBtn = $("<button class='edit'>Edit</button>").click(editUser);
            var deleteBtn = $("<button class='delete'>Delete</button>").click(deleteUser);
            var cell = $("<td></td>");
            cell.append(viewBtn).append(" ")
                .append(editBtn).append(" ")
                .append(deleteBtn);
            $("#users").append( row.append(cell) );
        }
    });
}
function editUser()
{
    var userId = $(this).closest("tr").attr("data-user-id");
    window.location.href = "editUser?id=" + userId;
}
$(function(){
	$("#user-display").dialog({
		autoOpen: false
	});
	$("#user-form").dialog({
		autoOpen: false,
	    buttons: {
	        "Save": function(){
                $(this).dialog( "close" );
	            addUser();
	        }
	    }
	});
	$(".view").click(viewUser);
    $(".edit").click(editUser);
	$(".delete").click(deleteUser);
	$("#add").click(function(){
		$("form")[0].reset();
		$("#user-form").dialog("open");
	});
});
</script>
</head>
<body>
<h2>Users</h2>
<table id="users" border="1">
  <tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Operations</th></tr>
  <c:forEach items="${users}" var="user">
  <tr data-user-id="${user.id}">
    <td>${user.id}</td>
    <td>${user.firstName}</td>
    <td>${user.lastName}</td>
    <td>
      <button class="view">View</button>
      <button class="edit">Edit</button>
      <button class="delete">Delete</button>
    </td>
  </tr>
  </c:forEach>
</table>
<p><button id="add">Add User</button></p>

<div id="user-display">
<table>
  <tr><th>ID</th><td></td></tr>
  <tr><th>First Name</th><td></td></tr>
  <tr><th>Last Name</th><td></td></tr>
  <tr><th>Email</th><td></td></tr>
  <tr><th>Enabled</th><td></td></tr>
</table>
</div>

<div id="user-form">
<form>
<table>
  <tr><th>First Name</th><td><input name="firstname" type="text" /></td></tr>
  <tr><th>Last Name</th><td><input name="lastname" type="text" /></td></tr>
  <tr><th>Email</th><td><input name="email" type="text" /></td></tr>
</table>
</form>
</div>

</body>
</html>
