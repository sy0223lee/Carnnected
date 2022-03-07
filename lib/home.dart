import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mosigg/login/login.dart';

class HomePage extends StatefulWidget {
  final String id;
  final String pw;
  HomePage({required this.id, required this.pw});
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final storage = FlutterSecureStorage();
  late String id;
  late String pw;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    pw = widget.pw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('홈 화면', 20.0, FontWeight.w500, Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (context){
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("id: " + id),
                  Text("password: " + pw),
                  TextButton(
                    onPressed: (){
                      storage.delete(key: "login");
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginPage()
                        ));
                    },
                    child: Text("로그아웃"),)
                ],
              ),
            )
          );
        },
      ),
    );
  }
}

Text text(content, size, weight, colors){
  return Text(
    content, style: TextStyle(fontSize: size, fontWeight: weight, color: colors)
  );
}