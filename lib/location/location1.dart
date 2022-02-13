import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class LocationSearchPage1 extends StatefulWidget {
  const LocationSearchPage1({Key? key}) : super(key: key);

  @override
  _LocationSearchPage1State createState() => _LocationSearchPage1State();
}

class _LocationSearchPage1State extends State<LocationSearchPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new),
              color: Colors.black),
          title: Text('주소 설정',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.fromLTRB(25, 57, 25, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('지번, 도로명, 건물명으로\n검색해주세요:)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 26),
                Container(
                    height: 25,
                    child: TextField(
                      // controller: inputpw,
                      decoration: InputDecoration(
                        prefixIcon:
                            Container(width: 20, child: Icon(Icons.search)),
                        iconColor: Color(0xff9a9a9a),
                        prefixIconConstraints:
                            BoxConstraints(maxHeight: 24, maxWidth: 20),
                        hintText: '예) 광운로 12',
                        hintStyle: TextStyle(
                          color: Color(0xff9a9a9a),
                          fontSize: 12,
                          fontFamily: 'NotoSansKR',
                        ),
                        // prefixStyle: textStyle(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xffcbcbcb))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xffcbcbcb))),
                      ),
                      keyboardType: TextInputType.text,
                    )),
                SizedBox(height: 6.5),
                Row(children: [
                  Icon(FeatherIcons.crosshair, size: 18),
                  SizedBox(width: 6.5),
                  Text(
                    '현재 위치로 검색하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'NotoSansKR',
                    ),
                  )
                ]),
                SizedBox(height: 44),
                Text(
                  '즐겨찾는 주소',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '경기 고양시 일산동구 숲속마을1로 116 ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'NotoSansKR',
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                                  '상세주소',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontFamily: 'NotoSansKR',
                                  ),
                                ),
                                color: Color(0xffe8eaee)),
                            SizedBox(width: 3),
                            Text(
                              ' 숲속마을 7단지아파트 707동 1705호',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'NotoSansKR',
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ));
        }));
  }
}
