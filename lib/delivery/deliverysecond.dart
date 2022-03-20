import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:proj4dart/proj4dart.dart';

class Deliverysecond extends StatefulWidget {
  final String dateAndTime;
  final String carLocation;
  final String carDetailLocation;
  final String desLocation;
  final String desDetailLocation;
  final String payment;
  final LatLng carCoord;
  final LatLng desCoord;

  const Deliverysecond(
      {Key? key,
      required this.dateAndTime,
      required this.carLocation,
      required this.carDetailLocation,
      required this.desLocation,
      required this.desDetailLocation,
      required this.payment,
      required this.carCoord,
      required this.desCoord})
      : super(key: key);
  @override
  _DeliverysecondState createState() => _DeliverysecondState();
}

class _DeliverysecondState extends State<Deliverysecond> {
  List<Marker> _markers = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  late CameraPosition markerCam;
  late List gasCoordData;

  Completer<GoogleMapController> _controller = Completer();

  late String gasStationName;

  void initState() {
    super.initState();
    print(widget.carCoord.latitude);
    markerCam = CameraPosition(target: widget.carCoord, zoom: 14);
    makeMarker();
  }

  void makeMarker() async {
    gasCoordData = await getGasinfo(widget.carLocation);
    for (var i = 0; i < gasCoordData.length; i++) {
      _addMarker(i, gasCoordData[i].lat, gasCoordData[i].long, gasCoordData[i].name, gasCoordData[i].price);
    }
  }

  void _addMarker(id, x, y, name, price) async {
    final MarkerId markerId = MarkerId(id.toString());
    Uint8List markerIcon = await getBytesFromCanvas(150, 80, price);

    Marker marker = new Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        draggable: false,
        onTap: () {
          setState(() {
            gasStationName = name;
          });
        },
        position: LatLng(x, y));

    setState(() {
      _markers.add(marker);
    });
  }

  Future<Uint8List> getBytesFromCanvas(int width, int height, int price) async {
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
      text: price.toString(),
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
          title: text('딜리버리 서비스 예약', 16.0, FontWeight.w500, Colors.black),
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
            // 팝업,,
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff001A5D),
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

Future<List> getGasinfo(String query) async {
  Map<String, String> headers = {
    'X-NCP-APIGW-API-KEY-ID': '8eluft3bx7',
    'X-NCP-APIGW-API-KEY': 'Zt0hrdTDUsti4s8cPOlpz26QBfz4Rm6lFUHGBGfG'
  };

  late double katecX;
  late double katecY;

  final responseCoord = await http.get(
      Uri.parse(
          'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${query}'),
      headers: headers);

  if (responseCoord.statusCode == 200) {
    var long =
        double.parse(jsonDecode(responseCoord.body)['addresses'][0]['x']);
    var lat = double.parse(jsonDecode(responseCoord.body)['addresses'][0]['y']);
    var point = Point(x: long, y: lat);

    var katecPoint = transCoord('위도', point);

    katecX = katecPoint.x;
    katecY = katecPoint.y;

    /*테스트 코드*/
    // katecX = 314681.8;
    // katecY = 544837.0;
    print('주유2 ${katecX}, ${katecY}');

    final responseGas = await http.get(Uri.parse(
        'http://www.opinet.co.kr/api/aroundAll.do?code=F220207018&x=${katecX}&y=${katecY}&radius=5000&sort=1&prodcd=B027&out=json'));
    if (responseGas.statusCode == 200) {
      late List<OIL> gasList = [];
      List<dynamic> json = jsonDecode(responseGas.body)['RESULT']['OIL'];
      for (var i = 0; i < json.length; i++) {
        gasList.add(OIL.fromJson(json[i]));
      }
      return gasList;
    } else {
      throw Exception('Failed to load gas data');
    }
  } else {
    throw Exception('Failed to load coordinates');
  }
}

///////////////////////////// 내가 원하는 OIL class /////////////////////////////
class OIL {
  final String name;
  final int price;
  final double long;
  final double lat;

  OIL({
    required this.name,
    required this.price,
    required this.long,
    required this.lat,
  });

  factory OIL.fromJson(Map<dynamic, dynamic> json) {
    Point point =
        transCoord('카텍', Point(x: json['GIS_X_COOR'], y: json['GIS_Y_COOR']));
    return OIL(
      name: json['OS_NM'],
      price: json['PRICE'],
      long: point.x,
      lat: point.y,
    );
  }
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
