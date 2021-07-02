import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/cart_screen/cart.dart';
import 'package:vinto/services/api_url.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: horz_block * 42,
              height: vert_block * 20,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${ApiEndPoints.IMAGE_URL}/${widget.product.image}',
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: vert_block,
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
