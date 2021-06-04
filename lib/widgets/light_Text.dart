import 'package:flutter/material.dart';
import 'package:vinto/helper/constant.dart';

class LightText extends StatelessWidget {
  var text,align;
  //provide value in double
  var size;
  var leftAlign = TextAlign.left;
  var center = TextAlign.center;

  LightText({
    this.text,
    this.size,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontSize: size,
        color: KWhiteColor.withOpacity(0.6),
        height: 1.4,
      ),
      textAlign: align == "center" ? align = center : align = leftAlign,
    );
  }
}
