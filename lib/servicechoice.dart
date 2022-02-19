import 'package:flutter/material.dart';

class Servicechoice extends StatefulWidget {
  const Servicechoice({Key? key}) : super(key: key);

  @override
  _ServicechoiceState createState() => _ServicechoiceState();
}

class _ServicechoiceState extends State<Servicechoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 153,
              color: Color(0xff001a5d),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.help_outline),
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                top: 50.0,
                right: 60.0,
                child:
                    //if(이용한 서비스가 있으면)
                    card1()
                //if(이용한 서비스가 없으면)
                //card2()
                //if(등록된 차량이 없으면)
                //card3
                )
          ],
        ),
        SizedBox(height: 84.0),
        text('이용 가능한 서비스', 16.0, FontWeight.bold, Colors.black),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 35.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 60.0,
                  ),
                ),
                SizedBox(height: 4.0),
                text('주유', 10.0, FontWeight.w400, Colors.black),
              ],
            ),
            Column(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 35.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 60.0,
                  ),
                ),
                SizedBox(height: 4.0),
                text('방문세차', 10.0, FontWeight.w400, Colors.black),
              ],
            ),
            Column(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 35.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 60.0,
                  ),
                ),
                SizedBox(height: 4.0),
                text('방문교체', 10.0, FontWeight.w400, Colors.black),
              ],
            ),
          ],
        ),
        SizedBox(height: 22.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 35.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 60.0,
                  ),
                ),
                SizedBox(height: 4.0),
                text('정비', 10.0, FontWeight.w400, Colors.black),
              ],
            ),
            Column(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 35.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 60.0,
                  ),
                ),
                SizedBox(height: 4.0),
                text('딜리버리', 10.0, FontWeight.w400, Colors.black),
              ],
            ),
            Column(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 35.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 60.0,
                  ),
                ),
                SizedBox(height: 4.0),
                text('대리운전', 10.0, FontWeight.w400, Colors.black),
              ],
            ),
          ],
        ),
        SizedBox(height: 22.0),
        Row(
          children: [
            SizedBox(width: 59.0),
            Column(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 35.0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 60.0,
                  ),
                ),
                SizedBox(height: 4.0),
                text('가계부', 10.0, FontWeight.w400, Colors.black),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}

Container card1() {
  //기본 서비스 선택
  return Container(
    width: 280,
    height: 148,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5.0,
          spreadRadius: 4.0,
        )
      ],
      color: Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 15,
              child: Center(
                child: IconButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {},
                    icon: Icon(
                      Icons.restart_alt,
                      color: Colors.black,
                    )),
              ),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(width: 26.0),
            CircleAvatar(
              backgroundImage: AssetImage('image/kakao.png'), //연동
              radius: 35.0,
            ),
            SizedBox(width: 17.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('12가 1234', 16.0, FontWeight.bold, Colors.black), //연동
                SizedBox(height: 5),
                text('BMW M340i', 12.0, FontWeight.w400, Colors.black), //연동
                text('완고한 고비의 힘', 12.0, FontWeight.w400, Colors.black) //연동
              ],
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            SizedBox(width: 14.0),
            text('최근 이용한 서비스', 12.0, FontWeight.w500, Colors.black),
          ],
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            SizedBox(width: 14.0),
            Container(
              height: 18,
              width: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return currentservice(serviceList[index]);
                  }),
            )
          ],
        ),
        SizedBox(height: 11.0)
      ],
    ),
  );
}

Card card2() {
  //서비스 선택 차별명및 최근 이용서비스 없음
  return Card(
    elevation: 0.0,
    child: Container(
      width: 280,
      height: 148,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 4.0,
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 15,
                child: Center(
                  child: IconButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.restart_alt,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(width: 26.0),
              CircleAvatar(
                backgroundImage: AssetImage('image/kakao.png'), //연동
                radius: 35.0,
              ),
              SizedBox(width: 17.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text('12가 1234', 16.0, FontWeight.bold, Colors.black), //연동
                  SizedBox(height: 5),
                  text('BMW M340i', 12.0, FontWeight.w400, Colors.black), //연동
                  text('완고한 고비의 힘', 12.0, FontWeight.w400, Colors.black) //연동
                ],
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              SizedBox(width: 14.0),
              text('최근 이용한 서비스', 12.0, FontWeight.w500, Colors.black),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              SizedBox(width: 14.0),
              text('다양한 서비스를 이용해보세요:)', 10.0, FontWeight.w400, Colors.black)
            ],
          ),
          SizedBox(height: 11.0)
        ],
      ),
    ),
  );
}

Opacity card3() {
  //서비스 선택 차 미등록시
  return Opacity(
    opacity: 0.75,
    child: Container(
        width: 280,
        height: 148,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text('등록된 차량이 없네요!', 14.0, FontWeight.w500, Colors.white),
            text('차량을 등록해보세요:)', 14.0, FontWeight.w500, Colors.white),
          ],
        ))),
  );
}

Container currentservice(service) {
  return Container(
      margin: EdgeInsets.only(right: 10.0),
      width: 50.0,
      height: 18.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff001a5d),
      ),
      child: Center(child: text(service, 10.0, FontWeight.w500, Colors.white)));
}

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}

List serviceList = ['주유', '방문세차', '방문교체', '정비'];
