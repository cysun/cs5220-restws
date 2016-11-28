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
            $("#user-display td[data-field='id']").html(data.id);
            $("#user-display td[data-field='firstname']").html(data.firstName);
            $("#user-display td[data-field='lastname']").html(data.lastName);
            $("#user-display td[data-field='email']").html(data.email);
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
            var newRow = $("<tr data-user-id='" + data.id + "'>" +
                "<td data-field='id'>" + data.id + "</td>" +
                "<td data-field='firstname'>" + data.firstName + "</td>" +
                "<td data-field='lastname'>" + data.lastName + "</td>" +
                "<td data-field='email'>" + data.email + "</td>" +
                "<td><a class='view' href='javascript:void(0)'>View</a> | " +
                "<a class='edit' href='javascript:void(0)'>Edit</a> | " +
                "<a class='delete' href='javascript:void(0)'>Delete</a></td>"
            )
            $("#users").append(newRow);
            newRow.find(".view").click(viewUser);
            newRow.find(".delete").click(deleteUser);
        }
    });
}
$(function(){
	$("#user-display").dialog({
		autoOpen: false
	});
	$("#user-form").dialog({
		autoOpen: false,
	    buttons: {
	        "Save": function(){
	            if( ! $("input[name='id']").val() ) addUser();
	            $(this).dialog( "close" );
	        }
	    }
	});
	$(".view").click(viewUser);
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
<p>(Edit User is not implemented)</p>
<table id="users" border="1">
  <tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Operations</th></tr>
  <c:forEach items="${users}" var="user">
  <tr data-user-id="${user.id}">
    <td data-field="id">${user.id}</td>
    <td data-field="firstname">${user.firstName}</td>
    <td data-field="lastname">${user.lastName}</td>
    <td data-field="email">${user.email}</td>
    <td>
      <a class="view" href="javascript:void(0)">View</a> |
      <a class="edit" href="javascript:void(0)">Edit</a> |
      <a class="delete" href="javascript:void(0)">Delete</a>
    </td>
  </tr>
  </c:forEach>
</table>
<p><button id="add">Add User</button></p>

<div id="user-display">
<table>
  <tr><th>ID</th><td data-field="id"></td></tr>
  <tr><th>First Name</th><td data-field="firstname"></td></tr>
  <tr><th>Last Name</th><td data-field="lastname"></td></tr>
  <tr><th>Email</th><td data-field="email"></td></tr>
</table>
</div>

<div id="user-form">
<form>
<table>
  <tr><th>First Name</th><td><input name="firstname" type="text" /></td></tr>
  <tr><th>Last Name</th><td><input name="lastname" type="text" /></td></tr>
  <tr><th>Email</th><td><input name="email" type="text" /></td></tr>
</table>
<input name="id" type="hidden" />
</form>
</div>

</body>
</html>
