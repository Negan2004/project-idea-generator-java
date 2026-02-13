package com.projectidea.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/project_idea_db",
                "projectuser",
                "1234"

            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM admin_users WHERE username=? AND password=?"
            );

            ps.setString(1, username.trim());
            ps.setString(2, password.trim());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("admin", username);

                response.sendRedirect(
                        request.getContextPath() + "/admin/dashboard.jsp"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath() + "/admin/login.jsp?error=1"
                );
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
