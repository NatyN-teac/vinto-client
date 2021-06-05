import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vinto/helper/constant.dart';
import '../home_screen/home.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: mainBg,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.offAll(Homescreen());
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Preparing your\nrecommendations",
                          style: TextStyle(
                            fontSize: 21,
                            color: KWhiteColor,
                            letterSpacing: 0.25,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            width: 30,
                            height: 1,
                            color: KWhiteColor,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CircularPercentIndicator(
                          radius: 80.0,
                          backgroundColor: Colors.transparent,
                          startAngle: 180.0,
                          lineWidth: 12.0,
                          center: Text(
                            "Loading..",
                            style: TextStyle(fontSize: 14, color: KWhiteColor),
                          ),
                          percent: 0.71,
                          progressColor: KWhiteColor,
                          circularStrokeCap: CircularStrokeCap.butt,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "touch the screen \n to continue",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
