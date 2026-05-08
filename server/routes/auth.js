const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../db');
const router = express.Router();
router.post('/register', async (req, res) => {
  const { name, email, password, role, phone } = req.body;
  if (!name || !email || !password || !role)
    return res.status(400).json({ error: 'All fields required' });
  try {
    const hash = await bcrypt.hash(password, 10);
    const sql = 'INSERT INTO users (name, email, password_hash, role, phone) VALUES (?, ?, ?, ?, ?)';
    db.query(sql, [name, email, hash, role, phone], (err, result) => {
      if (err) return res.status(500).json({ error: 'Email already exists' });
      res.json({ message:'Registered successfully', userId: result.insertId });
    });
  } catch (err) {
    res.status(500).json({error: 'Server error'});
  }
});
router.post('/login', (req, res)=>{
  const { email, password, role } = req.body;
  if (!email || !password || !role)
    return res.status(400).json({ error: 'All fields required' });
  const sql = 'SELECT * FROM users WHERE email = ? AND role = ?';
  db.query(sql, [email, role], async (err, results) => {
    if (err || results.length === 0)
      return res.status(401).json({ error: 'Invalid email or role' });
    const user  = results[0];
    const match = await bcrypt.compare(password, user.password_hash);
    if (!match)
      return res.status(401).json({ error: 'Wrong password' });
    const token = jwt.sign(
      { userId: user.user_id, role: user.role, name: user.name },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );
    res.json({ message:'Login successful', token, role: user.role, name: user.name });
  });
});
module.exports = router;