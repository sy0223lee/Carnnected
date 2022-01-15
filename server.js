var express = require('express');
var app = express();
var mySQL = require('mysql');
var session = require('express-session');
var mySQLStore = require('express-mysql-session')(session);
var mySQLOptions = {
    host:'localhost',
    port: 3306,
    user: 'root',
    password: '1234',
    database: 'mosigg'
};

// session
app.use(session({
    secret: 'qlalf',
    resave: false,
    saveUninitialized: true,
    store: new mySQLStore(mySQLOptions)
}));

// mySQL 연동
var pool = mySQL.createPool(mySQLOptions);

// server port
app.listen(8080, () => {
    console.log('server run: 8080');
});

/*테스트*/
app.get('/', function(req, res) {
    pool.getConnection(function(err, connection){
        var sql = "SELECT * FROM member";
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
app.get('/signup/:idcheck', function(req, res){
    var idcheck = req.params.idcheck;
    console.log('확인할 아이디:', idcheck);
    
    pool.getConnection(function(err, connection){
        var sqlIdCheck = "SELECT id FROM member WHERE id = ?";
        connection.query(sqlIdCheck, idcheck, function(err, row){
            if(err) console.log('아이디 중복 확인 에러');
            if(row[0] === undefined){
                console.log('아이디 사용 가능');
                res.send(false);
            }
            else{
                console.log('아이디 사용 불가', row);
                res.send(true);
            }
            connection.release();
        })
    })
})

// 회원 정보 저장
app.get('/signup/:id/:pwd/:name/:birth/:phone', function(req, res){
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
                    if(row[0].id === id){
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

/***** 로그인 *****/
app.get('/login/:id/:pwd', function(req, res){
    var id = req.params.id;
    var pwd = req.params.pwd;
    var sqlLogin = "SELECT * FROM member WHERE id = ? and pwd = ?";

    pool.query(sqlLogin, [id, pwd], function(err, result){
        if(err) console.log('로그인 오류');
        if(result[0] !== undefined){
            req.session.isLogined = true;
            req.session.id = result[0].id;
            req.session.pwd = result[0].pwd;
            req.session.name = result[0].name;
            req.session.birth = result[0].birth;
            req.session.phone = result[0].phone;

            req.session.save(function(){
                console.log("로그인 성공", req.session);
                res.send(true);
            })
        }
        else {
            console.log("로그인 실패");
            res.send(false);
        }
    })
})