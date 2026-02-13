<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Domain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h3>Add Domain</h3>

    <form action="../domain" method="post">
        <input type="hidden" name="action" value="add">

        <div class="mb-3">
            <label>Domain Name</label>
            <input type="text" name="domain_name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Search Keywords (used for GitHub API)</label>
            <input type="text" name="search_keywords" class="form-control" required>
        </div>

        <button class="btn btn-success">Save</button>
        <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>

</body>
</html>
