import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double strokeWidth;

  const Loader({Key key, this.color, this.strokeWidth = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Mycolors.green),
      ),
    );
  }
}
