import 'package:flutter/material.dart';
import 'package:mosigg/replacement/common/replacelist.dart';
import 'package:mosigg/replacement/repselect.dart';

var list1 = [];
var list2 = [];
var list3 = [];
var list4 = [];

class RepConfirm extends StatefulWidget {
  const RepConfirm({ Key? key }) : super(key: key);

  @override
  _RepConfirmState createState() => _RepConfirmState();
}

class _RepConfirmState extends State<RepConfirm> {
  @override
  void initState(){
    for(var i=0; i<repList.length; i++){
      if(repList[i]['type']=='와이퍼'){
        list1.add(repList[i]);
      }
      else if(repList[i]['type']=='워셔액'){
        list2.add(repList[i]);
      }
      else if(repList[i]['type']=='엔진오일'){
        list3.add(repList[i]);
      }
      else {
        list4.add(repList[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('교체 서비스 예약', 16.0, FontWeight.w500, Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){},
            shape: CircleBorder(),
            label: Icon(Icons.shopping_bag_rounded),
            backgroundColor: Color(0xff001a5d),
          ),
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
                  Tab(text: '와이퍼'),
                  Tab(text: '워셔액'),
                  Tab(text: '엔진오일'),
                  Tab(text: '배터리'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              listview(repList.length, repList),
              listview(list1.length, list1),
              listview(list2.length, list2),
              listview(list3.length, list3),
              listview(list4.length, list4),
            ],
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

Widget listview(itemcount, listname){
  return ListView(
    children: [
      ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemcount,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => RepSelect(
                      image: listname[index]['image'],
                      name: listname[index]['name'],
                      price: listname[index]['price'],
                    )));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('${listname[index]['image']}'),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 23),
                      Text('${listname[index]['name']}',
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('${listname[index]['price']}원',
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff001a5d)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    ]
  );
}