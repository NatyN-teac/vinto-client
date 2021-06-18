import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vinto/screens/create_Profile/cp_Select_Interest.dart';
import 'package:vinto/screens/create_Profile/cp_Select_Interest_1.dart';
import 'package:vinto/screens/create_Profile/cp_Select_Interest_2.dart';
import 'package:vinto/screens/create_Profile/cp_Taste.dart';
import 'package:vinto/screens/create_Profile/create_profile.dart';
import 'package:vinto/screens/create_Profile/profile_intro.dart';
import 'package:vinto/screens/loading/loading_Screen.dart';
import 'package:vinto/screens/register/sign_In.dart';
import 'package:vinto/screens/register/sign_up.dart';
import 'package:vinto/screens/splash_screen.dart';
import 'package:vinto/utils/di/get_it_config.dart';
import 'helper/constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51J0mHVCLaMRkYtM5S3H0HwtuzeNWJfdPltE0rJ7mq7j4MazYxsgtkS84Q6VS2yKlcaXwBGx8580cQff0579xTZwp00NLmFXPwc";

  initInjector();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        fontFamily: 'Gill Sans',
        accentColor: KWhiteColor.withOpacity(0.5),
        buttonTheme: ButtonThemeData(
          height: 36,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      initialRoute: 'splash_screen',
      home: PaymentScreen(),
      getPages: [
        GetPage(name: 'splash_screen', page: () => SplashScreen()),
        GetPage(name: 'sign_up', page: () => SignUp()),
        GetPage(name: 'sign_In', page: () => SignIn()),
        GetPage(name: 'profile_intro', page: () => Profile_Intro()),
        GetPage(name: 'create_profile', page: () => Create_Profile()),
        GetPage(name: 'cp_Select_Interest', page: () => CPSelectInterest()),
        GetPage(name: 'cp_Select_Interest_1', page: () => CPSelectInterest_1()),
        GetPage(name: 'cp_Select_Interest_2', page: () => CPSelectInterest_2()),
        GetPage(name: 'loading_Screen', page: () => Loading()),
        GetPage(name: 'cp_Taste', page: () => CP_Taste()),
      ],
    );
  }
}

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: CardField(
          onCardChanged: (card) {
            print(card);
          },
        ),
      ),
    );
  }
}
