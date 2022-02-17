import 'package:flutter/material.dart';

class Oilconfirm extends StatefulWidget {
  const Oilconfirm({Key? key}) : super(key: key);

  @override
  State<Oilconfirm> createState() => _OilconfirmState();
}

class _OilconfirmState extends State<Oilconfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('주유 서비스 예약', 16.0, FontWeight.w500, Colors.black),
        leading: IconButton(
          onPressed: () {},
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
            text('SK행복충전 신우에너지 풍동충전소', 16.0, FontWeight.bold, Colors.black),
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
            splitrow('유종', '휘발유'),
            Divider(
              height: 47,
              color: Color(0xffcbcbcb),
              thickness: 1.0,
            ),
            SizedBox(height: 13.5),
            splitrow2('예상 금액', '12만원'),
            splitrow2('결제방식', '카넥티드 결제'),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [reserving()],
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

Container reserving() {
  return Container(
    width: double.infinity,
    height: 40,
    child: ElevatedButton(
      onPressed: () {},
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
