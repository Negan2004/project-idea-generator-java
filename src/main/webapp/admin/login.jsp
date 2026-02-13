<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light d-flex align-items-center justify-content-center" style="height:100vh;">

<div class="card p-4 shadow" style="width:350px;">
    <h4 class="text-center mb-3">🔐 Admin Login</h4>

<form action="<%= request.getContextPath() %>/adminLogin" method="post">
        <div class="mb-3">
            <label>Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <button class="btn btn-primary w-100">Login</button>
    </form>

    <%
        if (request.getParameter("error") != null) {
    %>
        <div class="alert alert-danger mt-3 text-center">
            Invalid login
        </div>
    <%
        }
    %>
</div>

</body>
</html>
