import 'package:get/get.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';

Widget yellowButton(var txt, var wid, var pageName) {
  return TextButton(
    onPressed: () => Get.off(pageName),
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
        backgroundColor: MaterialStateProperty.all(KYellowColor)),
    child: Padding(
      padding: EdgeInsets.only(top: 4),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 13,
          color: KWhiteColor,
          letterSpacing: 0.2,
        ),
      ),
    ),
  );
}
