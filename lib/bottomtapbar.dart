import 'package:flutter/material.dart';
import 'package:mosigg/home.dart';
import 'package:mosigg/oiling/oilconfirm.dart';
import 'package:mosigg/oiling/oilend.dart';
import 'package:mosigg/oiling/oilprice.dart';
import 'package:mosigg/oiling/oilstart.dart';

class Bottomtabbar extends StatefulWidget {
  const Bottomtabbar({Key? key}) : super(key: key);

  @override
  _BottomtabbarState createState() => _BottomtabbarState();
}

class _BottomtabbarState extends State<Bottomtabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: TabBarView(
          children: [
            Oilstart(),
            Oilprice(),
            HomePage(),
            Oilconfirm(),
            Oilend(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
          child: TabBar(
            labelColor: Color(0xff001a5d),
            unselectedLabelColor: Color(0xff9d9d9d),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color(0xff001a5d),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.watch_later_outlined,
                  size: 32.0,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  size: 32.0,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home_outlined,
                  size: 32.0,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.map_outlined,
                  size: 32.0,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.more_horiz,
                  size: 32.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
