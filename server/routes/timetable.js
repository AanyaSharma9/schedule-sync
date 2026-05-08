const express = require('express');
const db = require('../db');
const router  = express.Router();
router.get('/', (req, res) => {
  const sql = 'SELECT * FROM view_timetable';
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({error: err.message });
    res.json(results);
  });
});
router.get('/student',(req, res)=>{
  const { dept_code, semester, section }=req.query;
  const sql = 'SELECT * FROM view_timetable WHERE dept_code = ? AND semester = ? AND section = ?';
  db.query(sql, [dept_code, semester, section], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
router.get('/faculty',(req, res)=>{
  const { faculty_name } = req.query;
  const sql = 'SELECT * FROM view_timetable WHERE faculty_name = ?';
  db.query(sql, [faculty_name], (err, results)=>{
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
router.get('/conflicts', (req, res) => {
  const sql = 'SELECT * FROM view_pending_conflicts';
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
router.post('/add', (req, res) => {
  const { course_id, faculty_id, room_id, dept_id, semester, section, day_of_week, start_time, end_time, slot_type } = req.body;
  const conflictCheck = `SELECT * FROM timetable WHERE day_of_week = ? AND ((faculty_id = ? OR room_id = ?)AND NOT (end_time <= ? OR start_time >= ?))`;
  db.query(conflictCheck, [day_of_week, faculty_id, room_id, start_time, end_time], (err, conflicts) => {
    if (err) return res.status(500).json({ error: err.message });
    if (conflicts.length > 0)
      return res.status(409).json({ error: 'Conflict detected!', conflicts });
    const sql = `INSERT INTO timetable(course_id, faculty_id, room_id, dept_id, semester, section, day_of_week, start_time, end_time, slot_type)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
    db.query(sql, [course_id, faculty_id, room_id, dept_id, semester, section, day_of_week, start_time, end_time, slot_type],
      (err, result)=>{
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Slot added!', slotId: result.insertId });
      }
    );
  });
});
//timetable by student user_id
router.get('/mystudent', (req, res) => {
  const { user_id } = req.query;
  const sql = `SELECT t.day_of_week, t.start_time, t.end_time, t.slot_type,c.course_name, r.room_name FROM timetable t JOIN courses c ON t.course_id = c.course_id JOIN rooms r ON t.room_id = r.room_id JOIN students s ON s.dept_id = t.dept_id AND s.semester = t.semester AND s.section = t.section WHERE s.user_id = ? ORDER BY FIELD(t.day_of_week,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'), t.start_time`;
  db.query(sql, [user_id], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
module.exports = router;