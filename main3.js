var mysql = require('mysql');
const express = require('express');
const app = express();

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "Kabab101",
  database: "carrentalsystem"
});


app.use(express.static('public'));

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
  
  var sql = "INSERT INTO CUSTOMER_DETAILS VALUES('F7865253', 'HUSSAIN','DEV','8349383576', 'hussdev@gmail.com','MG road','PUNE','MAHARASHTRA',41001,'M','M1052');";
  
  con.query(sql, function (err, result) {
    if (err) throw err;
    console.log("1 record inserted");
  });
});




app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/index3.html');
});
app.get('/getData', (req, res) => {
  const sql = 'SELECT * FROM CUSTOMER_DETAILS';
  con.query(sql, (err, result) => {
      if (err) {
          console.error('MySQL query error: ' + err.message);
          res.status(500).send('Internal Server Error');
          return;
      }
      res.json(result);
  });
});