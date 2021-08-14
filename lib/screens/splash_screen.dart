import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/data/blocs/auth-bloc.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';
import 'package:vinto/widgets/bottom-nav.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

final _appstate = getIt.get<AppState>();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _appstate.initAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthState>(
          initialData: new AuthState(fresh: null, token: null),
          stream: _appstate.authStateStream,
          builder: (context, snapshot) {
            if (_appstate.state.state == AuthStateEnum.loading) {
              return _Splash();
            } else {
              return BottomNavWidget();
            }
          }),
    );
  }
}

class _Splash extends StatelessWidget {
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
              "assets/ntmd.png",
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
