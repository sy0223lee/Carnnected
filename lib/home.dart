import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  Icon(Icons.favorite, color: Color(0xff001A5D), size: 250.0,),
                  Icon(Icons.favorite, color: Colors.amber, size: 250.0,),
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