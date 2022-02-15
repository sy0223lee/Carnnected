import 'package:flutter/material.dart';

class Oilprice extends StatefulWidget {
  const Oilprice({Key? key}) : super(key: key);

  @override
  State<Oilprice> createState() => _OilpriceState();
}

class _OilpriceState extends State<Oilprice> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: text('주유 서비스 예약', 16.0, FontWeight.w500, Colors.black),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 78.0, 25.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('기름은', 20.0, FontWeight.w500, Colors.black),
            text('얼마나 넣어드릴까요?', 20.0, FontWeight.w500, Colors.black),
            SizedBox(height: 22.0),
            Row(
              children: [
                SizedBox(width: 8.0),
                Container(
                  width: 32,
                  height: 29,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Color(0xff001a5d)))),
                  ),
                ),
                SizedBox(width: 45.0),
                text('만원', 20.0, FontWeight.w500, Colors.black),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.text = '10';
                  },
                  child: text('가득', 12.0, FontWeight.w500, Colors.white),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff001a5d),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minimumSize: Size(33.0, 18.0),
                  ),
                ),
                SizedBox(width: 5.0),
                text('가득을 원하시면 눌러주세요', 10.0, FontWeight.w400, Colors.black)
              ],
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                kipgoing(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}

Container kipgoing() {
  return Container(
    width: double.infinity,
    height: 40,
    child: ElevatedButton(
      onPressed: () {},
      child: text('계속하기', 14.0, FontWeight.w500, Colors.white),
      style: ElevatedButton.styleFrom(primary: Color(0xff001a5d)),
    ),
  );
}
