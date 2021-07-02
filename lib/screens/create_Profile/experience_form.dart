import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/screens/create_Profile/mood_form.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';
import 'package:dartz/dartz.dart' as dartz;

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

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

  bool isLoading = true;
  dartz.Either<BasicFailure, List<Experience>> _result;

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
    final _ = await ProfilePreferenceService().getExperiences();

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
              child: Text('loading experiences...'),
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
                      return GestureDetector(
                        onTap: () {
                          if (exprience.contains(r[index])) {
                            setState(() {
                              exprience.remove(r[index]);
                            });
                          } else {
                            setState(() {
                              exprience.add(r[index]);
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 16, bottom: 12),
                          decoration: BoxDecoration(
                            color: exprience.contains(r[index])
                                ? KWhiteColor.withOpacity(0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: borderClr,
                            ),
                          ),
                          child: Text(
                            "${r[index].name}",
                            style: TextStyle(
                              color: KWhiteColor,
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      );
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
        decoration: mainBg,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  height: 30,
                ),
              ],
            )),
            ..._resolver(context),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  yellowButton(
                      "NEXT",
                      100.0,
                      MoodForm(
                        myInterest: widget.my_selected_interests,
                        myExperience: exprience,
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
