var express = require('express');
var app = express();
var mySQL = require('mysql');

// mySQL 연동
var pool = mySQL.createPool({
    host:'localhost',
    port: 3306,
    user: 'root',
    database: 'carnnected'
});

// server port
app.listen(8080, () => {
    console.log('server run: 8080');
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
            if(row[0] !== undefined){
                console.log('아이디 중복', row);
                res.send(true);
            }
            else{
                console.log('아이디 중복 X, 사용 가능');
                res.send(false);
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

    pool.getConnection(function(err, connection){
        var sqlLogin = "SELECT * FROM member WHERE id = ? and pwd = ?";
        connection.query(sqlLogin, [id, pwd], function(err, result){
            if(err) console.log('로그인 오류');
            if(result[0] !== undefined){
                console.log("로그인 성공 id:", id);
                res.send(true);
            }
            else {
                console.log("로그인 실패");
                res.send(false);
            }
            connection.release();
        })
    })
})



/***** 전체 서비스 *****/
// 즐겨찾는 주소 전송
app.get('/favorite_addr/:id', function(req, res){
	var id = req.params.id;
    pool.getConnection(function(err, connection){
        var sqlAddr = "SELECT * FROM FAVORITE_ADDR WHERE id = ? ORDER BY num DESC";
        connection.query(sqlAddr, id, function(err, rows){
            if(err){
            }
            else{
                console.log("즐겨찾는 주소 전송 성공:", rows);
                res.send(rows);
            }
            connection.release();
        })
    })
})

// 즐겨찾는 주소 추가
app.get('/favorite_addr/insert/:id/:addr/:detailAddr', function(req, res){
    var id = req.params.id;
    var addr = req.params.addr;
    var detailAddr = req.params.detailAddr;

    var sqlAddrCount = "SELECT count(*) AS addrCount FROM FAVORITE_ADDR WHERE id = ?";
    pool.query(sqlAddrCount, id, function(err, result){
        console.log(result[0]);
        if(result[0] === undefined)
            var addrCount = 0;
        else
            var addrCount = result[0].addrCount;

        pool.getConnection(function(err, connection){
            var sqlAddrInsert = "INSERT INTO FAVORITE_ADDR VALUES (?, ?, ?, ?)";
            connection.query(sqlAddrInsert, [id, addr, detailAddr, addrCount+1], function(err){
                if(err){
                    // 이미 추가했던 주소의 경우도 포함
                    console.log("즐겨찾는 주소 추가 오류");
                    res.send(false);
                }
                else{
                    console.log("즐겨찾는 주소 추가 성공:", addr, detailAddr);
                    res.send(true);
                }
                connection.release();
            })
        })
    })
})

// 즐겨찾는 주소 삭제
app.get('/favorite_addr/delete/:id/:addr/:detailAddr', function(req, res){
    var id = req.params.id;
    var addr = req.params.addr;
    var detailAddr = req.params.detailAddr;

    pool.getConnection(function(err, connection){
        var sqlAddrDelete = "DELETE FROM FAVORITE_ADDR WHERE id = ? AND addr = ? AND detailAddr = ?";
        connection.query(sqlAddrDelete, [id, addr, detailAddr], function(err){
            if(err){
                console.log("즐겨찾는 주소 삭제 오류:", addr, detailAddr);
                res.send(false);
            }
            else{
                console.log("즐겨찾는 주소 삭제 성공:", addr, detailAddr);
                
                // num 연속되게 다시 설정
                var sqlAddrCount = "SELECT count(*) AS addrCount FROM FAVORITE_ADDR WHERE id = ?";
                pool.query(sqlAddrCount, id, function(err, result){
                    if(result[0] !== undefined){
                        var sqlAddrNum = "SELECT num FROM FAVORITE_ADDR WHERE id = ? ORDER BY num";
                        pool.query(sqlAddrNum, id, function(err, rows){
                            for(var i = 0; i<result[0].addrCount; i++){
                                if(i+1 !== rows[i].num){
                                    var sqlOrder = "UPDATE FAVORITE_ADDR SET num = ? WHERE num = ?"
                                    pool.query(sqlOrder, [i+1, rows[i].num], function(err){
                                        console.log("순서 다시 정렬");
                                    })
                                }
                            }
                        })
                    }
                })           
                res.send(true);
            }
            connection.release();
        })
    })
})

// 차량 정보 반환 
app.get('/carinfo/:id', function(req,res){
    var id = req.params.id;
    pool.getConnection(function(err, connection){
        var sqlCarinfo = "SELECT * FROM CAR WHERE id = ?";
        connection.query(sqlCarinfo, id, function(err, rows0){
            if(err){
                console.log("차량 정보 전송 오류: ", rows0);
                res.send(false);
            }
            else{
                console.log("차량 정보 전송 성공: ", rows0);
                res.send(rows0);
            }
            connection.release();
        })
    })
})

// 사용중인 서비스 확인
app.get('/usingservice/:carnumber', function(req, res){
    var carnumber = req.params.carnumber;
    pool.getConnection(function(err, connection){
        var sqlUsinggas = "SELECT `time` FROM GAS_RESRV WHERE number = ? AND status = 'progress'";
        connection.query(sqlUsinggas, carnumber, function(err, rows1){
            if(err){
                console.log("사용중인 주유 서비스 오류: ", rows1);
                res.send(false);
            }
            else{
                if(rows1.length != 0){
                    console.log("사용중인 주유 서비스 존재: ", rows1);
                    res.send("주유");
                }
                else{
                    var sqlUsingwash = "SELECT `time` FROM WASH_RESRV WHERE number = ? AND status = 'progress'";
                    connection.query(sqlUsingwash, carnumber, function(err, rows2){
                        if(err){
                            console.log("사용중인 세차 서비스 전송 오류: ", rows1);
                            res.send(false);
                        }
                        else{
                            if(rows2.length != 0){
                                console.log("사용중인 세차 서비스 존재: ", rows2);
                                res.send("세차");
                            }
                            else{
                                var sqlUsingdeliv = "SELECT `time` FROM DELIV_RESRV WHERE number = ? AND status = 'progress'";
                                connection.query(sqlUsingdeliv, carnumber, function(err, rows3){
                                    if(err){
                                        console.log("사용중인 딜리버리 서비스 오류: ", rows1);
                                        res.send(false);
                                    }
                                    else{
                                        if(rows3.length != 0){
                                            console.log("사용중인 딜리버리 서비스 존재: ", rows3);
                                            res.send( "딜리버리");
                                        }
                                        else{
                                            var sqlUsingdrive = "SELECT `time` FROM DRIVE_RESRV WHERE number = ? AND status = 'progress'";
                                            connection.query(sqlUsingdrive, carnumber, function(err, rows4){
                                                if(err){
                                                    console.log("사용중인 대리운전 서비스 오류: ", rows1);
                                                    res.send(false);
                                                }
                                                else{
                                                    if(rows4.length != 0){
                                                        console.log("사용중인 대리운전 서비스 존재: ", rows4);
                                                        res.send("대리운전");
                                                    }
                                                    else{
                                                        var sqlUsingreplace = "SELECT `time` FROM REPLACE_RESRV WHERE number = ? AND status = 'progress'";
                                                        connection.query(sqlUsingreplace, carnumber, function(err, rows5){
                                                            if(err){
                                                                console.log("사용중인 방문교체 서비스 오류: ", rows1);
                                                                res.send(false);
                                                            }
                                                            else{
                                                                if(rows5.length != 0){
                                                                    console.log("사용중인 방문교체 서비스 존재: ", rows5);
                                                                    res.send("방문교체");
                                                                }
                                                                else{
                                                                    var sqlUsingrepair = "SELECT `time` FROM REPAIR_RESRV WHERE number = ? AND status = 'progress'";
                                                                    connection.query(sqlUsingrepair, carnumber, function(err, rows6){
                                                                        if(err){
                                                                            console.log("사용중인 대리정비 서비스 오류: ", rows1);
                                                                            res.send(false);
                                                                        }
                                                                        else{
                                                                            if(rows6.length != 0){
                                                                                console.log("사용중인 대리정비 서비스 존재: ", rows6);
                                                                                res.send("대리정비");
                                                                            }
                                                                            else
                                                                                res.send("없음");
                                                                        }
                                                                    })
                                                                }
                                                            }
                                                        })
                                                    }
                                                }
                                            })
                                        }
                                    }
                                })
                            }
                        }
                    })
                }
            }
            connection.release();
        });
    })
})

// 최근 사용 서비스 확인
app.get('/recentservice/:carnumber', function(req, res){
    var carnumber = req.params.carnumber;
    pool.getConnection(function(err, connection){
        var sqlRecent = "SELECT tablename, `time` FROM DELIV_RESRV UNION SELECT tablename, `time` FROM DRIVE_RESRV UNION SELECT tablename, `time` FROM GAS_RESRV UNION SELECT tablename, `time` FROM REPAIR_RESRV UNION SELECT tablename, `time` FROM REPLACE_RESRV UNION SELECT tablename, `time` FROM WASH_RESRV WHERE number = ? ORDER BY `time` DESC;";
        connection.query(sqlRecent, carnumber, function(err, rows){
            if(err){
                console.log("최근 사용 서비스 전송 오류: ", rows);
                res.send(false);
            }
            else{
                console.log("최근 사용 서비스 전송 성공: ", rows);
                res.send(rows);
            }
            connection.release();
        })
    })
})

/***** 지도 서비스 *****/
// 정비 검색 키워드: "자동차 수리점"
// 세차 검색 키워드: "세차장"
// 정비, 세차 같이 검색: "자동차 수리점, 세차장"
app.get('/map/:keyword/:x/:y', function(req, res){
    var keyword = req.params.keyword;
    var x = req.params.x;
    var y = req.params.y;
    var search = require('./crawling.js');
    
    pool.getConnection(async function(err, connection){
        var fixList = await search(keyword, x, y);
        setTimeout(() => {
            console.log(keyword, ":", fixList);
            res.send(fixList);
        }, 45000);
        connection.release();
    })
})


/***** 주유 서비스 *****/
// 예약 insert
app.get('/gas_resrv/:id/:number/:time/:source/:detailSrc/:type/:dest_name/:amount/:price/:payment', function(req, res){
    var id = req.params.id;
    var number = req.params.number;
    var time = req.params.time;
    var source = req.params.source;
    var detailSrc = req.params.detailSrc;
    var type = req.params.type;
    var dest_name = req.params.dest_name;
    var amount = req.params.amount;
    var price = req.params.price;
    var payment = req.params.payment;

    pool.getConnection(function(err, connection){
        // 동일한 시간, 차량 예약 정보가 존재하는지 확인
        var sqlResrvCheck = "SELECT count(*) as count FROM((SELECT `number` FROM deliv_resrv WHERE `time`=? and `number`=?) UNION ALL (SELECT `number` FROM drive_resrv WHERE `time`=? and `number`=?) UNION ALL (SELECT `number` FROM gas_resrv WHERE `time`=? and `number`=?) UNION ALL (SELECT `number` FROM repair_resrv WHERE `time`=? and `number`=?) UNION ALL (SELECT `number` FROM replace_resrv WHERE `time`=? and `number`=?) UNION ALL (SELECT `number` FROM wash_resrv WHERE `time`=? and `number`=?)) as RESRV";
        connection.query(sqlResrvCheck, [time, number, time, number, time, number, time, number, time, number, time, number], function(err, row){
            if(err){
                console.log("동일한 예약 존재 확인 오류:", row[0]);
                res.send(false);
            }
            else{
                if(row[0].count === 0){   // 정보 없으면 예약 가능
                    console.log("주유 예약 가능");
                    
                    // 예약 정보 table에 insert
                    var sqlGasReserv = "INSERT INTO GAS_RESRV (`id`,`number`,`time`,`type`,`amount`,`source`,`detailSrc`,`dest_name`,`price`,`payment`) VALUES (?,?,?,?,?,?,?,?,?,?)";
                    var datas = [id, number, time, type, amount, source, detailSrc, dest_name, price, payment];
                    console.log("주유 예약 정보: ", datas);
    
                    pool.query(sqlGasReserv, datas, function(err){
                        if(err){
                            console.log('주유 예약 INSERT 오류');
                            res.send(false);
                        }
                        else{
                            console.log('주유 예약 INSERT 성공');
                            res.send(true);
                        }
                    })
                }
                else{   // 동일한 정보 존재하면 예약 불가능
                    console.log("동일한 시간, 차량 예약 이미 존재:", row[0]);
                    console.log('주유 예약 INSERT 실패');
                    res.send(false);
                }
            }
            connection.release();
        })
    })    
})