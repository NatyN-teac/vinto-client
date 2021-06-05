import 'package:flutter/material.dart';
import 'package:vinto/helper/constant.dart';

class LightText extends StatelessWidget {
  final text, align;
  final size;
  final leftAlign;

  LightText({
    this.text,
    this.size,
    this.align,
    this.leftAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    var center = TextAlign.center;
    return Text(
      "$text",
      style: TextStyle(
        fontSize: size,
        color: KWhiteColor.withOpacity(0.6),
        height: 1.4,
      ),
      textAlign: align == "center" ? center : leftAlign,
    );
  }
}
