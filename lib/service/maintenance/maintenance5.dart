import 'package:flutter/material.dart';
import 'package:mosigg/components.dart';

class Maintenance5 extends StatefulWidget {
  final String id;
  const Maintenance5({Key? key, required this.id}) : super(key: key);

  @override
  State<Maintenance5> createState() => _Maintenance5State();
}

class _Maintenance5State extends State<Maintenance5> {
  late String id;

  @override
  void initState() {
    id = widget.id;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('정비 서비스 예약', 16.0, FontWeight.w500, Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 80.0),
        child: Center(
          child: Column(
            children: [
              text('예약이 완료되었습니다', 20.0, FontWeight.w500, Colors.black),
              text('최고의 서비스로 모시겠습니다:D', 20.0, FontWeight.w500, Colors.black),
              SizedBox(height: 43),
              Icon(
                Icons.toys,
                size: 223,
                color: Colors.black,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [gohome(context)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}