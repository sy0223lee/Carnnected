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
        var sql = "SELECT id FROM member";
        connection.query(sql, function(err, rows){
            if(err) console.log(sql, ' 에러');
            else{
                console.log(rows);
            }
            connection.release();
        })
    })
});

/***** 회원가입 *****/
// 아이디 중복 확인
app.get('/signup/:idcheck', function(req,res){
    var idcheck = req.params.idcheck;
    console.log('확인할 아이디:', idcheck);
    
    pool.getConnection(function(err, connection){
        var sqlIdCheck = "SELECT id FROM member WHERE id = ?";
        connection.query(sqlIdCheck, idcheck, function(err, rows){
            if(err) console.log('아이디 중복 확인 에러');
            if(rows.length > 0){
                console.log('아이디 사용 불가', rows);
                res.send(true);
            }
            else{
                console.log('아이디 사용 가능');
                res.send(false);
            }
            connection.release();
        })
    })
})

// 회원 정보 저장
app.get('/signup/:id/:pwd/:name/:birth/:phone', function(req,res){
    var id = req.params.id;
    var pwd = req.params.pwd;
    var name = req.params.name;
    var birth = req.params.birth;
    var phone = req.params.phone;

    var datas = [id, pwd, name, birth, phone];
    console.log("회원 정보:", datas);
        
    pool.getConnection(function(err, connection){
        var sqlMemInsert = "INSERT INTO member VALUES (?, ?, ?, ?, ?)";
        connection.query(sqlMemInsert, datas, function(err){
            if(err) console.log('회원가입 INSERT 오류');
            else {
                pool.query("SELECT * FROM member WHERE id = ?", id, function(err, row){
                    if(row.length > 0){
                        console.log('회원가입 성공:', row);
                        res.send(true);
                    }
                    else {
                        console.log('회원가입 실패');
                        res.send(false);
                    }
                })
            }
            connection.release();
        })
    })
})
