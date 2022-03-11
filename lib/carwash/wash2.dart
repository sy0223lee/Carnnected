import 'package:flutter/material.dart';

import 'package:mosigg/carwash/wash1.dart';
import 'package:mosigg/carwash/wash3.dart';

class Washsecond extends StatefulWidget {
  final String dateAndTime;
  final String carLocation;
  final String carDetailLocation;
  final String? type;
  final String? detail;
  final String payment;

  const Washsecond({
    Key? key,
    required this.dateAndTime,
    required this.carLocation,
    required this.carDetailLocation,
    this.type,
    this.detail,
    required this.payment,
  }) : super(key: key);

  @override
  _WashsecondState createState() => _WashsecondState();
}

class _WashsecondState extends State<Washsecond> {
  final isSelected = <bool>[false, false, false];
  final isSelected2 = <bool>[false, false];
  List<String> typeList = ['없음', '셀프 세차장 세차', '주차장 스팀 세차'];
  List<String> typeList2 = ['없음', '실내 클리닝'];
  String type1 = '';
  String type2 = '';
  TextEditingController plusRequest = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      builder: (BuildContext context) => Washstart()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25.0, 28.0, 25.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text('외부 세차', 14.0, FontWeight.w400, Colors.black),
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
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '없음',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '셀프 세차장 세차',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '주차장 스팀 세차',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                    isSelected: isSelected),
              ),
              SizedBox(height: 6),
              text('필요하신 외부 세차 종류를 선택해주세요!', 10.0, FontWeight.w400,
                  Color(0xff9d9d9d)),
              SizedBox(height: 19.0),
              text('내부 세차', 14.0, FontWeight.w400, Colors.black),
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
                          } else {
                            isSelected2[buttonIndex2] = false;
                          }
                        }
                      });
                    },
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '없음',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '실내 클리닝',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                    isSelected: isSelected2),
              ),
              SizedBox(height: 6),
              text('필요하신 내부 세차 종류를 선택해주세요!', 10.0, FontWeight.w400,
                  Color(0xff9d9d9d)),
              SizedBox(height: 19.0),
              text('추가 요청 사항', 14.0, FontWeight.w400, Colors.black),
              SizedBox(height: 6.0),
              TextField(
                maxLength: 200,
                controller: plusRequest,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 10.0, color: Colors.black),
                decoration: InputDecoration(
                  counterText: '',
                  helperText: '추가 요청 사항을 200자 이내로 입력해주세요!',
                  helperStyle:
                      TextStyle(fontSize: 10.0, color: Color(0xff9d9d9d)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Washconfirm(
                                    dateAndTime: widget.dateAndTime,
                                    carLocation: widget.carLocation,
                                    carDetailLocation: widget.carDetailLocation,
                                    type: type1 + ',' + type2,
                                    payment: widget.payment,
                                    detail: plusRequest.text)));
                      },
                      child: text('계속하기', 14.0, FontWeight.w500, Colors.white),
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
                    ),
                  )
                ],
              ))
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
