CREATE DATABASE campusflow;
USE campusflow;

CREATE TABLE users (user_id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) NOT NULL,email VARCHAR(150) NOT NULL UNIQUE,password_hash VARCHAR(255) NOT NULL,role ENUM('student', 'faculty', 'admin') NOT NULL,phone VARCHAR(15),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE departments (dept_id INT AUTO_INCREMENT PRIMARY KEY,dept_name VARCHAR(100) NOT NULL UNIQUE,dept_code VARCHAR(10)  NOT NULL UNIQUE);

CREATE TABLE students (student_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT NOT NULL UNIQUE,dept_id INT NOT NULL,roll_number VARCHAR(20) NOT NULL UNIQUE,semester INT NOT NULL,section VARCHAR(5),FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,FOREIGN KEY (dept_id) REFERENCES departments(dept_id));

CREATE TABLE faculty (faculty_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT NOT NULL UNIQUE,dept_id INT NOT NULL,employee_code VARCHAR(20) NOT NULL UNIQUE,designation VARCHAR(100),FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,FOREIGN KEY (dept_id) REFERENCES departments(dept_id));

CREATE TABLE rooms (room_id INT AUTO_INCREMENT PRIMARY KEY,room_name VARCHAR(50) NOT NULL UNIQUE,building VARCHAR(50),capacity INT DEFAULT 60,room_type ENUM('classroom','lab','seminar_hall') DEFAULT 'classroom');

CREATE TABLE courses (course_id INT AUTO_INCREMENT PRIMARY KEY,course_name VARCHAR(150) NOT NULL,course_code VARCHAR(20)  NOT NULL UNIQUE,dept_id INT NOT NULL,semester INT NOT NULL,credits INT DEFAULT 3,FOREIGN KEY (dept_id) REFERENCES departments(dept_id));

CREATE TABLE timetable (slot_id INT AUTO_INCREMENT PRIMARY KEY,course_id INT NOT NULL,faculty_id INT NOT NULL,room_id INT NOT NULL,dept_id INT NOT NULL,semester INT NOT NULL,section VARCHAR(5),day_of_week ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,start_time TIME NOT NULL,end_time TIME NOT NULL,slot_type ENUM('lecture','lab','tutorial') DEFAULT 'lecture',created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (course_id)REFERENCES courses(course_id),FOREIGN KEY (faculty_id)REFERENCES faculty(faculty_id),FOREIGN KEY (room_id)REFERENCES rooms(room_id),FOREIGN KEY (dept_id)REFERENCES departments(dept_id));

CREATE TABLE conflicts (conflict_id INT AUTO_INCREMENT PRIMARY KEY,slot_id_1 INT NOT NULL,slot_id_2 INT NOT NULL,conflict_type ENUM('faculty_clash','room_clash','student_clash') NOT NULL,status ENUM('pending','resolved','ignored') DEFAULT 'pending',detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,resolved_at TIMESTAMP NULL,resolved_by INT NULL,FOREIGN KEY (slot_id_1)REFERENCES timetable(slot_id),FOREIGN KEY (slot_id_2)REFERENCES timetable(slot_id),FOREIGN KEY (resolved_by)REFERENCES users(user_id));

CREATE TABLE reschedule_requests (request_id INT AUTO_INCREMENT PRIMARY KEY,requested_by INT NOT NULL,slot_id INT NOT NULL,reason TEXT,preferred_day ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'),preferred_time TIME,status ENUM('pending','approved','rejected') DEFAULT 'pending',reviewed_by INT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,reviewed_at TIMESTAMP NULL,FOREIGN KEY (requested_by) REFERENCES users(user_id),FOREIGN KEY (slot_id) REFERENCES timetable(slot_id),FOREIGN KEY (reviewed_by) REFERENCES users(user_id));

CREATE TABLE faculty_free_slots (free_slot_id INT AUTO_INCREMENT PRIMARY KEY,faculty_id INT NOT NULL,day_of_week  ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,start_time TIME NOT NULL,end_time TIME NOT NULL,FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id) ON DELETE CASCADE);

CREATE TABLE notifications (notif_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT NOT NULL,message TEXT NOT NULL,is_read BOOLEAN DEFAULT FALSE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE);

INSERT INTO departments (dept_name, dept_code) VALUES('Computer Science & Engineering', 'CSE'),('Electronics & Communication', 'ECE'),('Information Technology', 'IT'),('Civil Engineering', 'CE');

INSERT INTO rooms (room_name, building, capacity, room_type) VALUES('A101', 'Block A', 60, 'classroom'),('A102', 'Block A', 60, 'Classroom'),('B201', 'Block B', 30, 'Seminar hall'),('CS Lab 1', 'Block C', 40, 'Lab'),('CS Lab 2', 'Block C', 40, 'Lab');