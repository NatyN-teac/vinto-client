import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:vinto/controller/auth_controller.dart';
import 'package:vinto/helper/constant.dart';
import 'package:vinto/screens/register/sign_In.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/text_Field.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthController authController = AuthController();
  GlobalKey<FormState> _regForm = new GlobalKey<FormState>();
  TextEditingController locationController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Position mylocation;

  getPosition() async {
    mylocation = await _determinePosition();
    print("data of location : $mylocation");
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: mainBg,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            children: [
              Container(
                margin: EdgeInsets.only(top: 60, bottom: 20, left: 18),
                child: Text(
                  "Sign up for Near To Me",
                  style: TextStyle(
                    color: KWhiteColor,
                    fontSize: 26,
                  ),
                ),
              ),
              Form(
                key: _regForm,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/personal.png",
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: Get.width * 0.7,
                          child: MyTextField(
                            controller: fullNameController,
                            hintText: "User Name",
                            obSecure: false,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/location.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: Get.width * 0.7,
                            child: MyTextField(
                              controller: locationController,
                              hintText: "Location",
                              obSecure: false,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/country.png",
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: Get.width * 0.7,
                          child: MyTextField(
                            controller: countryController,
                            hintText: "Country",
                            obSecure: false,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/gmail.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: Get.width * 0.7,
                            child: MyTextField(
                              controller: emailController,
                              hintText: "Email",
                              obSecure: false,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/lock.png",
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: Get.width * 0.7,
                          child: MyPasswordField(
                            controller: passwordController,
                            hintText: "Password",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    // ignore: deprecated_member_use
                    Column(
                      children: [
                        Container(
                          width: Get.width * 0.8,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  KWhiteColor,
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 13),
                                )),
                            onPressed: () {
                              var username =
                                  fullNameController.value.text.trim();
                              var location =
                                  locationController.value.text.trim();
                              // var country = countryController.value.text.trim();
                              var email = emailController.value.text.trim();
                              var password =
                                  passwordController.value.text.trim();
                              if (_regForm.currentState.validate()) {
                                var data = {
                                  "username": username,
                                  "password": password,
                                  "place": location,
                                  "email": email,
                                  "user_type": "client",
                                  "location": {
                                    "types": "Point",
                                    "coordinates": [
                                      mylocation?.latitude,
                                      mylocation?.longitude
                                    ]
                                  }
                                };
                                authController.register(context, data);
                              }

                              // Get.to(Profile_Intro())
                            },
                            child: Text("Sign Up", style: buttonText),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(SignIn());
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Gill Sans',
                      fontSize: 14,
                      color: KWhiteColor,
                    ),
                    children: [
                      TextSpan(
                        text: "Already have an account?",
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: KWhiteColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    width: Get.width * 0.8,
                    child: LightText(
                      size: 13.0,
                      text:
                          "By using Near To Me, you agree to the Terms, Cookie Policy and Privacy Policy",
                      align: "center",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
