const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());
const authRoutes = require('./routes/auth');
const timetableRoutes = require('./routes/timetable');
app.use('/api/auth', authRoutes);
app.use('/api/timetable', timetableRoutes);
app.get('/', (req, res)=>{
  res.json({ message:'CampusFlow Server Running'});
});
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server started on http://localhost:${PORT}`);
});