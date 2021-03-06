import 'package:get/get.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'interest_form.dart';

enum select { yes, no }

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

class Create_Profile extends StatefulWidget {
  @override
  _Create_ProfileState createState() => _Create_ProfileState();
}

class _Create_ProfileState extends State<Create_Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: mainBg,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                locationPin(),
                SizedBox(
                  height: Get.height * 0.25,
                ),
                LightText(
                  text: "Have you tried products before?",
                  size: 24.0,
                  align: "left",
                ),
                SizedBox(
                  height: Get.height * 0.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.off(InterestForm());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        decoration: BoxDecoration(
                          color: KWhiteColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: KWhiteColor.withOpacity(0.4),
                          ),
                        ),
                        child: FittedBox(
                          child: Text(
                            "YEP",
                            style: TextStyle(
                              color: KWhiteColor,
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(InterestForm());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: KWhiteColor.withOpacity(0.4),
                          ),
                        ),
                        child: FittedBox(
                          child: Text(
                            "NOT YET",
                            style: TextStyle(
                              color: KWhiteColor,
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
