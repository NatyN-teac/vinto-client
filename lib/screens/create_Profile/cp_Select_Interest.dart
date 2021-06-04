import 'package:get/get.dart';
import 'package:vinto/controller/interest_controller.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/create_profile_model.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/screens/create_Profile/cp_Select_Interest_2.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/widgets/diseases/diseases.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';

import 'cp_Select_Interest_1.dart';

class CPSelectInterest extends StatefulWidget {
  @override
  _CPSelectInterestState createState() => _CPSelectInterestState();
}

class _CPSelectInterestState extends State<CPSelectInterest> {
  final InterestController interestController = Get.put(InterestController());
  List<Interests> interstSelected = [];

  @override
  Widget build(BuildContext context) {
    print("int: ${interestController.interestsList}");
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (interestController.isLoading.value)
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
                  TextField(
                    autofocus: false,
                    cursorColor: KWhiteColor,
                    style: TextStyle(
                      fontSize: 17,
                      color: KWhiteColor,
                      height: 1.3,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: KWhiteColor.withOpacity(0.9),
                        height: 1.3,
                      ),
                      hintText: "Choose a few interests...",
                      border: InputBorder.none,
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  LightText(
                    text: "Popular Keywords",
                    size: 15.0,
                    align: "left",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 10),
                          decoration: BoxDecoration(
                            color: KWhiteColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: KWhiteColor.withOpacity(0.4),
                            ),
                          ),
                          child: FittedBox(
                            child: Text(
                              "Camping",
                              style: TextStyle(
                                color: KWhiteColor,
                                fontSize: 13,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            color: KWhiteColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: KWhiteColor.withOpacity(0.4),
                            ),
                          ),
                          child: FittedBox(
                            child: Text(
                              "Music",
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
                  SizedBox(
                    height: 50,
                  ),
                  //Diseases
                  Text(
                    "Select up to 5",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                 interstSelected != null ? Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: interstSelected.toSet().toList().length,
                        itemBuilder: (context,index){
                        var item = interstSelected.toSet().toList();
                      return Container(
                        padding: const EdgeInsets.all(2),
                          child: Text("${item[index].name},",
                            style: TextStyle(fontSize: 13,color: Colors.white),));
                    }),
                  ) : Container(),
                  SizedBox(height: 10,),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: interestController.interestsList.length,
                      itemBuilder: (context, index) {
                        Interests I = interestController.interestsList[index];
                        return GestureDetector(
                          onTap: () {
                            // print("hello naow");
                            setState(() {
                              interstSelected.add(
                                  interestController.interestsList[index]);
                            });
                          },
                          onDoubleTap: (){
                            if(interstSelected.contains(I)){
                              setState(() {
                                interstSelected.remove(I);
                              });
                            }
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              color:  KWhiteColor.withOpacity(0.1),
                              // color: KWhiteColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  "${ApiEndPoints.IMAGE_URL}/${I.picture}",
                                  height: 30,
                                ),
                                Text(
                                  I.name.toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: KWhiteColor),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        yellowButton("NEXT", 100.0, CPSelectInterest_1(
                          my_selected_interests: interstSelected,)),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }),
      ),
    );
  }
}
