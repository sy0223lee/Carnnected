import 'package:flutter/material.dart';

class Oilstart extends StatefulWidget {
  const Oilstart({Key? key}) : super(key: key);

  @override
  State<Oilstart> createState() => _OilstartState();
}

class _OilstartState extends State<Oilstart> {
  final isSelected = <bool>[false, false, false, false, false];
  final isSelected2 = <bool>[false, false, false, false];
  String _selectedTime = "";
  DateTime? _selectedDate;

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
        padding: EdgeInsets.fromLTRB(25.0, 28.0, 25.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('예약 날짜', 14.0, FontWeight.w400, Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_selectedDate?.year != null)
                  text(
                      '${_selectedDate?.year}/${_selectedDate?.month}/${_selectedDate?.day}',
                      12.0,
                      FontWeight.w400,
                      Colors.black),
                if (_selectedDate?.year == null)
                  text("0000/00/00", 12.0, FontWeight.w400, Colors.black),
                IconButton(
                    onPressed: () {
                      Future<DateTime?> selectedDate = showDatePicker(
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
                    ))
              ],
            ),
            Divider(
              height: 0.0,
              color: Color(0xffcbcbcb),
              thickness: 2.0,
            ),
            text('달력 버튼을 눌러 원하시는 예약 날짜를 입력하세요!', 10.0, FontWeight.w400,
                Color(0xff9d9d9d)),
            SizedBox(height: 19),
            text('예약 시간', 14.0, FontWeight.w400, Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text('$_selectedTime', 12.0, FontWeight.w400, Colors.black),
                IconButton(
                    onPressed: () {
                      Future<TimeOfDay?> selectedTime = showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      selectedTime.then((timeOfDay) {
                        setState(() {
                          _selectedTime =
                              '${timeOfDay?.hour}:${timeOfDay?.minute}';
                        });
                      });
                    },
                    icon: Icon(
                      Icons.watch_later_outlined,
                      color: Color(0xff9c9c9c),
                    ))
              ],
            ),
            Divider(
              height: 0.0,
              color: Color(0xffcbcbcb),
              thickness: 2.0,
            ),
            text('시계 버튼을 눌러 원하시는 예약 시간을 입력하세요!', 10.0, FontWeight.w400,
                Color(0xff9d9d9d)),
            SizedBox(height: 19),
            text('차량위치', 14.0, FontWeight.w400, Colors.black),
            SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                //Navigator.push(context,
                //MaterialPageRoute(builder: (context) => Oilprice()));
              },
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text('경기', 12.0, FontWeight.w400, Colors.black),
                    SizedBox(height: 6.0),
                    Divider(
                      height: 0.0,
                      color: Color(0xffcbcbcb),
                      thickness: 2.0,
                    ),
                    SizedBox(height: 5.0),
                    text('차량 위치를 입력하세요!', 10.0, FontWeight.w400,
                        Color(0xff9d9d9d)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 19),
            text('연료', 14.0, FontWeight.w400, Colors.black),
            SizedBox(height: 6),
            Container(
              height: 24,
              child: ToggleButtons(
                  color: Colors.black,
                  selectedColor: Colors.white,
                  selectedBorderColor: Color(0xff001a5d),
                  fillColor: Color(0xff001a5d),
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text(
                          '휘발유',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text('경유',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400)),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text('LPG',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400)),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text('고급휘발유',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400)),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text('전기',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                  isSelected: isSelected),
            ),
            SizedBox(height: 8.5),
            text('차량에 맞는 연료를 선택하세요!', 10.0, FontWeight.w400, Color(0xff9d9d9d)),
            SizedBox(height: 19.0),
            text('결제수단', 14.0, FontWeight.w400, Colors.black),
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
                        } else {
                          isSelected2[buttonIndex2] = false;
                        }
                      }
                    });
                  },
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text(
                          '신용카드',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text(
                          '계좌이체',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text(
                          '휴대폰결제',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 60.0) / 5,
                      child: Center(
                        child: Text(
                          '카카오페이',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                  isSelected: isSelected2),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [kipgoing()],
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

Container kipgoing() {
  return Container(
    width: double.infinity,
    height: 40,
    child: ElevatedButton(
      onPressed: () {},
      child: text('계속하기', 14.0, FontWeight.w500, Colors.white),
      style: ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
    ),
  );
}
