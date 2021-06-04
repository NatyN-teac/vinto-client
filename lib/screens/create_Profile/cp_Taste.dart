import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/controller/taste_controller.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/model/mood.dart';
import 'package:vinto/model/taste.dart';
import 'package:vinto/screens/create_Profile/cp_Select_Interest_2.dart';
import 'package:vinto/screens/loading/loading_Screen.dart';
import 'package:vinto/widgets/interests/interests.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';

class CP_Taste extends StatefulWidget {
  final List<Interests> myInterest;
  final List<Experience> myExperience;
  final List<Mood> myMood;

  const CP_Taste({Key key, this.myInterest, this.myExperience, this.myMood})
      : super(key: key);

  @override
  _CP_TasteState createState() => _CP_TasteState();
}

class _CP_TasteState extends State<CP_Taste> {
  final TasteController tasteController = Get.put(TasteController());
  List<Taste> selectedTastes = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (tasteController.isLoading.value)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return Container(
              decoration: mainBg,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  locationPin(),
                  SizedBox(
                    height: 40,
                  ),
                  LightText(
                    text:
                        "Which of these taste profile interest you? (pick up to 5)",
                    size: 24.0,
                    align: "left",
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: Get.height * 0.5,
                    child: ListView.builder(
                        itemCount: tasteController.tasteList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (!selectedTastes.contains(
                                      tasteController.tasteList[index]) &&
                                  selectedTastes.length < 6) {
                                setState(() {
                                  selectedTastes
                                      .add(tasteController.tasteList[index]);
                                });
                              } else {
                                setState(() {
                                  selectedTastes
                                      .remove(tasteController.tasteList[index]);
                                });
                              }
                            },
                            child: Align(
                              child: Container(
                                width: 85,
                                margin:
                                    EdgeInsets.only(bottom: Get.width * 0.015),
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 16, bottom: 12),
                                decoration: BoxDecoration(
                                  //
                                  color: selectedTastes.contains(
                                          tasteController.tasteList[index])
                                      ? KWhiteColor.withOpacity(0.4)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                    color: selectedTastes.contains(
                                            tasteController.tasteList[index])
                                        ? KWhiteColor.withOpacity(0.5)
                                        : KWhiteColor.withOpacity(0.2),
                                  ),
                                ),
                                child: Center(
                                  child: FittedBox(
                                    child: Text(
                                      "${tasteController.tasteList[index].name}",
                                      style: TextStyle(
                                        color: KWhiteColor,
                                        fontSize: 13,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Interests(
                  //       dName: "Mint",
                  //     ),
                  //     Interests(
                  //       dName: "Pine",
                  //     ),
                  //     Interests(
                  //       dName: "Orange",
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Interests(
                  //       dName: "Berry",
                  //     ),
                  //     Interests(
                  //       dName: "Rose",
                  //     ),
                  //     Interests(
                  //       dName: "Tobacco",
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Interests(
                  //       dName: "Lime",
                  //     ),
                  //     Interests(
                  //       dName: "Coffee",
                  //     ),
                  //     Interests(
                  //       dName: "Honey",
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Interests(
                  //       dName: "Grape",
                  //     ),
                  //     Interests(
                  //       dName: "Lavender",
                  //     ),
                  //     Interests(
                  //       dName: "Lemon",
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Interests(
                  //       dName: "Pine",
                  //     ),
                  //     Interests(
                  //       dName: "Earthy",
                  //     ),
                  //     Interests(
                  //       dName: "Apple",
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Interests(
                  //       dName: "Apricot",
                  //     ),
                  //     Interests(
                  //       dName: "Mango",
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Interests(
                  //       dName: "Vanilla",
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () async{
                          SharedPreferences pref = await SharedPreferences.getInstance();

                         try{
                           List<String> interstIds = widget.myInterest.map((e) => e.sId).toList();
                           List<String> moodIds = widget.myMood.map((e) => e.sId).toList();
                           List<String> experienceId = widget.myExperience.map((e) => e.sId).toList();
                           List<String> tastId = selectedTastes.map((e) => e.sId).toList();

                           var StringInterst = interstIds.join(',');
                           var StringMood = moodIds.join(',');
                           var StringExperience = experienceId.join(',');
                           var StringTaste = tastId.join(',');


                           pref.setString("interest",StringInterst);
                           pref.setString("mood",StringMood);
                           pref.setString("exp",StringExperience);
                           pref.setString("taste",StringTaste);

                           Get.to(Loading());
                         }catch(e){
                           print("error: $e");
                         }






                        },
                        minWidth: 100,
                        color: KYellowColor,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'NEXT',
                            style: TextStyle(
                              fontSize: 13,
                              color: KWhiteColor,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            );
        }),
      ),
    );
  }
}
