import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mosigg/maintenance/fix4.dart';
import 'package:mosigg/signup/signup3.dart';

import 'dart:convert';
import 'dart:ui' as ui;
import 'package:proj4dart/proj4dart.dart';

class FixRsrv extends StatefulWidget {
  final String dateAndTime;
  final String carLocation;
  final String carDetailLocation;
  final String detail;
  final String payment;
  final String type;
  final LatLng carCoord;

  const FixRsrv(
      {Key? key,
      required this.dateAndTime,
      required this.carLocation,
      required this.carDetailLocation,
      required this.detail,
      required this.payment,
      required this.type,
      required this.carCoord})
      : super(key: key);
  @override
  _FixRsrvState createState() => _FixRsrvState();
}

class _FixRsrvState extends State<FixRsrv> {
  List<Marker> _markers = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  late CameraPosition markerCam;
  late List fixCoordData;

  Completer<GoogleMapController> _controller = Completer();

  late String fixStationName;
  late String fixStationaddress;

  void initState() {
    super.initState();
    print(widget.carCoord.latitude);
    markerCam = CameraPosition(target: widget.carCoord, zoom: 14);
    getFixinfo(widget.carCoord);
    makeMarker();
  }

  void makeMarker() async {
    //fixCoordData = await getFixinfo(widget.carCoord);
    for (var i = 0; i < fixCoordData.length; i++) {
      _addMarker(i, fixCoordData[i].lat, fixCoordData[i].long,
          fixCoordData[i].name, fixCoordData[i].address);
    }
  }

  void _addMarker(id, x, y, name, address) async {
    final MarkerId markerId = MarkerId(id.toString());
    Uint8List markerIcon = await getBytesFromCanvas(150, 80);

    Marker marker = new Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        draggable: false,
        infoWindow: InfoWindow(title: "여기로 예약"),
        onTap: () {
          _infoDialog(context, name, address);
          setState(() {
            fixStationName = name;
            fixStationaddress = address;
          });
        },
        position: LatLng(x, y));

    setState(() {
      _markers.add(marker);
    });
  }

  Future<Uint8List> getBytesFromCanvas(int width, int height) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Color(0xff001a5d);
    final Radius radius = Radius.circular(20.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: name,
      style: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: text('정비 서비스 예약', 16.0, FontWeight.w500, Colors.black),
          toolbarHeight: 56.0,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            // iconSize: 16.0,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(_markers),
        initialCameraPosition: markerCam,
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(55.0, 0.0, 25.0, 0.0),
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        child: TextButton(
          child: text("계속하기", 14.0, FontWeight.w500, Color(0xffffffff)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Fixconfirm(
                          dateAndTime: widget.dateAndTime,
                          carLocation: widget.carLocation,
                          carDetailLocation: widget.carDetailLocation,
                          detail: widget.detail,
                          type: widget.type,
                          payment: widget.payment,
                          destName: fixStationName,
                          destaddr: fixStationaddress,
                        )));
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff001A5D),
          ),
        ),
      ),
    );
  }

  void _infoDialog(BuildContext context, String name, String address) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SimpleDialog(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 12.0)),
                        text(name, 16.0, FontWeight.bold, Colors.black),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 12.0)),
                        Container(
                          width: 24.0,
                          child: Text(
                            "주소",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 8.0,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(color: Color(0xffe8eaee)),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        text(address, 10.0, FontWeight.w500, Colors.black),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}

Future<void> getFixinfo(LatLng addr) async {
  Map<String, String> headers = {
    'X-NCP-APIGW-API-KEY-ID': '8eluft3bx7',
    'X-NCP-APIGW-API-KEY': 'Zt0hrdTDUsti4s8cPOlpz26QBfz4Rm6lFUHGBGfG'
  };

  late List<FIX> fixList = [];

  final responseCrawling = await http.get(Uri.parse(
      'http://10.0.2.2:8080/map/카센터/${addr.latitude}/${addr.longitude}'));

  if(responseCrawling.statusCode == 200) {
    List<dynamic> json = jsonDecode(responseCrawling.body);
      for (var i = 0; i < json.length; i++) {
        print(json[i]);
      //   final responseCoord = await http.get(Uri.parse(
      //     'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${json[i].}'),
      // headers: headers);
      }
  }


  // final responseCoord = await http.get(
  //     Uri.parse(
  //         'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${query}'),
  //     headers: headers);

  //   /*테스트 코드*/
  //   //katecX = 314681.8;
  //   // katecY = 544837.0;
  //   print('Fix3 ${long}, ${lat}');

  //   final responseFix = await http
  //       .get(Uri.parse('http://10.0.2.2:8080/map/카센터/${long}/${lat}'));
  //   if (responseFix.statusCode == 200) {
  //     late List<FIX> fixList = [];

  //     List<dynamic> json = jsonDecode(responseFix.body)['RESULT']['FIX1'];

  //     for (var i = 0; i < json.length; i++) {
  //       final responseNewCoord = await http.get(
  //           Uri.parse(
  //               'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${json[i].address}'),
  //           headers: headers);
  //       if (responseNewCoord.statusCode == 200) {
  //         var long2 = double.parse(
  //             jsonDecode(responseNewCoord.body)['addresses'][0]['x']);
  //         var lat2 = double.parse(
  //             jsonDecode(responseNewCoord.body)['addresses'][0]['y']);

  //         fixList.add(FIX(
  //             type: json[i].type,
  //             name: json[i].name,
  //             address: json[i].address,
  //             long2: long2,
  //             lat2: lat2));
  //       }
  //     }
  //     return fixList;
  //   } else {
  //     throw Exception('Failed to load fix data');
  //   }
  // } else {
  //   throw Exception('Failed to load coordinates');
  // }

  //incoming
  // if (responseCoord.statusCode == 200) {
  //   var long =
  //       double.parse(jsonDecode(responseCoord.body)['addresses'][0]['x']);
  //   var lat = double.parse(jsonDecode(responseCoord.body)['addresses'][0]['y']);
  //   var point = Point(x: long, y: lat);



  //   final responseFix = await http
  //       .get(Uri.parse('http://10.0.2.2:8080/map/카센터/${katecX}/${katecY}'));
  //   if (responseFix.statusCode == 200) {
  //     late List<FIX> fixList = [];
  //     List<dynamic> json = jsonDecode(responseFix.body);
  //     for (var i = 0; i < json.length; i++) {
  //       fixList.add(FIX.fromJson(json[i]));
  //     }
  //     return fixList;
  //   } else {
  //     throw Exception('Failed to load fix data');
  //   }
  // } else {
  //   throw Exception('Failed to load coordinates');
  // }
}

///////////////////////////// 내가 원하는 FIX class /////////////////////////////
class FIX {
  final String type;
  final String name;
  final String address;
  final double long2;
  final double lat2;

  FIX({
    required this.type,
    required this.name,
    required this.address,
    required this.long2,
    required this.lat2,
  });

  factory FIX.fromJson(Map<dynamic, dynamic> json) {
    return FIX(
      type: json['type'],
      name: json['name'],
      address: json['address'],
      long2: json['long'],
      lat2: json['lat2'],
    );
  }
}

class FIX1 {
  final String type;
  final String name;
  final String address;

  FIX1({
    required this.type,
    required this.name,
    required this.address,
  });
}

/*좌표 변환 함수*/
Point transCoord(String type, Point point) {
  late Point resultPoint;

  var grs80 = Projection.get('grs80') ??
      Projection.add('grs80',
          '+proj=tmerc +lat_0=38 +lon_0=128 +k=0.9999 +x_0=400000 +y_0=600000 +ellps=bessel +units=m +no_defs +towgs84=-115.80,474.99,674.11,1.16,-2.31,-1.63,6.43');
  var wgs84 = Projection.get('wgs84') ??
      Projection.add('wgs84',
          '+title=WGS 84 (long/lat) +proj=longlat +ellps=WGS84 +datum=WGS84 +units=degrees');

  if (type == '위도') {
    resultPoint = wgs84.transform(grs80, point);
  } else if (type == '카텍') {
    resultPoint = grs80.transform(wgs84, point);
  } else {
    resultPoint = Point(x: 0, y: 0);
  }

  return resultPoint;
}
