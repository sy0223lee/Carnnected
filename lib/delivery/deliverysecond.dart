import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
  int price = 23000;

  void initState() {
    super.initState();
    var _latitude = (widget.carCoord.latitude+widget.desCoord.latitude)/2;
    var _longitude = (widget.carCoord.longitude+widget.desCoord.longitude)/2;
    markerCam = CameraPosition(target: LatLng(_latitude, _longitude), zoom: 10);
    makeMarker();
  }

  void makeMarker() async {
    _addMarker(0, widget.carCoord.latitude, widget.carCoord.longitude, "출발");
    _addMarker(1, widget.desCoord.latitude, widget.desCoord.longitude, "도착");
  }

  void _addMarker(id, x, y, loc) async {
    final MarkerId markerId = MarkerId(id.toString());
    Uint8List markerIcon = await getBytesFromCanvas(120, 80, loc);

    Marker marker = new Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        draggable: false,
        position: LatLng(x, y));

    setState(() {
      _markers.add(marker);
    });
  }

  Future<Uint8List> getBytesFromCanvas(int width, int height, String txt) async {
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
      text: txt,
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