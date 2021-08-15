import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/controller/auth_controller.dart';
import 'package:vinto/helper/constant.dart';
import 'package:vinto/screens/register/sign_up.dart';
import 'package:vinto/widgets/light_Text.dart';
import 'package:vinto/widgets/text_Field.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _loginKey = new GlobalKey<FormState>();
  final AuthController authController = AuthController.to;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            iconSize: 30,
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        decoration: mainBg,
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: 20),
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Near To Me\n Delivery",
              style: TextStyle(
                  color: KWhiteColor,
                  fontSize: 35,
                  // height: 1.5,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "High quality goods,\ndelivered to your doorstep.",
              style: TextStyle(
                color: KWhiteColor,
                fontSize: 18,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _loginKey,
              child: Column(
                children: [
                  MyTextField(
                    controller: usernameController,
                    hintText: "yourname@email.com",
                    obSecure: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyPasswordField(
                    controller: passwordController,
                    hintText: "Password",
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(KWhiteColor),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 13),
                        )),
                    onPressed: () {
                      if (_loginKey.currentState.validate()) {
                        var username = usernameController.value.text.trim();
                        var password = passwordController.value.text.trim();
                        authController.login(context, username, password);
                      }
                    },
                    child: Text("Sign In", style: buttonText),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {},
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
                      text: "Forgot Password?  ",
                    ),
                    TextSpan(
                      text: " Reset it here.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
            GestureDetector(
              onTap: () {
                Get.to(SignUp());
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
                      text: "Don't have an Account?",
                    ),
                    TextSpan(
                      text: "   Sign up",
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
            LightText(
              size: 13.0,
              text:
                  "By using Near to Me Delivery, you agree to the Terms, Cookie Policy and Privacy Policy",
              align: "center",
            ),
          ],
        ),
      ),
    );
  }
}
