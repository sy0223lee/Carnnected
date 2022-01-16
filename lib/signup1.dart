import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosigg/signup2.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp1> {
  final inputId = TextEditingController();
  String id = '';
  var idExist = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('회원가입', 20.0, FontWeight.w600, Colors.black),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.clear_rounded),
          iconSize: 45.0,
          onPressed: () {
            // 시작페이지로 이동
          },
        ),
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                      thickness: 2.0,
                      color: Color(0xff001A5D),
                      endIndent: 300.0),
                  SizedBox(height: 40.0),
                  Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child:
                          text('모시깽이의', 24.0, FontWeight.w600, Colors.black)),
                  Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: text(
                          '계정을 만들게요:)', 24.0, FontWeight.w600, Colors.black)),
                  SizedBox(height: 40.0),
                  Form(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text('아이디', 16.0, FontWeight.w600, Colors.black),
                          TextField(
                            controller: inputId,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCBCBCB), width: 2.0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCBCBCB), width: 2.0)),
                                helperText: '아이디를 입력해주세요!',
                                helperStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffCBCBCB)),
                                focusColor: Colors.grey),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              // 아이디 존재여부 확인
                              if (inputId.text == id) {
                                setState(() {
                                  idExist = true;
                                });
                              }
                              // 없는 아이디면 서버에 데이터 전달 후 다음 페이지로 이동
                              else {
                                setState(() {
                                  id = inputId.text;
                                });
                                idExist = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignUp2()));
                              }
                            },
                            child: text(
                                '계속하기', 14.0, FontWeight.w600, Colors.white),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff001A5D),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 0.0,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 154.7)),
                          ),
                          (idExist == true)
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text('앗! 이미 존재하는 아이디예요!',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ))
                              : SizedBox(height: 61.0),
                          SizedBox(height: 90.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 1.0,
                                    width: 130.0,
                                    color: Color(0xffCBCBCB)),
                                TextButton(
                                    onPressed: () {
                                      // 간편 회원가입 페이지로 이동
                                    },
                                    child: text('간편 회원가입', 14.0,
                                        FontWeight.w600, Color(0xffCBCBCB))),
                                Container(
                                    height: 1.0,
                                    width: 130.0,
                                    color: Color(0xffCBCBCB)),
                              ]),
                          InkWell(
                            onTap: () {
                              // 카톡 로그인 페이지로 이동
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 120.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffF9E000),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Row(
                                  children: [
                                    Image.asset('image/kakao.png',
                                        width: 25, height: 25),
                                    SizedBox(width: 5),
                                    text('카카오로 시작', 14.0, FontWeight.w600,
                                        Colors.black)
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}
