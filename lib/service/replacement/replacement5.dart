import 'package:flutter/material.dart';
import 'package:mosigg/home/home.dart';
import 'package:mosigg/login/login.dart';
import 'package:mosigg/components.dart';

class Replacement5 extends StatefulWidget {
  const Replacement5({Key? key}) : super(key: key);

  @override
  State<Replacement5> createState() => _Replacement5State();
}

class _Replacement5State extends State<Replacement5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('교체 서비스 예약', 16.0, FontWeight.w500, Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 80.0),
        child: Center(
          child: Column(
            children: [
              text('예약이 완료되었습니다', 20.0, FontWeight.w500, Colors.black),
              text('최고의 서비스로 모시겠습니다:D', 20.0, FontWeight.w500, Colors.black),
              SizedBox(height: 43),
              Icon(
                Icons.toys,
                size: 223,
                color: Colors.black,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [gohome(context)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container gohome(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 56,
    padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 16.0),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      },
      child: text('홈', 14.0, FontWeight.w500, Colors.white),
      style: ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
    ),
  );
}