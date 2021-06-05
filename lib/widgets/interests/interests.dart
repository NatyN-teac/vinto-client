import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/helper/constant.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class InterestsWidget extends StatefulWidget {
  final dName;

  InterestsWidget({
    this.dName,
  });

  @override
  _InterestsWidgetState createState() => _InterestsWidgetState();
}

class _InterestsWidgetState extends State<InterestsWidget> {
  var bgClr = Colors.transparent;
  var borderClr = KWhiteColor.withOpacity(0.2);

  void selectedItems() {
    setState(() {
      bgClr == Colors.transparent
          ? bgClr = KWhiteColor.withOpacity(0.4)
          : bgClr = Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectedItems,
      child: Align(
        child: Container(
          width: 85,
          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.015),
          padding: EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 12),
          decoration: BoxDecoration(
            color: bgClr,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: borderClr,
            ),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                "${widget.dName}",
                style: TextStyle(
                  color: KWhiteColor,
                  fontSize: 13,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
