import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mosigg/provider/replaceProvider.dart';
import 'package:provider/provider.dart';

enum Select { One, Two, Three, Four, Five, Six, Seven }
enum Using { One }

var optionItem = [];
var optionPrice = [];

class RepSelect2 extends StatefulWidget {
  final String image;
  final String name;
  final String price;

  const RepSelect2(
      {Key? key, 
      required this.image,
      required this.name,
      required this.price})
      : super(key: key);

  @override
  _RepSelect2State createState() => _RepSelect2State();
}

class _RepSelect2State extends State<RepSelect2> {
  List<CustomRadio> size = [
    CustomRadio(true, '300mm', '10,000'),
    CustomRadio(false, '350mm', '10,000'),
    CustomRadio(false, '400mm', '10,000'),
    CustomRadio(false, '450mm', '10,000'),
    CustomRadio(false, '450mm', '10,000'),
    CustomRadio(false, '500mm', '10,000'),
    CustomRadio(false, '550mm', '10,000'),
    CustomRadio(false, '600mm', '10,000'),
  ];
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
                  SizedBox(height: 8),
                  Container(
                    height: 28.0 * size.length,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: size.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              splashColor: Colors.grey[50],
                              onTap: () {
                                setState(() {
                                  size.forEach((element) {
                                    element.isSelected = false;
                                  });
                                  size[index].isSelected = true;
                                });
                              },
                              child: CustomRadioItem(item: size[index]));
                        }),
                  ),
                  SizedBox(height: 11),
                  text('용도', 16.0, FontWeight.w500, Colors.black),
                  RadioListTile(
                      title: Transform.translate(
                          offset: Offset(-18, 0),
                          child: Row(
                            children: [
                              text('조수석', 14.0, FontWeight.w400, Colors.black),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 174),
                              text('+0원', 14.0, FontWeight.w400, Colors.black)
                            ],
                          )),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      value: Using.One,
                      groupValue: using,
                      onChanged: (value) {
                        setState(() {
                          using = value as Using?;
                        });
                      }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CountPurchase>().increase();
                        optionItem.add(widget.name);
                        optionPrice.add(widget.price);
                        Navigator.pop(context);
                      },
                      child: text('${widget.price}원 담기', 14.0, FontWeight.w500,
                          Colors.white),
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

class CustomRadioItem extends StatelessWidget {
  final CustomRadio item;

  const CustomRadioItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      height: 22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 2),
          item.isSelected
              ? Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 7.0, color: Color(0xff001A5D))),
                )
              : Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0, color: Colors.grey)),
                ),
          SizedBox(width: 6),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(item.option, 12.0, FontWeight.w400, Colors.black),
                text(item.price + '원', 12.0, FontWeight.w400, Colors.black),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomRadio {
  late bool isSelected;
  late String option;
  late String price;

  CustomRadio(this.isSelected, this.option, this.price);
}
