import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/controller/checkout_controller.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/Edit_cart_screen/edit_cart.dart';
import 'package:vinto/services/api_url.dart';
// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class Cartscreen extends StatefulWidget {
  final Product product;

  const Cartscreen({Key key, this.product}) : super(key: key);
  @override
  _CartscreenState createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  final CheckoutController checkoutController = CheckoutController.to;
  String email;
  String username;
  TextEditingController quantityController;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.get('username');
      username = prefs.get('email');
    });
  }

  @override
  void initState() {
    getUser();
    quantityController = new TextEditingController(text: "1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var vert_block = SizeConfig.safeBlockVertical;
    var horz_block = SizeConfig.safeBlockHorizontal;
    return Scaffold(
      body: widget.product == null
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.15,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    child: Text("No product found in Cart."),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                width: width,
                height: height,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height / 2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${ApiEndPoints.IMAGE_URL}/${widget.product.image}'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black45.withOpacity(0.25),
                                  BlendMode.darken))),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horz_block * 6,
                            vertical: horz_block * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    )),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Editcart()));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '$email',
                              style: TextStyle(
                                fontSize: vert_block * 2,
                                color: Colors.white,
                                //  fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(
                              height: vert_block,
                            ),
                            Text(
                              'My Cart',
                              style: TextStyle(
                                fontSize: vert_block * 2.5,
                                color: Colors.white,
                                //  fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: horz_block * 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: vert_block * 2,
                          ),
                          Text(
                            '$username',
                            style: TextStyle(
                              fontSize: vert_block * 2.2,
                              color: Mycolors.blacktext3,
                              // fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            'Visa Debit ********6051',
                            style: TextStyle(
                              fontSize: vert_block * 2.1,
                              color: Mycolors.graytext,
                              // fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(
                            height: vert_block * 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Product/s',
                                style: TextStyle(
                                    fontSize: vert_block * 2,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'QTY',
                                style: TextStyle(
                                    fontSize: vert_block * 2,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: vert_block,
                          ),
                          Container(
                            width: width,
                            height: 2,
                            color: Mycolors.background,
                          ),
                          SizedBox(
                            height: vert_block * 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' ${widget.product.name}',
                                style: TextStyle(
                                  fontSize: vert_block * 1.7,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w700
                                ),
                              ),
                              Container(
                                width: 40,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: quantityController,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black45,
                                      height: 1.3,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: vert_block * 2,
                          ),
                          Container(
                            width: width,
                            height: 2,
                            color: Mycolors.background,
                          ),
                          SizedBox(
                            height: vert_block * 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          checkoutController.orderProduct(
                              context,
                              widget.product.sId,
                              quantityController.value.text.trim());
                        },
                        child: Container(
                          width: width,
                          height: vert_block * 6,
                          color: Mycolors.green,
                          child: Center(
                            child: Text(
                              'CHECK OUT',
                              style: TextStyle(
                                fontSize: vert_block * 2,
                                color: Colors.white,
                                //  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
