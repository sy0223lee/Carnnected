import 'package:flutter/material.dart';
import 'package:mosigg/signup1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOSIGG',
      theme: ThemeData(fontFamily: 'NotoSans', primaryColor: Colors.white, scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SignUp1()
      },
    );
  }
}