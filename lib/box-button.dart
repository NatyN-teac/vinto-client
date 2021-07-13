import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/utils/ui/dimension.dart';
import 'package:vinto/widgets/loader.dart';

class BoxButton extends StatelessWidget {
  final String lable;
  final VoidCallback onPressed;
  final bool loading;

  BoxButton({
    Key key,
    this.lable,
    this.onPressed,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        width: calculateDimension(context, isHeight: false, percent: 0.7),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: CupertinoButton(
          disabledColor: Mycolors.green.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          color: Mycolors.green,
          child: loading
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: Center(
                    child: Loader(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  lable,
                  style: TextStyle(
                      fontFamily: 'Overpass',
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
          onPressed: loading ? null : onPressed,
        ));
  }
}
