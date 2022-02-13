import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proj4dart/proj4dart.dart';

class LocationSearchPage2 extends StatefulWidget {
  final String rn;
  final String addr;
  final String admCd;
  final String rnMgtSn;
  final String udrtYn;
  final String buldMnnm;
  final String buldSlno;

  const LocationSearchPage2(
      {Key? key,
      required this.addr,
      required this.rn,
      required this.admCd,
      required this.rnMgtSn,
      required this.udrtYn,
      required this.buldMnnm,
      required this.buldSlno})
      : super(key: key);

  @override
  State<LocationSearchPage2> createState() => _LocationSearchPage2State();
}

class _LocationSearchPage2State extends State<LocationSearchPage2> {
  var mapCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
              color: Colors.black),
          title: Text('상세주소 설정',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(25, 57, 25, 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('좀 더 자세한 주소를\n입력해주세요:)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 9),
              Container(
                padding: EdgeInsets.fromLTRB(8, 12, 0, 12),
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.rn,
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
                                  '도로명',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontFamily: 'NotoSansKR',
                                  ),
                                ),
                                color: Color(0xffe8eaee)),
                            SizedBox(width: 3),
                            Text(
                              widget.addr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'NotoSansKR',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 26,
                      margin: EdgeInsets.only(
                        left: 2,
                        right: 10,
                      ),
                      padding: EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        onSubmitted: (text) => {
                          print(text),
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'NotoSansKR'),
                        decoration: InputDecoration(
                          hintText: '주차장 이름, 위치 설명',
                          hintStyle: TextStyle(
                            color: Color(0xffa9a9a9),
                            fontSize: 10,
                            fontFamily: 'NotoSansKR',
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          mapCheck = !mapCheck;
                        });
                        getCoordinates(
                            widget.rn,
                            widget.addr,
                            widget.admCd,
                            widget.rnMgtSn,
                            widget.udrtYn,
                            widget.buldMnnm,
                            widget.buldSlno);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 6),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.map_outlined, size: 12),
                              SizedBox(width: 2),
                              Text(
                                '지도에서 위치 확인',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'NotoSansKR',
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
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
              ),
              mapCheck
                  ? Flexible(
                      child: Container(
                      color: Colors.blue,
                    ))
                  : SizedBox()
            ])));
  }
}

//좌표 통신
Future<Coordinates> getCoordinates(String rn, String addr, String admCd,
    String rnMgtSn, String udrtYn, String buldMnnm, String buldSlno) async {
  final response = await http.post(
      Uri.parse(
          'https://www.juso.go.kr/addrlink/addrCoordApi.do?admCd=${admCd}&rnMgtSn=${rnMgtSn}&udrtYn=${udrtYn}&buldMnnm=${buldMnnm}&buldSlno=${buldSlno}&confmKey=devU01TX0FVVEgyMDIyMDIxNDA1MDA0NjExMjIzODY=&resultType=json'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

  late Coordinates coordinates;

  if (response.statusCode == 200) {
    var def = Projection.get('EPSG:4236');

    print(jsonDecode(response.body)['results']['juso']);
    coordinates = Coordinates.fromJson(jsonDecode(response.body)['results']['juso'][0]);
    print('X: ${coordinates.coordX}, Y: ${coordinates.coordY}');
    return coordinates;
  } else {
    throw Exception("좌표 검색에 실패했습니다");
  }
}

class Coordinates {
  final String coordX;
  final String coordY;

  Coordinates({required this.coordX, required this.coordY});

  factory Coordinates.fromJson(Map<dynamic, dynamic> json) {
    return Coordinates(coordX: json['entX'], coordY: json['entY']);
  }
}
