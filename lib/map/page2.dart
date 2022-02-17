import 'package:flutter/material.dart';
import 'package:mosigg/map/tabbar.dart';
import 'package:mosigg/map/common/tabbarWidget.dart';
import 'package:mosigg/map/googlemap.dart';
import 'package:mosigg/map/page1.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context){
    return ListView(
      children: [
        FilterMethod(),
        listview(companies1.length)
      ],
    );
  }
}

Widget listview(itemcount) {
  return ListView.separated(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    scrollDirection: Axis.vertical,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: itemcount,
    itemBuilder: (BuildContext context, int index){
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            latitude = companies1[index]['x'].toString();
            longtitude = companies1[index]['y'].toString();
            final location = Location(double.parse(latitude), double.parse(longtitude));
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext
                        context) =>
                    MapPage(location: location)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade200,
                width: 2.0
              ),
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                stops: [0.03, 0.03],
                colors: [Color(0xff001A5D), Color(0xffF5F5F5)]
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${companies1[index]['name']}',
                      style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700
                      ),
                    ),
                    Text(
                    '${companies1[index]['price']}',
                    style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700
                      ),
                    ),
                    Text(
                      '${companies1[index]['address']}',
                      style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(
                      '${companies1[index]['time']}',
                      style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xff6A6A6A)
                      ),
                    ),
                  ],
                ),                     
              ],
            ),
          ),
        )
      );
    },
    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 3),
  );
}