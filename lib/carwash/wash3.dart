import 'package:flutter/material.dart';
import 'package:mosigg/carwash/wash2.dart';
import 'package:mosigg/oiling/oilend.dart';
import 'package:mosigg/oiling/oilprice.dart';

class Washconfirm extends StatefulWidget {
  const Washconfirm({Key? key}) : super(key: key);

  @override
  State<Washconfirm> createState() => _WashconfirmState();
}

class _WashconfirmState extends State<Washconfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('세차 서비스 예약', 16.0, FontWeight.w500, Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Washsecond()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('예약 내역을 확인해주세요', 12.0, FontWeight.w400, Color(0xff9a9a9a)),
            text('세차 서비스 예약 내역', 16.0, FontWeight.bold, Colors.black),
            SizedBox(height: 34.0),
            splitrow('차량번호', '12가 1234'),
            SizedBox(height: 20.0),
            splitrow('예약일시', '2022년 4월 29일 오후 12:00'),
            splitrow('차량위치', '경기도'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [text('상세주소', 14.0, FontWeight.w400, Colors.black)],
            ),
            SizedBox(height: 10.0),
            splitrow('외부 세차', '없음'),
            splitrow('내부 세차', '실내 클리닝'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('추가 요청', 14.0, FontWeight.w500, Colors.black),
                Container(
                  width: 271,
                  child: Flexible(
                    child: Text.rich(TextSpan(
                        text: '아무생각없이 보기좋은 스낵무비 밤밤밤밤 알밤군밤고구마 룰루!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400))),
                  ),
                )
              ],
            ),
            SizedBox(height: 33),
            Divider(
              height: 28,
              color: Color(0xffcbcbcb),
              thickness: 1.0,
            ),
            splitrow2('예상 금액', '12만원'),
            splitrow2('결제방식', '카넥티드 결제'),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [reserving(context)],
            ))
          ],
        ),
      ),
    );
  }
}

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}

Container reserving(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 40,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Oilend()));
      },
      child: text('예약하기', 14.0, FontWeight.w500, Colors.white),
      style: ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
    ),
  );
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
