import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/order.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

class Timelinescreen extends StatefulWidget {
  final AssignedFor driver;

  const Timelinescreen({Key key, this.driver}) : super(key: key);
  @override
  _TimelinescreenState createState() => _TimelinescreenState();
}

class _TimelinescreenState extends State<Timelinescreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var vert_block = SizeConfig.safeBlockVertical;
    var horz_block = SizeConfig.safeBlockHorizontal;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 1.2,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: horz_block * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: vert_block * 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: horz_block * 3,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      Expanded(child: SizedBox()),
                      Text(
                        'Order Status',
                        style: TextStyle(
                            fontSize: vert_block * 2.8,
                            fontFamily: 'Gill medium',
                            color: Mycolors.blacktext,
                            fontWeight: FontWeight.w700),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(
                    height: vert_block * 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: vert_block * 2,
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 3, color: Mycolors.green)),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Mycolors.green,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: vert_block * 2,
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 3, color: Mycolors.green)),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Mycolors.green,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: vert_block * 6,
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 3, color: Mycolors.purple)),
                            child: Center(
                              child: Icon(
                                Icons.location_on_rounded,
                                color: Mycolors.purple,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: vert_block * 2,
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 3, color: Mycolors.graytext)),
                            child: Center(
                              child: Icon(
                                Icons.flag,
                                color: Mycolors.graytext,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: horz_block * 4,
                      ),
                      Container(
                        width: 3,
                        height: vert_block * 50,
                        color: Mycolors.background,
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 3,
                          height: vert_block * 28,
                          color: Mycolors.green,
                        ),
                      ),
                      SizedBox(
                        width: horz_block * 4,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: vert_block * 4,
                          ),
                          Text(
                            'Near to Me Order accepted \nyour order 👍',
                            style: TextStyle(
                                fontSize: vert_block * 2,
                                // fontFamily: 'Gill medium',
                                color: Mycolors.blacktext,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: vert_block * 4,
                          ),
                          Text(
                            'Your driver is on the way!',
                            style: TextStyle(
                                fontSize: vert_block * 2,
                                // fontFamily: 'Gill medium',
                                color: Mycolors.blacktext,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              Container(
                                  width: horz_block * 10,
                                  child: Image.asset('assets/profile.png')),
                              SizedBox(
                                width: horz_block * 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.driver.firstName} ${widget.driver.lastName}',
                                    style: TextStyle(
                                        fontSize: vert_block * 1.5,
                                        // fontFamily: 'Gill medium',
                                        color: Mycolors.graytext,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'Pro',
                                    style: TextStyle(
                                        fontSize: vert_block * 1.5,
                                        // fontFamily: 'Gill medium',
                                        color: Mycolors.purple,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: vert_block * 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Pickup',
                                style: TextStyle(
                                    fontSize: vert_block * 2,
                                    // fontFamily: 'Gill medium',
                                    color: Mycolors.blacktext,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '    Near To Me Alcolic Drinks',
                                style: TextStyle(
                                    fontSize: vert_block * 2,
                                    // fontFamily: 'Gill medium',
                                    color: Mycolors.purple,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: vert_block * 1.5,
                          ),
                          Text(
                            '${widget.driver.location.coordinates}',
                            style: TextStyle(
                                fontSize: vert_block * 1.5,
                                // fontFamily: 'Gill medium',
                                color: Mycolors.graytext,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: vert_block * 4.5,
                          ),
                          Text(
                            'Destination',
                            style: TextStyle(
                                fontSize: vert_block * 2,
                                // fontFamily: 'Gill medium',
                                color: Mycolors.blacktext,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: vert_block * 1.5,
                          ),
                          Text(
                            'Destination ${widget.driver.place ?? "Unknown"}',
                            style: TextStyle(
                                fontSize: vert_block * 1.5,
                                // fontFamily: 'Gill medium',
                                color: Mycolors.graytext,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Center(
                    child: Container(
                      width: horz_block * 20,
                      height: 3,
                      color: Mycolors.background,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Image.asset(
                  'assets/MAP.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
