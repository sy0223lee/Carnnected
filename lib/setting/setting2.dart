import 'package:flutter/material.dart';
import 'package:mosigg/history/history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Settingid extends StatefulWidget {
  const Settingid({Key? key}) : super(key: key);

  @override
  State<Settingid> createState() => _SettingidState();
}

class _SettingidState extends State<Settingid> {
  Future<List>? data;
  @override
  void initState() {
    data = userdata('dlekdud0102');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: text('계정 관리', 18.0, FontWeight.w500, Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder<List>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text('아이디', 14.0, FontWeight.w500, Colors.black),
                      SizedBox(height: 10.0),
                      text(snapshot.data![0].id, 12.0, FontWeight.w400,
                          Colors.black),
                      Divider(
                        height: 6.0,
                        color: Color(0xffcbcbcb),
                        thickness: 2.0,
                      ),
                      SizedBox(height: 20.0),
                      text('비밀번호', 14.0, FontWeight.w500, Colors.black),
                      SizedBox(height: 10.0),
                      text(snapshot.data![0].pwd, 12.0, FontWeight.w400,
                          Colors.black),
                      Divider(
                        height: 6.0,
                        color: Color(0xffcbcbcb),
                        thickness: 2.0,
                      ),
                      SizedBox(height: 20.0),
                      text('휴대폰 번호', 14.0, FontWeight.w500, Colors.black),
                      SizedBox(height: 10.0),
                      text(snapshot.data![0].phone, 12.0, FontWeight.w400,
                          Colors.black),
                      Divider(
                        height: 6.0,
                        color: Color(0xffcbcbcb),
                        thickness: 2.0,
                      ),
                      SizedBox(height: 20.0),
                      text('생년월일', 14.0, FontWeight.w500, Colors.black),
                      SizedBox(height: 10.0),
                      text(snapshot.data![0].birth, 12.0, FontWeight.w400,
                          Colors.black),
                      Divider(
                        height: 6.0,
                        color: Color(0xffcbcbcb),
                        thickness: 2.0,
                      ),
                    ],
                  ),
                );
              } else
                return Text('실패');
            }));
  }
}

Future<List> userdata(String id) async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8080/member/${id}'));
  late List<User> dataList = [];
  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);
    for (var i = 0; i < json.length; i++) {
      dataList.add(User.fromJson(json[i]));
    }
    return dataList;
  } else {
    throw Exception('Failed to load user data');
  }
}

class User {
  final String id;
  final String pwd;
  final String phone;
  final String birth;
  User({
    required this.id,
    required this.pwd,
    required this.phone,
    required this.birth,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      pwd: json['name'],
      phone: json['number'],
      birth: json['birth'],
    );
  }
}
