import 'package:flutter/material.dart';
import 'package:mosigg/signup1.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({ Key? key }) : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('회원가입', 20.0, FontWeight.w600, Colors.black),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 40.0,
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