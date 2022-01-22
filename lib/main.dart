import 'package:flutter/material.dart';
import 'package:mosigg/login.dart';
import 'package:mosigg/signup1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOSIGG',
      theme: ThemeData(
          fontFamily: 'NotoSansKR',
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001A5D),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 150),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'CARNNECTED',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '차량 관리를 더 쉽고 더 간편하게',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      SizedBox(
                        width: 270,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xfff9e000),
                              onPrimary: Color(0xff000000)),
                          onPressed: () {/*카카오톡 로그인 페이지*/},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_bubble, color: Colors.black),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '카카오톡으로 로그인',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: 270,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffffffff),
                              onPrimary: Color(0xff000000)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '모시깽이로 로그인',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Color(0xff000000),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp1()),
                          );
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
