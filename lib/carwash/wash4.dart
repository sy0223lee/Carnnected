import 'package:flutter/material.dart';
import 'package:mosigg/home.dart';

class Washend extends StatefulWidget {
  const Washend({Key? key}) : super(key: key);

  @override
  State<Washend> createState() => _WashendState();
}

class _WashendState extends State<Washend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('세차 서비스 예약', 16.0, FontWeight.w500, Colors.black),
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

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}

Container gohome(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 56,
    padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 16.0),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      },
      child: text('홈', 14.0, FontWeight.w500, Colors.white),
      style: ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
    ),
  );
}
