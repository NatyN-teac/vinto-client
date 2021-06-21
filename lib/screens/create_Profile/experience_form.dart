import 'package:get/get.dart';
import 'package:vinto/controller/experience_controller.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/screens/create_Profile/mood_form.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

final expController = Get.find<ExperienceController>();

class ExperienceForm extends StatefulWidget {
  final List<Interests> my_selected_interests;

  const ExperienceForm({Key key, this.my_selected_interests}) : super(key: key);

  @override
  _ExperienceFormState createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  var bgClr = Colors.transparent;
  var borderClr = KWhiteColor.withOpacity(0.2);
  List<Experience> exprience = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Obx(() {
        if (expController.isLoading.value)
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
                  text: "Do you experience any of the following?",
                  size: 24.0,
                  align: "left",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "(select as many as necessary)",
                  style: TextStyle(
                    fontSize: 12,
                    color: KLightGreyColor,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                //Diseases
                Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: expController.experienceList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (!exprience.contains(
                                  expController.experienceList[index])) {
                                exprience
                                    .add(expController.experienceList[index]);
                              } else {
                                var ind = exprience.indexOf(
                                    expController.experienceList[index]);
                                exprience.removeAt(ind);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 16, bottom: 12),
                            decoration: BoxDecoration(
                              color: exprience.contains(
                                      expController.experienceList[index])
                                  ? KWhiteColor.withOpacity(0.4)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(
                                color: borderClr,
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                "${expController.experienceList[index].name}",
                                style: TextStyle(
                                  color: KWhiteColor,
                                  fontSize: 13,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        );
                      },

                      //   expController.experienceList.length, (index) {
                      //
                      // }
                    )),

                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    yellowButton(
                        "NEXT",
                        100.0,
                        MoodForm(
                          myInterest: widget.my_selected_interests,
                          myExperience: exprience,
                        )),
                  ],
                ),
              ],
            ),
          );
      })),
    );
  }
}
