<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
$(function(){
    $(":text").keyup(function(){
        $.ajax({
           url: "editUser",
           data: {
               id: "${user.id}",
               field: $(this).attr("name"),
               value: $(this).val()
           }
        });
    });
    $(":checkbox").change(function(){
        $.ajax({
            url: "editUser",
            data: {
                id: "${user.id}",
                field: $(this).attr("name"),
                value: $(this).prop("checked")
            }
         });
    });
});
</script>
</head>
<body>
<h2><a href="users">Users</a> &gt; Edit User</h2>

<input type="hidden" name="id" value="id" />
<table>
<tr>
  <td>First Name</td>
  <td><input type="text" name="firstName" value="${user.firstName}" /></td>
</tr>
<tr>
  <td>Last Name</td>
  <td><input type="text" name="lastName" value="${user.lastName}" /></td>
</tr>
<tr>
  <td>Email</td>
  <td><input type="text" name="email" value="${user.email}""/></td>
</tr>
<tr>
  <td>Enabled</td>
  <td><input type="checkbox" name="enabled" <c:if test="${user.enabled}">checked</c:if> /></td>
</tr>
</table>
</body>
</html>
