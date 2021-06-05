import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class Resultscreen extends StatefulWidget {
  @override
  _ResultscreenState createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.7);
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
            SizedBox(
              height: vert_block * 6,
            ),
            Text(
              'Your Results',
              style: TextStyle(
                  fontSize: vert_block * 2.8,
                  fontFamily: 'Gill medium',
                  color: Mycolors.blacktext,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: vert_block * 2,
            ),

            Container(
              width: width,
              height: vert_block * 40,
              //color: Colors.red,
              child: PageView(
                controller: _pageController,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: horz_block * 6),
                      child: Image.asset('assets/item1.png')),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: horz_block * 6),
                      child: Image.asset('assets/item1.png')),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: horz_block * 6),
                      child: Image.asset('assets/item1.png')),
                ],
              ),
            ),

            // SizedBox(height: vert_block*6,),
            Text(
              'Earthy and Fruity',
              style: TextStyle(
                  fontSize: vert_block * 2.5,
                  fontFamily: 'Gill medium',
                  color: Mycolors.blacktext,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: vert_block,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horz_block * 8),
              child: Text(
                'Donec facilisis tortor ut augue lacinia, at viverra est semper. Sed sapien metus, scelerisque nec pharetra id, tempor a tortor. Pellentesque non dignissim neque. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: vert_block * 1.5,
                    fontFamily: 'Gill medium',
                    color: Mycolors.graytext,
                    fontWeight: FontWeight.w700),
              ),
            ),

            SizedBox(
              height: vert_block * 2,
            ),
            SmoothPageIndicator(
                controller: _pageController, // PageController
                count: 3,
                effect: WormEffect(
                    activeDotColor: Mycolors.blacktext1,
                    dotColor: Mycolors.graytext.withOpacity(0.6),
                    radius: 10,
                    dotHeight: 8,
                    dotWidth: 8), // your preferred effect
                onDotClicked: (index) {}),

            SizedBox(
              height: vert_block * 6,
            ),

            Container(
              width: horz_block * 60,
              height: vert_block * 5.6,
              decoration: BoxDecoration(
                  color: Mycolors.green,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Show me the goods',
                  style: TextStyle(
                    fontSize: vert_block * 2,
                    //fontFamily: 'Gill medium',
                    color: Colors.white,
                    //fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),

            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Feeling different?',
                  style: TextStyle(
                    fontSize: vert_block * 1.5,
                    //fontFamily: 'Gill medium',
                    color: Mycolors.blacktext,
                    //fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  '  Start over',
                  style: TextStyle(
                    fontSize: vert_block * 1.5,
                    //fontFamily: 'Gill medium',
                    color: Mycolors.green,
                    //fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
            SizedBox(
              height: vert_block * 3,
            )
          ],
        ),
      ),
    );
  }
}
