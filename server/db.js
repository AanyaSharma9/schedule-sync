const mysql = require('mysql2');
const dotenv = require('dotenv');
dotenv.config();
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  port: 3306,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,  
  database: process.env.DB_NAME,
  authPlugins: {
    mysql_native_password: () => () => Buffer.from('root123\0')
  }
});
db.connect((err)=>{
  if (err) {
    console.error('Database connection failed', err.message);
    return;
  }
  console.log('Connected to MySQL database');
});
module.exports = db;