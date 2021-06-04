import 'package:get/get.dart';
import 'package:vinto/helper/constant.dart';
import 'package:flutter/material.dart';

Widget yellowButton(var txt,var wid,var pageName) {
  return FlatButton(
    onPressed: () => Get.to(pageName),
    minWidth: wid,
    color: KYellowColor,
    padding: EdgeInsets.symmetric(vertical: 12),
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
