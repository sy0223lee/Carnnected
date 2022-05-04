import 'package:mosigg/signup/signup1.dart';
import 'package:mosigg/signup/signup2.dart';
import 'package:mosigg/signup/signup4.dart';
import 'package:mosigg/signup/common/signupWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String name = '';
String birth = '';

class SignUp3 extends StatefulWidget {
  const SignUp3({Key? key}) : super(key: key);

  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  final inputName = TextEditingController();
  final inputBirth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 40.0,
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SignUp2()));
          },
        ),
      ),
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                    thickness: 2.0, color: Color(0xff001A5D), endIndent: 105.0),
                SizedBox(height: 40.0),
                Form(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldMethod(
                            controller: inputName,
                            intro: '이름',
                            helperText: '이름을 입력해주세요!',
                            obsecure: false),
                        SizedBox(height: 15.0),
                        TextFieldMethod(
                            controller: inputBirth,
                            intro: '주민번호 앞자리',
                            helperText: '주민번호 앞 6자리를 입력해주세요!',
                            obsecure: false,
                            keyType: TextInputType.number),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 400.0,
                          height: 45.0,
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              name = inputName.text;
                              birth = inputBirth.text;
                              bool sign = await signup('$id', '$pwd',
                                  '$name', '$birth', '01000000000');
                              if (sign == true &&
                                  name.length != 0 &&
                                  birth.length != 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignUp4()));
                              }
                            },
                            child: Text('휴대폰 본인인증',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff001A5D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 0.0,
                            ),
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
      }),
    );
  }
}

Future<bool> signup(
    String id, String pwd, String name, String birth, String phone) async {
  final response = await http.get(Uri.parse(
      'http://10.0.2.2:8080/signup/$id/$pwd/$name/$birth/$phone'));

  if (response.statusCode == 200) {
    if (json.decode(response.body) == true)
      return true; // 회원가입 성공
    else
      return false; // 회원가입 실패
  } else {
    return false;
  }
}
