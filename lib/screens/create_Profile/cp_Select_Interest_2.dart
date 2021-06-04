import 'dart:ui';
import 'package:get/get.dart';
import 'package:vinto/controller/interest_controller.dart';
import 'package:vinto/controller/mood_controller.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/model/mood.dart';
import 'package:vinto/screens/create_Profile/cp_Taste.dart';
import 'package:vinto/screens/register/sign_In.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';

class CPSelectInterest_2 extends StatefulWidget {
  final List<Interests> myInterest;
  final List<Experience> myExperience;

  const CPSelectInterest_2({Key key, this.myInterest, this.myExperience}) : super(key: key);
  @override
  _CPSelectInterest_2State createState() => _CPSelectInterest_2State();
}

class _CPSelectInterest_2State extends State<CPSelectInterest_2> {

  final MoodController moodController = Get.put(MoodController());
  var isChecked = false;
  List<Mood>selectedMood = [];

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Scaffold(
        body: Obx((){
          if(moodController.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else return Container(
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
                  text: "Moods & Activities",
                  size: 24.0,
                  align: "left",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "What are your wellness goals?",
                  style: TextStyle(
                    fontSize: 13,
                    color: KWhiteColor,
                  ),
                ),
                Text(
                  "(select as many as necessary)",
                  style: TextStyle(
                    fontSize: 12,
                    color: KLightGreyColor,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: moodController.moodList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                        height: 48,
                        child: Theme(
                        data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.transparent,
                       ),
                      child: CheckboxListTile(
                        value: selectedMood.contains(moodController.moodList[index]),
                        secondary: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: KWhiteColor,
                              border: Border.all(
                                color: KLightGreyColor,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Checkbox(
                            value:selectedMood.contains(moodController.moodList[index]),
                            activeColor: Colors.transparent,
                            checkColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                if(selectedMood.contains(moodController.moodList[index])){
                                  isChecked = true;
                                }else {
                                  isChecked = false;
                                }
                                // isChecked = !isChecked;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          print("valu: $value");

                            // isChecked = !isChecked;
                            if(value == true){
                              setState(() {
                                isChecked = false;
                                selectedMood.add(moodController.moodList[index]);

                              });

                            }else{
                              setState(() {
                                isChecked = true;
                                selectedMood.remove(moodController.moodList[index]);
                              });
                            }

                            print("moods: ${selectedMood}");

                        },
                        checkColor: Colors.transparent,
                        activeColor: Colors.transparent,
                        title: Text(
                          "${ moodController.moodList[index].name}",
                          style: TextStyle(
                            fontSize: 14,
                            color: KWhiteColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ));
                  }

                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    yellowButton("NEXT",100.0,CP_Taste(
                      myExperience: widget.myExperience,
                      myInterest: widget.myInterest,
                      myMood: selectedMood,
                    )),
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

class WellnessGoals extends StatefulWidget {
  var goalName;

  WellnessGoals({
    this.goalName,
  });

  @override
  _WellnessGoalsState createState() => _WellnessGoalsState();
}

class _WellnessGoalsState extends State<WellnessGoals> {
  var isChecked = false;
  var goal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.transparent,
        ),
        child: CheckboxListTile(

          value: isChecked,
          secondary: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: KWhiteColor,
                border: Border.all(
                  color: KLightGreyColor,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Checkbox(
              value: isChecked,
              activeColor: Colors.transparent,
              checkColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
          ),
          onChanged: (value) {
            setState(() {
              isChecked = !isChecked;
            });
          },
          checkColor: Colors.transparent,
          activeColor: Colors.transparent,
          title: Text(
            "${widget.goalName}",
            style: TextStyle(
              fontSize: 14,
              color: KWhiteColor,
              letterSpacing: 0.3,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}
