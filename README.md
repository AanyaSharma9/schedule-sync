- Schedule Sync
A college timetable conflict detection system I built as a part of my Web Development and Technologies CORE subject project in my 2nd year.
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

LOGIN PAGE-
<img width="932" height="425" alt="image" src="https://github.com/user-attachments/assets/4f64a7b3-0aef-4e5e-aa1e-f9cca243f337" />
<img width="1209" height="847" alt="image" src="https://github.com/user-attachments/assets/c75ad348-6c52-4010-b7eb-0188632770e7" />

ADMIN DASHBOARD-
<img width="1866" height="871" alt="image" src="https://github.com/user-attachments/assets/859d690d-9d41-4c48-af69-f9f9aab0e4fb" />
<img width="1502" height="681" alt="image" src="https://github.com/user-attachments/assets/87d107a5-deb0-41be-94b8-4a38b61c43b5" />
<img width="1459" height="514" alt="image" src="https://github.com/user-attachments/assets/c14dd21b-17ed-4308-9a62-82bc6d1a47e3" />

STUDENT DASHBOARD-
<img width="1855" height="859" alt="image" src="https://github.com/user-attachments/assets/963b0bfc-ec2f-4dda-acc6-19ea631869da" />
<img width="1476" height="515" alt="image" src="https://github.com/user-attachments/assets/b486bcc6-7495-4c12-b0e8-49cb96066802" />

FACULTY DASHBOARD-
<img width="1861" height="851" alt="image" src="https://github.com/user-attachments/assets/abaede50-ec26-4691-9325-3ddc35a3c62e" />
<img width="1496" height="488" alt="image" src="https://github.com/user-attachments/assets/7666bd09-762f-4657-a453-3446ffbfab54" />

MY SQL TABLES-
<img width="417" height="629" alt="image" src="https://github.com/user-attachments/assets/e034040a-e51c-4404-84f7-91dd86988fcd" />









