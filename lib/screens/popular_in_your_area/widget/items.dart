import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class Popularitems extends StatefulWidget {
  @override
  _PopularitemsState createState() => _PopularitemsState();
}

class _PopularitemsState extends State<Popularitems> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var vert_block = SizeConfig.safeBlockVertical;
    var horz_block = SizeConfig.safeBlockHorizontal;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horz_block * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: horz_block * 42,
            height: vert_block * 20,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/food.png',
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: vert_block,
          ),
          Text(
            'Veg pizza',
            style: TextStyle(
              fontSize: vert_block * 1.8,
              fontFamily: 'SF semi',
              color: Mycolors.blacktext,
              //fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            'Black Tie Hoover',
            style: TextStyle(
              fontSize: vert_block * 1.6,
              //fontFamily: 'SF semi',
              color: Mycolors.graytext,
              //fontWeight: FontWeight.w700
            ),
          ),
        ],
      ),
    );
  }
}
