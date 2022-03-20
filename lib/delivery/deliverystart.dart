import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosigg/location/location1.dart';
import 'package:mosigg/delivery/deliverysecond.dart';
import 'package:http/http.dart' as http;

class Deliverystart extends StatefulWidget {
  const Deliverystart({Key? key}) : super(key: key);

  @override
  State<Deliverystart> createState() => _DeliverystartState();
}

const MaterialColor _buttonTextColor = MaterialColor(0xFF001A5D, <int, Color>{
  50: Color(0xff001a5d),
  100: Color(0xff001a5d),
  200: Color(0xff001a5d),
  300: Color(0xff001a5d),
  400: Color(0xff001a5d),
  500: Color(0xff001a5d),
  600: Color(0xff001a5d),
  700: Color(0xff001a5d),
  800: Color(0xff001a5d),
  900: Color(0xff001a5d),
});

class _DeliverystartState extends State<Deliverystart> {
  final isSelected = <bool>[false, false, false, false, false];
  final isSelected2 = <bool>[false, false, false, false];
  List<String> paymentList = ['신용카드', '계좌이체', '휴대폰결제', '카카오페이'];
  String? _selectedTime = "";
  DateTime? _selectedDate;

  String? fuel;
  String? payment;
  String? carLocation;
  String? carDetailLocation;
  String? desLocation;
  String? desDetailLocation;
  late LatLng carCoord;
  late LatLng desCoord;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('딜리버리 서비스 예약', 16.0, FontWeight.w500, Colors.black),
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
        padding: EdgeInsets.fromLTRB(25.0, 28.0, 25.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('예약 날짜', 14.0, FontWeight.w400, Colors.black),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectedDate?.year != null
                    ? text(
                        '${_selectedDate?.year}/${_selectedDate?.month}/${_selectedDate?.day}',
                        12.0,
                        FontWeight.w400,
                        Colors.black)
                    : text("", 12.0, FontWeight.w400, Colors.black),
                IconButton(
                    padding: EdgeInsets.only(left: 2),
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Future<DateTime?> selectedDate = showDatePicker(
                          builder: (BuildContext context, child) {
                            return Theme(
                                data:
                                    ThemeData(primarySwatch: _buttonTextColor),
                                child: child!);
                          },
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030));
                      selectedDate.then((dateTime) {
                        setState(() {
                          _selectedDate = dateTime;
                        });
                      });
                    },
                    icon: Icon(
                      Icons.date_range,
                      color: Color(0xff9c9c9c),
                      size: 20,
                    ))
              ],
            ),
            Divider(
              height: 10.0,
              color: Color(0xffcbcbcb),
              thickness: 2.0,
            ),
            text('달력 버튼을 눌러 원하시는 예약 날짜를 입력하세요!', 10.0, FontWeight.w400, Color(0xff9d9d9d)),
            SizedBox(height: 19),
            text('예약 시간', 14.0, FontWeight.w400, Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text('$_selectedTime', 12.0, FontWeight.w400, Colors.black),
                IconButton(
                    padding: EdgeInsets.only(left: 2),
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Future<TimeOfDay?> selectedTime = showTimePicker(
                          builder: (BuildContext context, child) {
                            return Theme(
                                data:
                                    ThemeData(primarySwatch: _buttonTextColor),
                                child: child!);
                          },
                          context: context,
                          initialTime: TimeOfDay.now());
                      selectedTime.then((timeOfDay) {
                        setState(() {
                          _selectedTime =
                              timeOfDay.toString().substring(10, 15);
                        });
                      });
                    },
                    icon: Icon(Icons.watch_later_outlined,
                        color: Color(0xff9c9c9c), size: 20))
              ],
            ),
            Divider(
              height: 10.0,
              color: Color(0xffcbcbcb),
              thickness: 2.0,
            ),
            text('시계 버튼을 눌러 원하시는 예약 시간을 입력하세요!', 10.0, FontWeight.w400, Color(0xff9d9d9d)),
            SizedBox(height: 19),
            text('차량 위치', 14.0, FontWeight.w400, Colors.black),
            SizedBox(height: 6),
            InkWell(
              onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LocationSearchPage1()));
                if (result is Addr) {
                  setState(() {
                    carLocation = result.addr;
                    carDetailLocation = result.detailAddr;
                  });
                }
              },
              child: carLocation == null
                  ? Container(height: 17)
                  : text(carLocation, 12.0, FontWeight.w400, Colors.black),
            ),
            Divider(
              height: 10.0,
              color: Color(0xffcbcbcb),
              thickness: 2.0,
            ),
            text('차량 위치를 입력하세요!', 10.0, FontWeight.w400, Color(0xff9d9d9d)),
            SizedBox(height: 19),
            text('배달 위치', 14.0, FontWeight.w400, Colors.black),
            SizedBox(height: 6),
            InkWell(
              onTap: () async {
                final result2 = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LocationSearchPage1()));
                if (result2 is Addr) {
                  setState(() {
                    desLocation = result2.addr;
                    desDetailLocation = result2.detailAddr;
                  });
                }
              },
              child: carLocation == null
                  ? Container(height: 17)
                  : text(carLocation, 12.0, FontWeight.w400, Colors.black),
            ),
            Divider(
              height: 10.0,
              color: Color(0xffcbcbcb),
              thickness: 2.0,
            ),
            SizedBox(height: 6),
            text('원하시는 배달 위치를 입력해주세요!', 10.0, FontWeight.w400, Color(0xff9d9d9d)),
            SizedBox(height: 19.0),
            text('결제수단', 14.0, FontWeight.w400, Colors.black),
            SizedBox(height: 6),
            Container(
              height: 24,
              child: ToggleButtons(
                  color: Colors.black,
                  selectedColor: Colors.white,
                  selectedBorderColor: Color(0xff001a5d),
                  fillColor: Color(0xff001a5d),
                  onPressed: (int index2) {
                    setState(() {
                      for (int buttonIndex2 = 0;
                          buttonIndex2 < isSelected2.length;
                          buttonIndex2++) {
                        if (buttonIndex2 == index2) {
                          isSelected2[buttonIndex2] = true;
                          payment = paymentList[buttonIndex2];
                        } else {
                          isSelected2[buttonIndex2] = false;
                        }
                      }
                    });
                  },
                  children: [
                    toggleItem(context, paymentList[0], 5),
                    toggleItem(context, paymentList[1], 5),
                    toggleItem(context, paymentList[2], 5),
                    toggleItem(context, paymentList[3], 5),
                  ],
                  isSelected: isSelected2),
            ),
            SizedBox(height: 6),
            text('이용하실 결제 수단을 선택하세요!', 10.0, FontWeight.w400, Color(0xff9d9d9d)),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_selectedDate != null &&
                          _selectedTime != null &&
                          carLocation != null &&
                          carDetailLocation != null &&
                          desLocation != null &&
                          desDetailLocation != null &&
                          payment != null) {
                        String dateAndTime = _selectedDate.toString().substring(0, 10) +  ' ' + _selectedTime! + ':00';
                        LatLng carCoord = await getCarCoord(carLocation!);
                        LatLng desCoord = await getCarCoord(desLocation!);

                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) => Deliverysecond(
                              dateAndTime: dateAndTime,
                              carLocation: carLocation!,
                              carDetailLocation: carDetailLocation!,
                              desLocation: desLocation!,
                              desDetailLocation: desDetailLocation!,
                              payment: payment!,
                              carCoord: carCoord,
                              desCoord: desCoord
                            )));
                      }
                    },
                    child: text('계속하기', 14.0, FontWeight.w500, Colors.white),
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

Container toggleItem(context, text, itemNum) {
  return Container(
    width: (MediaQuery.of(context).size.width - 60.0) / itemNum,
    child: Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
      ),
    ),
  );
}

Future<LatLng> getCarCoord(String carLocation) async {
  Map<String, String> headers = {
    'X-NCP-APIGW-API-KEY-ID': '8eluft3bx7',
    'X-NCP-APIGW-API-KEY': 'Zt0hrdTDUsti4s8cPOlpz26QBfz4Rm6lFUHGBGfG'
  };

  late LatLng carCoord;

  final response = await http.get(
      Uri.parse(
          'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${carLocation}'),
      headers: headers);

  if (response.statusCode == 200) {
    carCoord = LatLng(
        double.parse(jsonDecode(response.body)['addresses'][0]['y']),
        double.parse(jsonDecode(response.body)['addresses'][0]['x']));
    return carCoord;
  } else {
    throw Exception('Failed to get coordinates of car');
  }
}
