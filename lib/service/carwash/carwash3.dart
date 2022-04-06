import 'package:flutter/material.dart';
import 'package:mosigg/service/carwash/carwash4.dart';
import 'package:http/http.dart' as http;

class Washconfirm extends StatefulWidget {
  final String dateAndTime;
  final String carLocation;
  final String carDetailLocation;
  final String type;
  final String detail;
  final String payment;
  final String? price;

  const Washconfirm(
      {Key? key,
      required this.dateAndTime,
      required this.carLocation,
      required this.carDetailLocation,
      required this.type,
      required this.detail,
      required this.payment,
      this.price})
      : super(key: key);

  @override
  State<Washconfirm> createState() => _WashconfirmState();
}

class _WashconfirmState extends State<Washconfirm> {
  /*임시데이터*/
  String id = 'mouse0429'; //사용자 아이디
  String carNum = '12가1234'; //해당 차량
  int price = 15; //가격
  late var arr = widget.type.split(',');

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
            text('세차 서비스 예약 내역', 16.0, FontWeight.bold, Colors.black),
            SizedBox(height: 34.0),
            splitrow('차량번호', '12가 1234'),
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
            SizedBox(height: 10.0),
            splitrow('외부 세차', '${arr[0]}'),
            splitrow('내부 세차', '${arr[1]}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('추가 요청', 14.0, FontWeight.w500, Colors.black),
                Container(
                  width: 271,
                  child: Flexible(
                      child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        text: widget.detail,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400)),
                  )),
                )
              ],
            ),
            SizedBox(height: 33),
            Divider(
              height: 28,
              color: Color(0xffcbcbcb),
              thickness: 1.0,
            ),
            splitrow2('예상 금액', '10 만원'),
            splitrow2('결제방식', '${widget.payment}'),
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

Future<void> washRsrv(
    String id,
    String carNum,
    String dateAndTime,
    String carLocation,
    String carDetailLocation,
    String type,
    String payment,
    String detail,
    int price) async {
  final response = await http.get(Uri.parse(
      'http://ec2-18-208-168-144.compute-1.amazonaws.com:8080/wash_resrv/${id}/${carNum}/${dateAndTime}/${carLocation}/${carDetailLocation}/${type}/${payment}/${detail}'));
  if (response.statusCode == 200) {
    print('댕같이성공 ${response.body}');
  } else {
    print('개같이실패 ${response.statusCode}');
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
            MaterialPageRoute(builder: (BuildContext context) => Washend()));
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
