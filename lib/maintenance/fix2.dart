import 'package:flutter/material.dart';
import 'package:mosigg/maintenance/fix1.dart';

class Fixplus extends StatefulWidget {
  const Fixplus({Key? key}) : super(key: key);

  @override
  _FixplusState createState() => _FixplusState();
}

class _FixplusState extends State<Fixplus> {
  final isSelected = <bool>[false, false, false];
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
          title: text('정비 서비스 예약', 16.0, FontWeight.w500, Colors.black),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Fixstart()));
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
              text('검사 종류', 14.0, FontWeight.w400, Colors.black),
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
                            buttonIndex2 < isSelected.length;
                            buttonIndex2++) {
                          if (buttonIndex2 == index2) {
                            isSelected[buttonIndex2] = true;
                          } else {
                            isSelected[buttonIndex2] = false;
                          }
                        }
                      });
                    },
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '정기 검사',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '종합 검사',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 60.0) / 3,
                        child: Center(
                          child: Text(
                            '부분 검사',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                    isSelected: isSelected),
              ),
              SizedBox(height: 6),
              text('필요하신 검사 종류를 선택해주세요!', 10.0, FontWeight.w400,
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

Container kipgoing(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 40,
    child: ElevatedButton(
      onPressed: () {
        //  Navigator.push(
        // context,
        //  MaterialPageRoute(
        //      builder: (BuildContext context) => ()));
      },
      child: text('계속하기', 14.0, FontWeight.w500, Colors.white),
      style: ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
    ),
  );
}
