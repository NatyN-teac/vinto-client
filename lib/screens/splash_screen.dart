import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/screens/home_screen/home.dart';
import 'package:vinto/screens/register/sign_In.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      prefs = await SharedPreferences.getInstance();
      var token_stored = prefs.getString("token");

      var tastes = prefs.getString("taste");

      if (token_stored != null && token_stored.isNotEmpty) {
        if (tastes == null) {
          Get.offAll(SignIn());
        }

        if (tastes != null || tastes.isNotEmpty) {
          Get.offAll(Homescreen());
        }
      } else {
        Get.offAll(SignIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splash_small.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Image.asset(
              "assets/logo/vinto white logo.png",
              width: Get.width * 0.6,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          height: 110,
          child: Center(
            child: Text(
              "High quality goods,\ndelivered to your doorstep.",
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
