import 'package:flutter/material.dart';
import 'package:mosigg/drive/driveend.dart';
import 'package:http/http.dart' as http;

class Driveconfirm extends StatefulWidget {
  final String dateAndTime;
  final String carLocation;
  final String carDetailLocation;
  final String desLocation;
  final String desDetailLocation;
  final String payment;
  final String price;

  const Driveconfirm(
      {Key? key,
      required this.dateAndTime,
      required this.carLocation,
      required this.carDetailLocation,
      required this.desLocation,
      required this.desDetailLocation,
      required this.payment,
      required this.price})
      : super(key: key);

  @override
  State<Driveconfirm> createState() => _DriveconfirmState();
}

class _DriveconfirmState extends State<Driveconfirm> {
  /*임시데이터*/
  String id = 'mouse0429@naver.com'; //사용자 아이디
  String carNum = '102허2152'; //해당 차량

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('대리운전 서비스 예약', 16.0, FontWeight.w500, Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
            text('대리운전 서비스 예약이 완료되었습니다', 16.0, FontWeight.bold, Colors.black),
            SizedBox(height: 34.0),
            splitrow('차량번호', carNum),
            SizedBox(height: 20.0),
            splitrow('예약일시',
                '${widget.dateAndTime.substring(0, 4)}년 ${widget.dateAndTime.substring(5, 7)}월 ${widget.dateAndTime.substring(8, 10)}일 ${widget.dateAndTime.substring(11, 13)}:${widget.dateAndTime.substring(14, 16)}'),
            splitrow('차량위치', '${widget.carLocation}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                text('${widget.carDetailLocation}', 14.0, FontWeight.w400,
                    Colors.black)
              ],
            ),
            splitrow('목적지', '${widget.desLocation}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                text('${widget.desDetailLocation}', 14.0, FontWeight.w400,
                    Colors.black)
              ],
            ),
            Divider(
              height: 47,
              color: Color(0xffcbcbcb),
              thickness: 1.0,
            ),
            SizedBox(height: 13.5),
            splitrow2(
                '예상 금액', '${(int.parse(widget.price) + 2).toString()} 만원'),
            splitrow2('결제방식', '${widget.payment}'),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Driveend()));
                    },
                    child: text('예약하기', 14.0, FontWeight.w500, Colors.white),
                    style: ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
                  ),
                ),
              ],
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
