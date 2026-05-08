package com.campusflow;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;
import java.sql.*;

public class Timetableservlet extends HttpServlet {

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    out.println("<html><body>");
    out.println("<h2>CampusFlow — Servlet JDBC Test</h2>");

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/campusflow", "root", "your_password"
      );
      Statement stmt = conn.createStatement();
      ResultSet rs   = stmt.executeQuery("SELECT * FROM departments");

      out.println("<table border='1'>");
      out.println("<tr><th>ID</th><th>Department</th><th>Code</th></tr>");
      while(rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getInt("dept_id")    + "</td>");
        out.println("<td>" + rs.getString("dept_name") + "</td>");
        out.println("<td>" + rs.getString("dept_code") + "</td>");
        out.println("</tr>");
      }
      out.println("</table>");
      conn.close();

    } catch(Exception e) {
      out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    }

    out.println("</body></html>");
  }
}