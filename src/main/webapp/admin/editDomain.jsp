<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String name = "";
    String keywords = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/project_idea_db",
            "root",
            "Sam@2004"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM domains WHERE id=?"
        );
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("domain_name");
            keywords = rs.getString("search_keywords");
        }
        con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Domain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h3>Edit Domain</h3>

    <form action="../domain" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= id %>">

        <div class="mb-3">
            <label>Domain Name</label>
            <input type="text" name="domain_name" class="form-control" value="<%= name %>" required>
        </div>

        <div class="mb-3">
            <label>Search Keywords</label>
            <input type="text" name="search_keywords" class="form-control" value="<%= keywords %>" required>
        </div>

        <button class="btn btn-primary">Update</button>
        <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>

</body>
</html>
