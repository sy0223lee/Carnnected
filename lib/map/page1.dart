import 'package:flutter/material.dart';
import 'package:mosigg/map/common/companies.dart';
import 'package:mosigg/map/common/tabbarWidget.dart';
import 'package:mosigg/map/googlemap.dart';

class Location{
  double x;
  double y;
  Location(this.x, this.y);
}

var latitude = '';
var longtitude = '';

// ignore: must_be_immutable
class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context){
    return ListView(
      children: [
        FilterMethod(),
        listview(companies.length)
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
            latitude = companies[index]['x'].toString();
            longtitude = companies[index]['y'].toString();
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
                colors: [
                  (companies[index]['type']=='주유')
                    ? Color(0xff001A5D)
                    : (companies[index]['type']=='세차')
                      ? Color(0xffBCC1CD)
                      : (companies[index]['type']=='정비')
                        ? Color(0xffE8EAEE)
                        : Color(0xffFFDF37), Color(0xffF5F5F5)]
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (companies[index].containsKey('price'))
                      ? SizedBox(height: 0)
                      : SizedBox(height: 7),
                    Text(
                      '${companies[index]['name']}',
                      style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700
                      ),
                    ),
                    (companies[index].containsKey('price'))
                      ? Text(
                        '${companies[index]['price']}',
                        style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700
                          ),
                        )
                      : SizedBox(height: 5),
                    Text(
                      '${companies[index]['address']}',
                      style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(
                      '${companies[index]['time']}',
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