import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class Editcart extends StatefulWidget {
  @override
  _EditcartState createState() => _EditcartState();
}

class _EditcartState extends State<Editcart> {
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
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/disp2.png'),
                      fit: BoxFit.cover)),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: horz_block * 6, vertical: horz_block * 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        //Icon(Icons.edit,color: Colors.white,)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      'yourname@email.com',
                      style: TextStyle(
                        fontSize: vert_block * 2,
                        color: Colors.white,
                        //  fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(
                      height: vert_block,
                    ),
                    Text(
                      'My Cart',
                      style: TextStyle(
                        fontSize: vert_block * 2.5,
                        color: Colors.white,
                        //  fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: horz_block * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: vert_block * 2,
                  ),
                  Text(
                    'Erin Kirk',
                    style: TextStyle(
                      fontSize: vert_block * 2.2,
                      color: Mycolors.blacktext3,
                      // fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    'Visa Debit ********6051',
                    style: TextStyle(
                      fontSize: vert_block * 2.1,
                      color: Mycolors.graytext,
                      // fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(
                    height: vert_block * 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product/s',
                        style: TextStyle(
                            fontSize: vert_block * 2,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'QTY',
                        style: TextStyle(
                            fontSize: vert_block * 2,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: vert_block,
                  ),
                  Container(
                    width: width,
                    height: 2,
                    color: Mycolors.background,
                  ),
                  SizedBox(
                    height: vert_block * 2,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1/8 oz Herban Sour Lemonade CBD Flower',
                        style: TextStyle(
                          fontSize: vert_block * 1.7,
                          color: Colors.black,
                          //fontWeight: FontWeight.w700
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: vert_block * 1.7,
                          color: Colors.black,
                          //  fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(
                        width: horz_block * 2,
                      ),
                      Icon(
                        Icons.edit,
                        size: 15,
                        color: Mycolors.graytext,
                      )
                    ],
                  ),
                  SizedBox(
                    height: vert_block * 2,
                  ),
                  Container(
                    width: width,
                    height: 2,
                    color: Mycolors.background,
                  ),
                  SizedBox(
                    height: vert_block * 2,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1/8 oz Herban Sour Lemonade CBD Flower',
                        style: TextStyle(
                          fontSize: vert_block * 1.7,
                          color: Colors.black,
                          //fontWeight: FontWeight.w700
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: vert_block * 1.7,
                          color: Colors.black,
                          //  fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(
                        width: horz_block * 2,
                      ),
                      Icon(
                        Icons.edit,
                        size: 15,
                        color: Mycolors.graytext,
                      )
                    ],
                  ),
                  SizedBox(
                    height: vert_block * 2,
                  ),
                  Container(
                    width: width,
                    height: 2,
                    color: Mycolors.background,
                  ),
                  SizedBox(
                    height: vert_block * 2,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1/8 oz Herban Sour Lemonade CBD Flower',
                        style: TextStyle(
                          fontSize: vert_block * 1.7,
                          color: Colors.black,
                          //fontWeight: FontWeight.w700
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: vert_block * 1.7,
                          color: Colors.black,
                          //  fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(
                        width: horz_block * 2,
                      ),
                      Icon(
                        Icons.edit,
                        size: 15,
                        color: Mycolors.graytext,
                      )
                    ],
                  ),
                  SizedBox(
                    height: vert_block * 2,
                  ),
                  Container(
                    width: width,
                    height: 2,
                    color: Mycolors.background,
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: vert_block * 6,
                color: Mycolors.orange,
                child: Center(
                  child: Text(
                    'SAVE CHANGES',
                    style: TextStyle(
                      fontSize: vert_block * 2,
                      color: Colors.white,
                      //  fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
