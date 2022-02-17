import 'package:flutter/material.dart';
import 'package:mosigg/map/common/companies.dart';
import 'package:mosigg/map/page1.dart';
import 'package:mosigg/map/page2.dart';
import 'package:mosigg/map/page3.dart';
import 'package:mosigg/map/page4.dart';
import 'package:mosigg/map/page5.dart';

var companies1 = [];
var companies2 = [];
var companies3 = [];
var companies4 = [];

class TabBarPage extends StatefulWidget {
  const TabBarPage({ Key? key }) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  // 각 서비스 별 리스트 생성
  @override
  void initState(){
    for(var i=0; i<companies.length; i++){
      if(companies[i]['type']=='주유'){
        companies1.add(companies[i]);
      }
      else if(companies[i]['type']=='세차'){
        companies2.add(companies[i]);
      }
      else if(companies[i]['type']=='정비'){
        companies3.add(companies[i]);
      }
      else {
        companies4.add(companies[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Color(0xff001A5D),
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                tabs: [
                  Tab(text: 'ALL'),
                  Tab(text: '주유소'),
                  Tab(text: '세차장'),
                  Tab(text: '정비소'),
                  Tab(text: '전기차')
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Page1(),
              Page2(),
              Page3(),
              Page4(),
              Page5(),
            ],
          ),
        ),
      ),
    );
  }
}