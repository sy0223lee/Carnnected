import 'package:flutter/material.dart';
import 'package:mosigg/signup3.dart';
import 'package:mosigg/home.dart';

class SignUp4 extends StatefulWidget {
  const SignUp4({ Key? key }) : super(key: key);

  @override
  _SignUp4State createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
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
          onPressed: (){ // 이 부분은 회원가입 부분 구현 끝나면 없애야 할 듯(회원가입 완료하고 다시 회원가입.. 에러.. 가능성..)
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SignUp3()));
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
                children: [
                  Divider(thickness: 2.0, color: Color(0xff001A5D), endIndent: 0.0),
                  SizedBox(height: 60.0),
                  Form(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                      child: Column(
                        children: [
                          text('카넥티드 가입을', 24.0, FontWeight.w500, Colors.black),
                          text('축하드려요:D', 24.0, FontWeight.w500, Colors.black),
                          SizedBox(height: 60.0),
                          Image.asset('image/signedup.png', width: 200.0, height: 200.0),
                          SizedBox(height: 60.0),
                          SizedBox(
                            width: 400.0,
                            height: 45.0,
                            child: ElevatedButton(
                              onPressed: () {
                                 Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                          HomePage()));
                              },
                              child: text(
                                  '카넥티드 시작하기', 14.0, FontWeight.w500, Colors.white),
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

