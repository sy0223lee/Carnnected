import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosigg/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController inputid = TextEditingController();
  TextEditingController inputpw = TextEditingController();

  Future login() async {
    var response = await http.post("localhost:8080/login/:id/:pwd", body: {
      "id": inputid.text,
      "pwd": inputpw.text,
    });
    var data = json.decode(response.body);
    if (data == "true") {
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>/*홈화면*/ ),),
    } else {
      Fluttertoast.showToast(
          msg: '아이디와 비밀번호가 일치하지 않습니다',
          fontSize: 15.0,
          backgroundColor: Color(0xff001A5D),
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '로그인',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.clear_rounded),
          iconSize: 45.0,
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => StartPage()));
          },
        ),
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'CARNNECTED',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 54.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Color(0xffCBCBCB),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Color(0xffCBCBCB),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 0.0),
                      child: Column(
                        children: [
                          Container(
                            height: 44,
                            child: TextField(
                              controller: inputid,
                              decoration: InputDecoration(
                                  hintText: '아이디', helperText: '아이디를 입력해주세요!'),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 44,
                            child: TextField(
                              controller: inputpw,
                              decoration: InputDecoration(
                                hintText: '비밀번호',
                                helperText: '비밀번호를 입력해주세요!',
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text('아이디 또는 비밀번호를 잊어 버리셨다구요?'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Color(0xff001A5D),
                                    textStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                  child: Text('관리자에게 문의')),
                            ],
                          ),
                          SizedBox(
                            width: 400,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff001A5D),
                                  onPrimary: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {
                                  login();
                                },
                                child: Text('로그인')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
