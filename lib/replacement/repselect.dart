import 'package:flutter/material.dart';

enum Select {One, Two, Three, Four, Five, Six, Seven}
enum Using {One}

class RepSelect extends StatefulWidget {
  final String image;
  final String name;
  final String price;

  const RepSelect(
    {Key? key,
    required this.image,
    required this.name,
    required this.price}) 
    : super(key: key);

  @override
  _RepSelectState createState() => _RepSelectState();
}

class _RepSelectState extends State<RepSelect> {
  Select? select = Select.One;
  Using? using = Using.One;

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 212,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.image),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(widget.name, 18.0, FontWeight.w500, Colors.black),
                  SizedBox(height: 14),
                  text('사이즈', 16.0, FontWeight.w500, Colors.black),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('300mm', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 212),
                          text('${widget.price}원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Select.One,
                    groupValue: select,
                    onChanged: (value) {
                      setState(() {
                        select = value as Select?;
                      });
                    }
                  ),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('350mm', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 212),
                          text('${widget.price}원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Select.Two,
                    groupValue: select,
                    onChanged: (value) {
                      setState(() {
                        select = value as Select?;
                      });
                    }
                  ),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('400mm', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 212),
                          text('${widget.price}원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Select.Three,
                    groupValue: select,
                    onChanged: (value) {
                      setState(() {
                        select = value as Select?;
                      });
                    }
                  ),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('450mm', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 212),
                          text('${widget.price}원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Select.Four,
                    groupValue: select,
                    onChanged: (value) {
                      setState(() {
                        select = value as Select?;
                      });
                    }
                  ),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('500mm', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 212),
                          text('${widget.price}원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Select.Five,
                    groupValue: select,
                    onChanged: (value) {
                      setState(() {
                        select = value as Select?;
                      });
                    }
                  ),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('550mm', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 212),
                          text('${widget.price}원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Select.Six,
                    groupValue: select,
                    onChanged: (value) {
                      setState(() {
                        select = value as Select?;
                      });
                    }
                  ),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('600mm', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 212),
                          text('${widget.price}원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Select.Seven,
                    groupValue: select,
                    onChanged: (value) {
                      setState(() {
                        select = value as Select?;
                      });
                    }
                  ),
                  SizedBox(height: 18),
                  text('용도', 16.0, FontWeight.w500, Colors.black),
                  RadioListTile(
                    title: Transform.translate(
                      offset: Offset(-18, 0),
                      child: Row(
                        children: [
                          text('조수석', 14.0, FontWeight.w400, Colors.black),
                          SizedBox(width: MediaQuery.of(context).size.width - 174),
                          text('+0원', 14.0, FontWeight.w400, Colors.black)
                        ],
                      )
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    value: Using.One,
                    groupValue: using,
                    onChanged: (value) {
                      setState(() {
                        using = value as Using?;
                      });
                    }
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-50,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: (){
                        // 장바구니 담긴 개수 증가
                      },
                      child: text('${widget.price}원 담기', 14.0, FontWeight.w500, Colors.white),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff001A5D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 0.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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