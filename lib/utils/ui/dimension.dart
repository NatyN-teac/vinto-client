import 'package:flutter/material.dart';

double calculateDimension(BuildContext context,
    {@required bool isHeight, @required double percent}) {
  Size size = MediaQuery.of(context).size;
  return isHeight ? size.height * percent : size.width * percent;
}
