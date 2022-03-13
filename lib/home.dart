import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mosigg/login/login.dart'; // 로그아웃

class HomePage extends StatefulWidget {
  final String id;
  final String pw;
  HomePage({required this.id, required this.pw});
  // const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final storage = FlutterSecureStorage(); // 로그아웃
  late String id;
  late String pw;
  var idx = 0;
  Future<List>? data;
  String usingservice = "";

  Future initService(String carNumber) async {
    var service = await getUsingservice(carNumber);
    setState(() {
      usingservice = service;
    });
  }
  
  @override
  void initState() {
    super.initState();
    id = widget.id;
    pw = widget.pw;
    data = cardata(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('HOME', 20.0, FontWeight.w500, Colors.black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (usingservice == "") {
                initService(snapshot.data![idx].carnumber);
              }
              return SingleChildScrollView(
                  child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    text(snapshot.data![idx].cartype, 18.0, FontWeight.w500,
                        Colors.black),
                    text(snapshot.data![idx].carname, 14.0, FontWeight.w500,
                        Color(0xffA9A9A9)),
                    Container(
                      height: 360,
                      child: Swiper(
                        onIndexChanged: (value) async {
                          setState(() {
                            idx = value;
                          });
                          usingservice = await getUsingservice(
                              snapshot.data![idx].carnumber);
                        },
                        scale: 0.85,
                        loop: false,
                        viewportFraction: 0.61,
                        pagination:
                            SwiperPagination(alignment: Alignment.bottomRight),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            children: [
                              card(snapshot.data![idx].carnumber, usingservice,
                                  "공유중")
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 380,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffE8EAEE),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                text('열기', 12.0, FontWeight.w400, Colors.black),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.lock_open_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                text('닫기', 12.0, FontWeight.w400, Colors.black),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                text('시동', 12.0, FontWeight.w400, Colors.black),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.power_settings_new,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                text('경적', 12.0, FontWeight.w400, Colors.black),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.campaign,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                text(
                                    '트렁크', 12.0, FontWeight.w400, Colors.black),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.toys_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}

Card card(String carnumber, String usingservice, String sharedstate) {
  return Card(
    elevation: 0.0,
    child: Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: Offset(10.0, 10.0))
        ],
        color: Color(0xff001A5D),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage: AssetImage('image/peridot.jpg'),
            radius: 40.0,
          ),
          text(carnumber, 18.0, FontWeight.bold, Colors.white),
          SizedBox(height: 9.0),
          Container(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: Divider(
              height: 0.0,
              color: Colors.white,
              thickness: 2.0,
            ),
          ),
          SizedBox(height: 13.0),
          text('현재 이용중인 서비스', 12.0, FontWeight.w400, Colors.white),
          SizedBox(height: 6.0),
          text(usingservice, 20.0, FontWeight.bold, Colors.white),
          SizedBox(height: 6.0),
          text('내 차를 누가 몰고 있는지 궁금하다면?', 10.0, FontWeight.w400, Colors.white),
          SizedBox(height: 23.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
              ),
            ),
            height: 40,
            width: 280,
            child: Center(
                child: text(sharedstate, 20.0, FontWeight.bold, Colors.black)),
          )
        ],
      ),
    ),
  );
}

Card pluscard() {
  return Card(
    elevation: 0.0,
    child: Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: Offset(10.0, 10.0))
        ],
        color: Colors.grey[300],
      ),
      child: Center(
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.plus_one,
            color: Color(0xffA9A9A9),
          ),
        ),
      ),
    ),
  );
}

Future<List> cardata(String id) async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8080/carinfo/${id}'));
  late List<Car> carList = [];
  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);
    for (var i = 0; i < json.length; i++) {
      carList.add(Car.fromJson(json[i]));
    }
    return carList;
  } else {
    throw Exception('Failed to load car data');
  }
}

Future<String> getUsingservice(String carnumber) async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:8080/usingservice/${carnumber}'));

  if (response.statusCode == 200) {
    String service = response.body.toString();
    return service;
  } else
    throw Exception('Failed to load car data');
}

class Car {
  final String cartype;
  final String carname;
  final String carnumber;
  Car({
    required this.cartype,
    required this.carname,
    required this.carnumber,
  });
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      cartype: json['model'],
      carname: json['name'],
      carnumber: json['number'],
    );
  }
}
