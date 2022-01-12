var express = require('express');
var app = express();
var mysql = require('mysql');

var pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: "1234",
    database: 'mosigg'
});

app.listen(8080, () => {
    console.log('server run: 8080');
});

/*테스트*/
app.get('/', function(req, res, next) {
    pool.getConnection(function(err, connection){
          var sql = "SELECT * FROM member";
          connection.query(sql, function(err, row){
              if(err) console.log(sql + ' 에러');
              else{
                  console.log(row);
              }
              connection.release();
          })
      })
  });