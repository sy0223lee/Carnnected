import 'package:flutter/material.dart';
import 'package:mosigg/replacement/repselect2.dart';
import 'package:mosigg/replacement/change5.dart';

int itemNum = 0;
int totalPrice = 0;

class Changeconfirm extends StatefulWidget {
  final String dateAndTime;
  final String carLocation;
  final String carDetailLocation;
  final String payment;
  final String maintenance;
  final String plusRequest;

  const Changeconfirm(
    {Key? key,
    required this.dateAndTime,
    required this.carLocation,
    required this.carDetailLocation,
    required this.payment,
    required this.maintenance,
    required this.plusRequest}) 
    : super(key: key);

  @override
  State<Changeconfirm> createState() => _ChangeconfirmState();
}

class _ChangeconfirmState extends State<Changeconfirm> {
  @override
  void initState() {
    for(var i = 0; i < optionItem.length; i++){
      itemNum++;
      for(var j = 0; j < optionPrice.length; j++){
        totalPrice += int.parse(optionPrice[j]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('교체 서비스 예약', 16.0, FontWeight.w500, Colors.black),
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
            text('기본 정보', 16.0, FontWeight.bold, Colors.black),
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
            splitrow('정비 옵션', '${widget.maintenance}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('추가 요청', 14.0, FontWeight.w500, Colors.black),
                Container(
                  width: 271,
                  child: Flexible(
                    child: Text.rich(TextSpan(
                        text: '${(int.parse(widget.plusRequest)).toString()}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400))),
                  ),
                )
              ],
            ),
            Divider(
              height: 28,
              color: Color(0xffcbcbcb),
              thickness: 1.0,
            ),
            text('교체 물품', 16.0, FontWeight.bold, Colors.black),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                  itemCount: itemNum, //선택한 개수만큼
                  itemBuilder: (context, index) {
                    return splitrow(optionItem[index], optionPrice[index]);
                  }),
            ),
            Divider(
              height: 28,
              color: Color(0xffcbcbcb),
              thickness: 1.0,
            ),
            splitrow2('예상 금액', '$totalPrice 원'),
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
            MaterialPageRoute(builder: (BuildContext context) => Changeend()));
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