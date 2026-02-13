<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h3 class="mb-4">📊 Domain Management</h3>

    <a href="addDomain.jsp" class="btn btn-success mb-3">➕ Add Domain</a>

    <table class="table table-bordered table-hover bg-white">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Domain Name</th>
                <th>Search Keywords</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/project_idea_db",
            "root",
            "Sam@2004"
        );

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM domains");

        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("domain_name") %></td>
            <td><%= rs.getString("search_keywords") %></td>
            <td>
                <%= rs.getInt("status") == 1 ? "Active" : "Disabled" %>
            </td>
            <td>
                <a href="editDomain.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-primary">Edit</a>
                <a href="../domain?action=delete&id=<%= rs.getInt("id") %>"
                   class="btn btn-sm btn-danger"
                   onclick="return confirm('Delete this domain?');">
                   Delete
                </a>
            </td>
        </tr>
<%
        }
        con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>

        </tbody>
    </table>
</div>

</body>
</html>
