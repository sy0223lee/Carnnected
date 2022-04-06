import 'package:flutter/material.dart';
import 'package:mosigg/login/login.dart';

Text text(content, size, weight, colors) {
  return Text(
    content,
    style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}

Row splitrow(type, info) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      text(type, 14.0, FontWeight.w500, Colors.black),
      text(info, 14.0, FontWeight.w400, Colors.black)
    ],
  );
}

Row splitrow2(type, info) {
  //뚱뚱한버전
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      text(type, 16.0, FontWeight.w500, Colors.black),
      text(info, 16.0, FontWeight.bold, Colors.black)
    ],
  );
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