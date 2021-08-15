import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';

class PopularItemSizeWidget extends StatefulWidget {
  final dynamic price;
  PopularItemSizeWidget({Key key, this.price}) : super(key: key);

  @override
  _PopularItemSizeWidgetState createState() => _PopularItemSizeWidgetState();
}

class _PopularItemSizeWidgetState extends State<PopularItemSizeWidget> {
  int _active = 0;

  var horz_block = SizeConfig.safeBlockHorizontal;
  var width = SizeConfig.screenWidth;
  // ignore_for_file: non_constant_identifier_names
  var vert_block = SizeConfig.safeBlockVertical;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _active = 0;
            });
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: horz_block * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: _active == 0 ? Mycolors.green : Mycolors.graytext)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1/8th OZ',
                    style: TextStyle(
                        fontSize: vert_block * 1.4, color: Mycolors.graytext),
                  ),
                  Text(
                    '\$${widget.price}',
                    style: TextStyle(
                        fontSize: vert_block * 1.4, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _active = 1;
            });
          },
          child: Container(
            height: vert_block * 4,
            padding: EdgeInsets.symmetric(horizontal: horz_block * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: _active == 1 ? Mycolors.green : Mycolors.graytext)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1/4th OZ',
                    style: TextStyle(
                        fontSize: vert_block * 1.4, color: Mycolors.graytext),
                  ),
                  Text(
                    '\$70',
                    style: TextStyle(
                        fontSize: vert_block * 1.4, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _active = 2;
            });
          },
          child: Container(
            height: vert_block * 4,
            padding: EdgeInsets.symmetric(horizontal: horz_block * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: _active == 2 ? Mycolors.green : Mycolors.graytext)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1/2 OZ',
                    style: TextStyle(
                        fontSize: vert_block * 1.4, color: Mycolors.graytext),
                  ),
                  Text(
                    '\$70',
                    style: TextStyle(
                        fontSize: vert_block * 1.4, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
