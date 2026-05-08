- Schedule Sync
A college timetable conflict detection system I built as part of my Web Technologies and Applications project in my 2nd year.
The idea came from the constant timetable clashes we face in college, same faculty getting assigned to two classes, rooms getting double booked etc. So I decided to build something that actually detects and manages these conflicts.

What it does
1. Students, faculty and admins can log in separately
2. Timetable clashes are detected automatically
3. Faculty and students can raise reschedule requests
4. Admin can approve or reject them

Tech I used
1. MySQL for the database
2. HTML, CSS, JavaScript for the frontend
3. Node.js and Express for the backend API
4. JSP, Servlet and JDBC with Apache Tomcat for the Java module
5. bcrypt for password encryption, JWT for authentication

How to run it
1. Run `database/schema.sql` in MySQL
2. Create `server/.env` file with your own Database credentials
3. `cd server` then `node server.js`
4. Open `index.html` in your browser
5. For Java part — import `java-module` in Eclipse and then run on Tomcat

Folder structure
1. `database/` — MySQL schema
2. `index.html` — login page
3. `register.html` — register page
4. `student/` — student dashboard
5. `faculty/` — faculty dashboard
6. `admin/` — admin panel
7. `server/` — Node.js (backend)
8. `java-module/` — JSP + Servlet + JDBC files
