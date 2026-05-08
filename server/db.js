const mysql = require('mysql2');
const dotenv = require('dotenv');
dotenv.config();
const db = mysql.createConnection({
  host:'localhost',
  port:3306,
  user:'root',
  password:'root123',
  database:'campusflow',
  authPlugins: {
    mysql_native_password:()=>()=>Buffer.from('root123\0')
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