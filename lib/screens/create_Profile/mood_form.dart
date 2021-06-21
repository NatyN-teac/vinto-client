import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/model/mood.dart';
import 'package:vinto/screens/create_Profile/taste_form.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';
import 'package:dartz/dartz.dart' as dartz;

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class MoodForm extends StatefulWidget {
  final List<Interests> myInterest;
  final List<Experience> myExperience;

  const MoodForm({Key key, this.myInterest, this.myExperience})
      : super(key: key);
  @override
  _MoodFormState createState() => _MoodFormState();
}

class _MoodFormState extends State<MoodForm> {
  var isChecked = false;
  List<Mood> selectedMood = [];

  bool isLoading = true;
  dartz.Either<BasicFailure, List<Mood>> _result;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getInterests();
    super.initState();
  }

  Future getInterests() async {
    setState(() {
      isLoading = true;
    });
    final _ = await ProfilePreferenceService().getMoods();

    setState(() {
      _result = _;
      isLoading = false;
    });
  }

  List<Widget> _resolver(
    BuildContext context,
  ) {
    if (isLoading) {
      return [
        SliverToBoxAdapter(
            child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('loading moods...'),
            )
          ]),
        ))
      ];
    } else {
      return [
        _result.fold(
            (l) => SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(l.message),
                          ),
                          SizedBox(height: 20),
                          TextButton.icon(
                              onPressed: () {
                                getInterests();
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: Text("retry",
                                  style: TextStyle(color: Colors.white)))
                        ]),
                  ),
                ),
            (r) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                          height: 48,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.transparent,
                            ),
                            child: CheckboxListTile(
                              value: selectedMood.contains(r[index]),
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
                                  value: selectedMood.contains(r[index]),
                                  activeColor: Colors.transparent,
                                  checkColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      if (selectedMood.contains(r[index])) {
                                        isChecked = true;
                                      } else {
                                        isChecked = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                // isChecked = !isChecked;
                                if (value == true) {
                                  setState(() {
                                    isChecked = false;
                                    selectedMood.add(r[index]);
                                  });
                                } else {
                                  setState(() {
                                    isChecked = true;
                                    selectedMood.remove(r[index]);
                                  });
                                }
                              },
                              checkColor: Colors.transparent,
                              activeColor: Colors.transparent,
                              title: Text(
                                "${r[index].name}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: KWhiteColor,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                            ),
                          ));
                    },
                    childCount: r.length,
                  ),
                ))
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: mainBg,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                ],
              ),
            ),
            ..._resolver(context),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  yellowButton(
                      "NEXT",
                      100.0,
                      TasteForm(
                        myExperience: widget.myExperience,
                        myInterest: widget.myInterest,
                        myMood: selectedMood,
                      )),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

class WellnessGoals extends StatefulWidget {
  final goalName;

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
