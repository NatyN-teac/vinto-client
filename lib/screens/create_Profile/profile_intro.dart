import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:vinto/screens/create_Profile/create_profile.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/location_Pin.dart';
import 'package:vinto/widgets/yellow_NextButton.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

final _appstate = getIt.get<AppState>();

class Profile_Intro extends StatefulWidget {
  const Profile_Intro({
    Key key,
  }) : super(key: key);
  @override
  _Profile_IntroState createState() => _Profile_IntroState();
}

class _Profile_IntroState extends State<Profile_Intro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: mainBg,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                    "Hi, ${_appstate.state.profile.client.username} ! 👋\nBefore we get started,",
                size: 24.0,
                align: "left",
              ),
              SizedBox(
                height: 20,
              ),
              LightText(
                text:
                    "help us get to know you better by putting together a profile for you based on:",
                size: 24.0,
                align: "left",
              ),
              SizedBox(
                height: 20,
              ),
              LightText(
                text:
                    "your preferred tastes,\nyour wellness goals,\nand your interests",
                size: 24.0,
                align: "left",
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  yellowButton("LET'S GO", 140.0, Create_Profile()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
