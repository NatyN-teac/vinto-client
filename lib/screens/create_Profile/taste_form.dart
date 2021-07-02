import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/model/mood.dart';
import 'package:vinto/model/taste.dart';
import 'package:vinto/screens/loading/loading_Screen.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:dartz/dartz.dart' as dartz;

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

class TasteForm extends StatefulWidget {
  final List<Interests> myInterest;
  final List<Experience> myExperience;
  final List<Mood> myMood;

  const TasteForm({Key key, this.myInterest, this.myExperience, this.myMood})
      : super(key: key);

  @override
  _TasteFormState createState() => _TasteFormState();
}

class _TasteFormState extends State<TasteForm> {
  List<Taste> selectedTastes = [];

  bool isLoading = true;
  dartz.Either<BasicFailure, List<Taste>> _result;

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
    final _ = await ProfilePreferenceService().getTastes();

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
            (r) => SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: r
                        .map((e) => GestureDetector(
                              onTap: () {
                                if (!selectedTastes.contains(e) &&
                                    selectedTastes.length < 6) {
                                  setState(() {
                                    selectedTastes.add(e);
                                  });
                                } else {
                                  setState(() {
                                    selectedTastes.remove(e);
                                  });
                                }
                              },
                              child: Container(
                                width: 85,
                                margin:
                                    EdgeInsets.only(bottom: Get.width * 0.015),
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 16, bottom: 12),
                                decoration: BoxDecoration(
                                  //
                                  color: selectedTastes.contains(e)
                                      ? KWhiteColor.withOpacity(0.4)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                    color: selectedTastes.contains(e)
                                        ? KWhiteColor.withOpacity(0.5)
                                        : KWhiteColor.withOpacity(0.2),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${e.name}",
                                    style: TextStyle(
                                      color: KWhiteColor,
                                      fontSize: 13,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                )))
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
                    text:
                        "Which of these taste profile interest you? (pick up to 5)",
                    size: 24.0,
                    align: "left",
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
            ..._resolver(context),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(KYellowColor),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12)),
                    ),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      try {
                        List<String> interstIds =
                            widget.myInterest.map((e) => e.sId).toList();
                        List<String> moodIds =
                            widget.myMood.map((e) => e.sId).toList();
                        List<String> experienceId =
                            widget.myExperience.map((e) => e.sId).toList();
                        List<String> tastId =
                            selectedTastes.map((e) => e.sId).toList();

                        var StringInterst = interstIds.join(',');
                        var StringMood = moodIds.join(',');
                        var StringExperience = experienceId.join(',');
                        var StringTaste = tastId.join(',');

                        pref.setString("interest", StringInterst);
                        pref.setString("mood", StringMood);
                        pref.setString("exp", StringExperience);
                        pref.setString("taste", StringTaste);

                        Get.to(Loading());
                      } catch (e) {
                        print("error: $e");
                      }
                    },
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
