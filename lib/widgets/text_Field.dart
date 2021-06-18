import 'package:flutter/material.dart';
import 'package:vinto/helper/constant.dart';

class MyTextField extends StatelessWidget {
  final hintText;
  final bool obSecure;
  final TextEditingController controller;

  MyTextField({this.hintText, this.obSecure = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v.isEmpty) {
          return "Field must have value";
        } else
          return null;
      },
      controller: controller,
      obscureText: obSecure,
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
          color: KWhiteColor,
          height: 1.3,
        ),
        hintText: "$hintText",
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KWhiteColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KWhiteColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KWhiteColor,
          ),
        ),
      ),
    );
  }
}

class MyPasswordField extends StatefulWidget {
  final hintText;
  final TextEditingController controller;

  MyPasswordField({this.hintText, this.controller});

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool obSecure = true;
  bool obSecureIcon = true;
  void showText() {
    setState(() {
      obSecure = !obSecure;
      obSecureIcon = !obSecureIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v.length < 6) {
          return "Password should be atleast 6 character";
        } else
          return null;
      },
      controller: widget.controller,
      obscureText: obSecure,
      cursorColor: KWhiteColor,
      style: TextStyle(
        fontSize: 17,
        color: KWhiteColor,
        height: 1.3,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: showText,
          child: Visibility(
            visible: obSecureIcon,
            child: Icon(
              Icons.visibility,
              color: KWhiteColor,
              size: 20,
            ),
            replacement: Icon(
              Icons.visibility_off,
              color: KWhiteColor,
              size: 20,
            ),
          ),
        ),
        hintStyle: TextStyle(
          fontSize: 17,
          color: KWhiteColor,
          height: 1.3,
        ),
        hintText: "${widget.hintText}",
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KWhiteColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KWhiteColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: KWhiteColor,
          ),
        ),
      ),
    );
  }
}
