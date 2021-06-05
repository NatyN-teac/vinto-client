import 'package:flutter/material.dart';
import 'package:vinto/helper/constant.dart';
import 'package:vinto/model/experience.dart';

class Diseases extends StatefulWidget {
  final Experience dName;

  Diseases({
    this.dName,
  });

  @override
  _DiseasesState createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  List<Experience> expriance = [];
  var bgClr = Colors.transparent;
  var borderClr = KWhiteColor.withOpacity(0.2);

  void selectedItems() {
    setState(() {
      expriance.add(widget.dName);
      bgClr == Colors.transparent
          ? bgClr = KWhiteColor.withOpacity(0.4)
          : bgClr = Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectedItems,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 12),
        decoration: BoxDecoration(
          color: bgClr,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: borderClr,
          ),
        ),
        child: FittedBox(
          child: Text(
            "${widget.dName.name}",
            style: TextStyle(
              color: KWhiteColor,
              fontSize: 13,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
