import 'package:flutter/material.dart';
import 'package:mosigg/home.dart';
import 'package:mosigg/oiling/oilconfirm.dart';
import 'package:mosigg/oiling/oilend.dart';
import 'package:mosigg/oiling/oilprice.dart';
import 'package:mosigg/oiling/oilstart.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pageList.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff001a5d),
        unselectedItemColor: Color(0xff9d9d9d),
        currentIndex: selectedIndex,
        iconSize: 32.0,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: 'time', icon: Icon(Icons.watch_later_outlined)),
          BottomNavigationBarItem(label: 'mypage', icon: Icon(Icons.person)),
          BottomNavigationBarItem(
              label: 'home', icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label: 'map', icon: Icon(Icons.map_outlined)),
          BottomNavigationBarItem(
              label: 'option', icon: Icon(Icons.more_horiz)),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

List pageList = [
  Oilstart(),
  Oilprice(),
  HomePage(),
  Oilconfirm(),
  Oilend(),
];
