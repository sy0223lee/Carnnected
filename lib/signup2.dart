import 'package:flutter/material.dart';
import 'package:mosigg/signup1.dart';
import 'package:mosigg/signup3.dart';

String pwd = '';

class SignUp2 extends StatefulWidget {
  const SignUp2({ Key? key }) : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  var pwdcheck = false;
  final inputPwd = TextEditingController();
  final inputCpwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('회원가입', 20.0, FontWeight.w500, Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 40.0,
          color: Colors.black,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SignUp1()));
          },),
      ),
      body: Builder(
        builder: (context){
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(thickness: 2.0, color: Color(0xff001A5D), endIndent: 210.0),
                  SizedBox(height: 40.0),
                  Form(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text('비밀번호', 16.0, FontWeight.w500, Colors.black),
                          TextField(
                            controller: inputPwd,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCBCBCB), width: 2.0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCBCBCB), width: 2.0)),
                                helperText: '비밀번호는 6자리 이상만 가능해요!',
                                helperStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffCBCBCB)),
                                focusColor: Colors.grey),
                          ),
                          SizedBox(height: 15.0,),
                          text('비밀번호 확인', 16.0, FontWeight.w500, Colors.black),
                          TextField(
                            controller: inputCpwd,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCBCBCB), width: 2.0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCBCBCB), width: 2.0)),
                                helperText: '비밀번호가 일치하지 않아요!',
                                helperStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffCBCBCB)),
                                focusColor: Colors.grey),
                          ),
                          SizedBox(height: 20.0),
                          SizedBox(
                            width: 400.0,
                            height: 45.0,
                            child: ElevatedButton(
                              onPressed: () {
                                if(inputPwd.text == inputCpwd.text && inputPwd.text.length >= 6){
                                  setState(() {
                                    pwd = inputPwd.text;
                                  });
                                  pwdcheck = true;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignUp3()));
                                } else {
                                  pwdcheck = false;
                                }
                              },
                              child: text(
                                  '계속하기', 14.0, FontWeight.w500, Colors.white),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff001A5D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  elevation: 0.0,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

Text text(content, size, weight, colors){
  return Text(
    content, style: TextStyle(fontSize: size, fontWeight: weight, color: colors)
  );
}