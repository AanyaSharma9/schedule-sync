<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Schedule Sync Admin Panel</title>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
<style>
  body { 
  font-family:rgb(128, 0, 128); 
  background-color : #f5f4f0; 
  margin: 0; 
  padding: 30px;}
  h1 { 
  color: #6c3483;}
  table { 
  width: 100%; 
  border-collapse:collapse; 
  background: #fff; 
  border-radius: 12px; 
  overflow: hidden; 
  box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
  th { 
  background: #6c3483; 
  color: #fff; 
  padding: 12px 16px; 
  text-align: left; 
  font-size: 0.85rem; }
  td { 
  padding: 11px 16px; 
  border-bottom: 1px solid #e0ddd8; 
  font-size: 0.88rem; }
  tr:last-child td { 
  border-bottom: none; }
  tr:hover td { 
  background: #f9f9f9; }
  .error { 
  color: red; 
  font-weight: bold; }
</style>
</head>
<body>
<h1>Schedule Sync Timetable</h1>
<%
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;
  String error = null;
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campusflow", "root", "your_password");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM view_timetable");
%>
<table>
  <tr>
    <th>Course</th>
    <th>Faculty</th>
    <th>Room</th>
    <th>Day</th>
    <th>Start</th>
    <th>End</th>
    <th>Type</th>
    <th>Dept</th>
    <th>Sem</th>
  </tr>
  <% while(rs.next()) { %>
  <tr>
    <td><%= rs.getString("course_name") %></td>
    <td><%= rs.getString("faculty_name") %></td>
    <td><%= rs.getString("room_name") %></td>
    <td><%= rs.getString("day_of_week") %></td>
    <td><%= rs.getString("start_time").substring(0, 5) %></td>
    <td><%= rs.getString("end_time").substring(0, 5) %></td>
    <td><%= rs.getString("slot_type") %></td>
    <td><%= rs.getString("dept_code") %></td>
    <td><%= rs.getString("semester") %></td>
  </tr>
  <% } %>
</table>
<%
  } catch(Exception e) {
    error = e.getMessage();
  } finally {
    if(rs != null) try { rs.close();   } catch(Exception e) {}
    if(stmt != null) try { stmt.close(); } catch(Exception e) {}
    if(conn != null) try { conn.close(); } catch(Exception e) {}
  }
  if(error != null) {
%>
    <p class="error">Database Error: <%= error %></p>
<%
  }
%>
</body>
</html>