import 'package:flutter/material.dart';
import 'package:vinto/widgets/light_Text.dart';

Widget locationPin() {
  return Row(
    children: [
      Image.asset(
        'assets/icons/Pin.png',
        height: 12,
      ),
      SizedBox(
        width: 10,
      ),
      LightText(
        align: "left",
        size: 12.0,
        text: "Birmingham",
      ),
    ],
  );
}
