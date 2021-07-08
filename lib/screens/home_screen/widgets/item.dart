import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/cart_screen/cart.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/utils/ui/essentials.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

class Fooditem extends StatefulWidget {
  final Product product;

  const Fooditem({Key key, this.product}) : super(key: key);
  @override
  _FooditemState createState() => _FooditemState();
}

class _FooditemState extends State<Fooditem> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var vert_block = SizeConfig.safeBlockVertical;
    var horz_block = SizeConfig.safeBlockHorizontal;
    return GestureDetector(
      onTap: () {
        Get.to(Cartscreen(
          product: widget.product,
        ));
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: networkImageLoader(
                  url: '${ApiEndPoints.IMAGE_URL}/${widget.product.image}',
                  width: horz_block * 42,
                  height: vert_block * 20,
                )),
            SizedBox(
              height: 3,
            ),
            Text(
              '${widget.product.name}',
              style: TextStyle(
                fontSize: vert_block * 1.6,
                fontFamily: 'SF semi',
                color: Mycolors.blacktext,
                //fontWeight: FontWeight.w700
              ),
            ),
            Text(
              'Starts from \$ ${widget.product.price}',
              style: TextStyle(
                fontSize: vert_block * 1.5,
                //fontFamily: 'SF semi',
                color: Mycolors.graytext,
                //fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      ),
    );
  }
}
