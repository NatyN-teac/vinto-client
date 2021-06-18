import 'package:flutter/material.dart';

const KWhiteColor = Color(0xffffffff);
const KDarkGreyColor = Color(0xff4A4A4A);
const KLightGreyColor = Color(0xffDADADA);
const KYellowColor = Color(0xffFFC107);

const mainBg = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Color(0xFF62D07C),
    Color(0xFF357C74),
  ],
));

const buttonText = TextStyle(
  fontSize: 14,
  height: 1.0,
  color: KDarkGreyColor,
);
