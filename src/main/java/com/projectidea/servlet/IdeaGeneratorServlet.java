package com.projectidea.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/generateIdea")
public class IdeaGeneratorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int domainId = Integer.parseInt(request.getParameter("domainId"));
        String difficulty = request.getParameter("difficulty");

        String keywords = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection dbCon = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/project_idea_db",
                    "root",
                    "Sam@2004"   // 🔁 Replace this
            );

            PreparedStatement ps = dbCon.prepareStatement(
                    "SELECT search_keywords FROM domains WHERE id=? AND status=1"
            );
            ps.setInt(1, domainId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                keywords = rs.getString("search_keywords");
            }

            dbCon.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Build GitHub search query
        String keyword = keywords + " " + difficulty.toLowerCase();
        keyword = keyword.replace(" ", "+");

        String apiUrl = "https://api.github.com/search/repositories?q=" + keyword;

        try {
            java.net.URL url = new java.net.URL(apiUrl);
            java.net.HttpURLConnection apiCon =
                    (java.net.HttpURLConnection) url.openConnection();

            apiCon.setRequestMethod("GET");
            apiCon.setRequestProperty("Accept", "application/json");

            java.io.BufferedReader in = new java.io.BufferedReader(
                    new java.io.InputStreamReader(apiCon.getInputStream())
            );

            String inputLine;
            StringBuilder apiResponse = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                apiResponse.append(inputLine);
            }
            in.close();

            // Parse JSON
            com.google.gson.JsonObject jsonObject =
                    com.google.gson.JsonParser
                            .parseString(apiResponse.toString())
                            .getAsJsonObject();

            com.google.gson.JsonArray items =
                    jsonObject.getAsJsonArray("items");

            List<Map<String, String>> ideas = new ArrayList<>();

            for (int i = 0; i < Math.min(5, items.size()); i++) {

                com.google.gson.JsonObject repo =
                        items.get(i).getAsJsonObject();

                Map<String, String> idea = new HashMap<>();

                idea.put("name", repo.get("name").getAsString());

                idea.put("description",
                        repo.get("description") != null
                                ? repo.get("description").getAsString()
                                : "No description available");

                idea.put("url",
                        repo.get("html_url").getAsString());

                ideas.add(idea);
            }

            request.setAttribute("ideas", ideas);
            request.getRequestDispatcher("result.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
