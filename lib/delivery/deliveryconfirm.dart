import 'package:flutter/material.dart';
import 'package:mosigg/oiling/oilend.dart';
import 'package:http/http.dart' as http;

class Deliveryconfirm extends StatefulWidget {
  final String dateAndTime;
  final String carLocation;
  final String carDetailLocation;
  final String fuel;
  final String payment;
  final String gasStationName;
  final String price;

  const Deliveryconfirm(
      {Key? key,
      required this.dateAndTime,
      required this.carLocation,
      required this.carDetailLocation,
      required this.fuel,
      required this.payment,
      required this.gasStationName,
      required this.price})
      : super(key: key);

  @override
  State<Deliveryconfirm> createState() => _DeliveryconfirmState();
}

class _DeliveryconfirmState extends State<Deliveryconfirm> {
  /*임시데이터*/
  String id = 'mouse0429'; //사용자 아이디
  String carNum = '12가1234'; //해당 차량

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('주유 서비스 예약', 16.0, FontWeight.w500, Colors.black),
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
            text(widget.gasStationName, 16.0, FontWeight.bold, Colors.black),
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
            splitrow('유종', '${widget.fuel}'),
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
                      gasRsv(
                          id,
                          carNum,
                          widget.dateAndTime,
                          widget.carLocation,
                          widget.carDetailLocation,
                          widget.fuel,
                          widget.payment,
                          widget.gasStationName,
                          int.parse(widget.price));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Oilend()));
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

Future<void> gasRsv(
    String id,
    String carNum,
    String dateAndTime,
    String carLocation,
    String carDetailLocation,
    String fuel,
    String payment,
    String gasStationName,
    int price) async {
  String amount = (price * 10000).toString();
  String exPrice = ((price + 2) * 10000).toString();
  final response = await http.get(Uri.parse(
      'http://ec2-18-208-168-144.compute-1.amazonaws.com:8080/gas_resrv/${id}/${carNum}/${dateAndTime}/${carLocation}/${carDetailLocation}/${fuel}/${gasStationName}/${amount}/${exPrice}/${payment}'));
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
