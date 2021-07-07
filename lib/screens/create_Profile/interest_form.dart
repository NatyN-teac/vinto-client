import 'package:dartz/dartz.dart' as dartz;
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/screens/create_Profile/experience_form.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/utils/ui/essentials.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';

class InterestForm extends StatefulWidget {
  @override
  _InterestFormState createState() => _InterestFormState();
}

class _InterestFormState extends State<InterestForm> {
  List<Interests> interstSelected = [];
  bool isLoading = true;
  dartz.Either<BasicFailure, List<Interests>> _result;

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
    final _ = await ProfilePreferenceService().getInterests();

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
              child: Text('loading interests...'),
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
            (r) => SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (interstSelected.contains(r[index])) {
                            setState(() {
                              interstSelected.remove(r[index]);
                            });
                          } else {
                            setState(() {
                              interstSelected.add(r[index]);
                            });
                          }
                        },
                        onDoubleTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: KWhiteColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: interstSelected.contains(r[index])
                                      ? Colors.white
                                      : Colors.transparent)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              networkImageLoader(
                                  url:
                                      "${ApiEndPoints.IMAGE_URL}/${r[index].picture}",
                                  height: 40,
                                  width: 40),
                              Text(
                                r[index].name.toString(),
                                style:
                                    TextStyle(fontSize: 14, color: KWhiteColor),
                              ),
                            ],
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
                // LightText(
                //   text: "Popular Keywords",
                //   size: 15.0,
                //   align: "left",
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                //       decoration: BoxDecoration(
                //         color: KWhiteColor.withOpacity(0.15),
                //         borderRadius: BorderRadius.circular(9),
                //         border: Border.all(
                //           color: KWhiteColor.withOpacity(0.4),
                //         ),
                //       ),
                //       child: FittedBox(
                //         child: Text(
                //           "Camping",
                //           style: TextStyle(
                //             color: KWhiteColor,
                //             fontSize: 13,
                //             letterSpacing: 0.2,
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Container(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                //       decoration: BoxDecoration(
                //         color: KWhiteColor.withOpacity(0.15),
                //         borderRadius: BorderRadius.circular(9),
                //         border: Border.all(
                //           color: KWhiteColor.withOpacity(0.4),
                //         ),
                //       ),
                //       child: FittedBox(
                //         child: Text(
                //           "Music",
                //           style: TextStyle(
                //             color: KWhiteColor,
                //             fontSize: 13,
                //             letterSpacing: 0.2,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 50,
                // ),
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
              ],
            )),
            // SliverToBoxAdapter(
            //     child: Container(
            //   margin: EdgeInsets.only(bottom: 20),
            //   child: Wrap(
            //     alignment: WrapAlignment.spaceAround,
            //     spacing: 8,
            //     runSpacing: 8,
            //     children: interstSelected
            //         .map((e) => Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 5),
            //             decoration: BoxDecoration(
            //                 color: KWhiteColor,
            //                 borderRadius: BorderRadius.circular(5)),
            //             margin: EdgeInsets.all(5),
            //             child: Text(
            //               "${e.name}",
            //               style: TextStyle(fontSize: 13, color: KDarkGreyColor),
            //             )))
            //         .toList(),
            //   ),
            // )),
            ..._resolver(context),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    yellowButton(
                        "NEXT",
                        100.0,
                        ExperienceForm(
                          my_selected_interests: interstSelected,
                        )),
                    SizedBox(width: 30)
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
