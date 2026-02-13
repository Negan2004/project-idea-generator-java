<%@ page import="java.sql.*" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Project Idea Generator</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0f172a, #020617);
            min-height: 100vh;
            color: #e5e7eb;
            font-family: 'Inter', system-ui, sans-serif;
        }

        .app-container {
            max-width: 900px;
            margin: auto;
            padding: 3rem 1rem;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.15);
            box-shadow: 0 25px 60px rgba(0,0,0,0.45);
            padding: 2rem;
        }

        .generate-btn {
            background: linear-gradient(135deg, #6366f1, #22d3ee);
            border: none;
            border-radius: 14px;
            font-weight: 600;
            padding: 0.7rem;
            transition: transform .2s ease, box-shadow .2s ease;
        }

        .generate-btn:hover {
            transform: scale(1.03);
            box-shadow: 0 15px 35px rgba(99,102,241,0.4);
        }

        select {
            background-color: rgba(255,255,255,0.1) !important;
            color: #e5e7eb !important;
            border: 1px solid rgba(255,255,255,0.2);
        }

        option {
            color: black;
        }
    </style>
</head>

<body>

<div class="app-container">
    <div class="glass-card">

        <h2 class="fw-bold mb-2">🚀 Project Idea Generator</h2>
        <p class="text-secondary mb-4">
            Discover real-world project ideas fetched live from GitHub based on your interests.
        </p>

        <form action="generateIdea" method="post">

            <div class="mb-3">
                <label class="form-label">Domain</label>
                <select name="domainId" class="form-select" required>
    <option value="">Select domain</option>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/project_idea_db",
            "projectuser",
            "1234"
        );

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
            "SELECT id, domain_name FROM domains WHERE status=1"
        );

        while (rs.next()) {
%>
        <option value="<%= rs.getInt("id") %>">
            <%= rs.getString("domain_name") %>
        </option>
<%
        }
        con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>
</select>

            </div>

            <div class="mb-4">
                <label class="form-label">Difficulty</label>
                <select name="difficulty" class="form-select" required>
                    <option value="">Select difficulty</option>
                    <option>Beginner</option>
                    <option>Intermediate</option>
                    <option>Advanced</option>
                </select>
            </div>

            <button type="submit" class="btn generate-btn w-100 text-white">
                🎯 Generate Project Ideas
            </button>

        </form>

    </div>
</div>

</body>
</html>
