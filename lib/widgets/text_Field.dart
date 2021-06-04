import 'package:flutter/material.dart';
import 'package:vinto/helper/constant.dart';

class MyTextField extends StatelessWidget {
  var hintText;
  bool obSecure = false;
  TextEditingController controller;

  MyTextField({
    this.hintText,
    this.obSecure,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     validator: (v) {
       if(v.isEmpty) {
         return "Field must have value";
       }else return null;
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
  var hintText;
  bool obSecure = true;
  bool obSecureIcon = true;
  TextEditingController controller;

  MyPasswordField({
    this.hintText,
    this.controller
  });

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  void showText() {
    setState(() {
      widget.obSecure = !widget.obSecure;
      widget.obSecureIcon = !widget.obSecureIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v){
        if(v.length < 6){
          return "Password should be atleast 6 character";
        }else return null;
      },
      controller: widget.controller,
      obscureText: widget.obSecure,
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
            visible: widget.obSecureIcon,
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
