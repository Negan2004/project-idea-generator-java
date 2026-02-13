package com.projectidea.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/domain")
public class DomainServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project_idea_db",
                "projectuser",
                "1234"

            );

            if ("add".equals(action)) {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO domains(domain_name, search_keywords) VALUES (?,?)"
                );
                ps.setString(1, request.getParameter("domain_name"));
                ps.setString(2, request.getParameter("search_keywords"));
                ps.executeUpdate();
            }

            if ("update".equals(action)) {
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE domains SET domain_name=?, search_keywords=? WHERE id=?"
                );
                ps.setString(1, request.getParameter("domain_name"));
                ps.setString(2, request.getParameter("search_keywords"));
                ps.setInt(3, Integer.parseInt(request.getParameter("id")));
                ps.executeUpdate();
            }

            con.close();
            response.sendRedirect("admin/dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/project_idea_db",
                    "projectuser",
                    "1234"
                );

                PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM domains WHERE id=?"
                );
                ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                ps.executeUpdate();

                con.close();
                response.sendRedirect("admin/dashboard.jsp");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
