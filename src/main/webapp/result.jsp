<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Generated Ideas</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #020617, #0f172a);
            min-height: 100vh;
            color: #e5e7eb;
            font-family: 'Inter', system-ui, sans-serif;
        }

        .app-container {
            max-width: 1000px;
            margin: auto;
            padding: 3rem 1rem;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.15);
            box-shadow: 0 25px 60px rgba(0,0,0,0.45);
            padding: 1.5rem;
            transition: transform .3s ease, box-shadow .3s ease;
        }

        .glass-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 35px 70px rgba(0,0,0,0.6);
        }

        .fade-up {
            animation: fadeUp .6s ease forwards;
            opacity: 0;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>

<body>

<div class="app-container">
    <h2 class="fw-bold mb-4 text-center">✨ Generated Project Ideas</h2>

    <%
        List<Map<String,String>> ideas =
            (List<Map<String,String>>) request.getAttribute("ideas");

        if (ideas == null || ideas.isEmpty()) {
    %>
        <div class="alert alert-warning text-center">
            No ideas found. Try another domain.
        </div>
    <%
        } else {
            for (Map<String,String> idea : ideas) {
    %>

        <div class="glass-card mb-4 fade-up">
            <h5 class="fw-semibold mb-2"><%= idea.get("name") %></h5>

            <p class="text-secondary small">
                <%= idea.get("description") %>
            </p>

            <a href="<%= idea.get("url") %>" target="_blank"
               class="btn btn-outline-light btn-sm">
                View on GitHub →
            </a>
        </div>

    <%
            }
        }
    %>

    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-secondary">
            🔄 Generate Again
        </a>
    </div>
</div>

</body>
</html>
