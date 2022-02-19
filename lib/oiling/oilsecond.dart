import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;

class GasRsrv extends StatefulWidget {
  @override
  _GasRsrvState createState() => _GasRsrvState();
}

class _GasRsrvState extends State<GasRsrv> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initState() {
    super.initState();
    // _addMarker(37.555351, 126.970327);
    // _addMarker(37.55167060101183, 126.97717465396896);
    getGasinfo();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _addMarker(x, y) async {
    var markerIdVal = x.toString();
    final MarkerId markerId = MarkerId(markerIdVal);
    Uint8List markerIcon = await getBytesFromCanvas(150, 80);
    
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      draggable: false,
      infoWindow: InfoWindow(title: "여기로 예약"),
      onTap: () {
        _infoDialog(context);
      },
      position: LatLng(x, y)
    );

    _markers.add(marker);
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
      text: '1,612',
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
    painter.layout();
    painter.paint(canvas, Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: text('주유 서비스 예약', 16.0, FontWeight.w500, Colors.black),
          toolbarHeight: 56.0,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            iconSize: 16.0,
            onPressed: (){},
          )
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: Set.from(_markers),
          initialCameraPosition: CameraPosition(
            target: LatLng(37.554761, 126.970727),
            zoom: 14.4746,
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.fromLTRB(55.0, 0.0, 25.0, 0.0),
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          child: TextButton(
              child: text("계속하기", 14.0, FontWeight.w500, Color(0xffffffff)),
              onPressed: (){},
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff001A5D),
              ),
          ),
        ),
      ),
    );
  }

  void _infoDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx){
        return GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: SimpleDialog(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 12.0)),
                      text("SK행복충전 신우에너지 풍동충전소", 16.0, FontWeight.bold, Colors.black),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 12.0)),
                      Container(
                        width: 24.0,
                        child: Text("주소",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: Colors.black), textAlign: TextAlign.center,),
                        decoration: BoxDecoration(
                          color: Color(0xffe8eaee)
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      text("경기도 고양시 일산동구 식사동 861-1", 10.0, FontWeight.w500, Colors.black),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 12.0)),
                      Container(
                        width: 24.0,
                        child: Text("가격",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: Colors.black), textAlign: TextAlign.center,),
                        decoration: BoxDecoration(
                          color: Color(0xffe8eaee)
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      text("1,612", 10.0, FontWeight.w500, Colors.black),
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

Future<List> getGasinfo() async {
  final response = await http.get(Uri.parse('https://www.opinet.co.kr/api/aroundAll.do?code=F220207018&x=325681.8&y=544837&radius=2000&sort=1&prodcd=B027&out=json')); 
  print(jsonDecode(response.body)["RESULT"]);
  late List<OIL> gasList = [];
  
  if(response.statusCode == 200){
    // List<dynamic> json = jsonDecode(response.body);
    // for (var i = 0; i < json.length; i++)
    //   gasList.add(OIL.fromJson(json[i]));
    return gasList;
  }
  else  throw Exception('Failed to load gas data');
}

///////////////////////////// 내가 원하는 OIL class /////////////////////////////
class OIL {
  final String name;
  final String price;
  final String xcoor;
  final String ycoor;

  OIL({
    required this.name,
    required this.price,
    required this.xcoor,
    required this.ycoor,
  });
  
  factory OIL.fromJson(Map<String, dynamic> json) {
    return OIL(
      name: json['OS_NM'],
      price: json['PRICE'],
      xcoor: json['GIS_X_COOR'],
      ycoor: json['GIS_Y_COOR'],
    );
  }
}