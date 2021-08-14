import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/register/sign_In.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/cart/service.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';
import 'package:vinto/utils/ui/essentials.dart';
import 'package:vinto/widgets/loader.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use
final _appstate = getIt.get<AppState>();

final _cartService = new CartServices();

class Cartscreen extends StatefulWidget {
  final Product product;

  const Cartscreen({Key key, this.product}) : super(key: key);
  @override
  _CartscreenState createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  // final CheckoutController checkoutController = CheckoutController.to;
  String email;
  String username;
  int _qty = 1;
  bool _loading = false;
  bool _added = false;

  getUser() async {
    setState(() {
      // email = _appstate.state.profile.email;
      // username = _appstate.state.profile.client.username;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future checkOutProduct() async {
    setState(() {
      _loading = true;
    });

    final _result = await _cartService
        .addToCart({"product": widget.product.sId, "quantity": _qty});

    _result.fold((l) {
      Get.snackbar('Cart Error', l.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Mycolors.green,
          colorText: Colors.white);
    }, (r) {
      setState(() {
        _added = true;
      });
      Get.snackbar('Success', "Item added to cart",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Mycolors.green,
          colorText: Colors.white);
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var vert_block = SizeConfig.safeBlockVertical;
    var horz_block = SizeConfig.safeBlockHorizontal;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Product',
          style: TextStyle(
              fontSize: vert_block * 2.2,
              fontFamily: 'Gill medium',
              color: Mycolors.blacktext,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${ApiEndPoints.IMAGE_URL}/${widget.product.image}',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider,
                                colorFilter: ColorFilter.mode(
                                    Colors.black45.withOpacity(0.3),
                                    BlendMode.darken)),
                          ),
                          width: width - 1,
                          height: (height / 2) - 1,
                        ),
                        placeholder: (context, url) => shimmerLoader(
                            width: width - 1,
                            height: (height / 2) - 1,
                            circle: false),
                        errorWidget: (context, url, error) => Container(
                            decoration:
                                BoxDecoration(shape: BoxShape.rectangle),
                            height: height - 1,
                            width: width - 1,
                            child: Icon(Icons.error)),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 20,
                        child: Text(
                          'My Cart',
                          style: TextStyle(
                            fontSize: vert_block * 2.5,
                            color: Colors.white,
                            //  fontWeight: FontWeight.w700
                          ),
                        ),
                      )
                    ],
                  )

                  // Container(
                  //   width: width,
                  //   height: height / 2,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: NetworkImage(
                  //              ),
                  //           fit: BoxFit.cover,

                  //               )),
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: horz_block * 6,
                  //         vertical: horz_block * 10),
                  //     child:
                  //   ),
                  // ),

                  ,
                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: horz_block * 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: vert_block * 2,
                        ),
                        // Text(
                        //   '$username',
                        //   style: TextStyle(
                        //     fontSize: vert_block * 2.2,
                        //     color: Mycolors.blacktext3,
                        //     // fontWeight: FontWeight.w700
                        //   ),
                        // ),
                        // Text(
                        //   'Visa Debit ********6051',
                        //   style: TextStyle(
                        //     fontSize: vert_block * 2.1,
                        //     color: Mycolors.graytext,
                        //     // fontWeight: FontWeight.w700
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: vert_block * 4,
                        // ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ' ${widget.product.name}',
                              style: TextStyle(
                                fontSize: vert_block * 1.7,
                                color: Colors.black,
                                //fontWeight: FontWeight.w700
                              ),
                            ),

                            Spacer(),

                            IconButton(
                                color: Mycolors.green,
                                onPressed: _qty == 1
                                    ? null
                                    : () {
                                        setState(() {
                                          _qty--;
                                        });
                                      },
                                icon: Icon(Icons.minimize)),

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)),
                              child: Center(
                                child: Text(
                                  '$_qty',
                                  style: TextStyle(
                                    fontSize: vert_block * 1.7,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ),

                            IconButton(
                                color: Mycolors.green,
                                onPressed: () {
                                  setState(() {
                                    _qty++;
                                  });
                                },
                                icon: Icon(Icons.add))

                            // Form(
                            //   key: _qtyKey,
                            //   child: Container(
                            //     width: 40,
                            //     child: TextFormField(
                            //       keyboardType: TextInputType.number,
                            //       controller: quantityController,
                            //       validator: (x) {
                            //         if (int.parse(x) < 1) {
                            //           return "err";
                            //         } else if (x.isEmpty) {
                            //           return "err";
                            //         }

                            //         return null;
                            //       },
                            //       style: TextStyle(
                            //           color: Colors.black45,
                            //           fontWeight: FontWeight.bold),
                            //       decoration: InputDecoration(
                            //         hintStyle: TextStyle(
                            //           fontSize: 17,
                            //           color: Colors.black45,
                            //           height: 1.3,
                            //         ),
                            //         border: UnderlineInputBorder(
                            //           borderSide: BorderSide(
                            //             color: Colors.grey.withOpacity(0.5),
                            //           ),
                            //         ),
                            //         enabledBorder: UnderlineInputBorder(
                            //           borderSide: BorderSide(
                            //             color: Colors.grey.withOpacity(0.5),
                            //           ),
                            //         ),
                            //         focusedBorder: UnderlineInputBorder(
                            //           borderSide: BorderSide(
                            //             color: Colors.grey.withOpacity(0.5),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(widget.product.description ?? ""),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            // alignment: Alignment.bottomCenter,
            child: _added
                ? Container()
                : InkWell(
                    onTap: _loading
                        ? () {}
                        : () {
                            getIt.get<AppState>().state.auth
                                ? checkOutProduct()
                                : Get.to(SignIn());
                          },
                    child: Container(
                      width: width,
                      height: vert_block * 6,
                      color: Mycolors.green,
                      child: Center(
                        child: _loading
                            ? Loader(
                                color: Colors.white,
                              )
                            : Text(
                                getIt.get<AppState>().state.auth
                                    ? 'ADD TO CART'
                                    : 'SIGN IN TO SHOP',
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
    );
  }
}
