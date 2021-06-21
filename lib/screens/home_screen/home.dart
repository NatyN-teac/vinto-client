import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinto/controller/home_controller.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/Search_screen/search.dart';
import 'package:vinto/screens/cart_screen/cart.dart';
import 'package:vinto/screens/home_screen/widgets/item.dart';
import 'package:vinto/screens/popular_in_your_area/popular.dart';
import 'package:vinto/screens/result_screen/Result.dart';
import 'package:vinto/screens/shop_near_me/shop_near.dart';
import 'package:vinto/services/api_url.dart';
// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

final homeController = Get.find<HomeController>();

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          bottomNavigationBar: TabBar(
              indicatorColor: Mycolors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
              unselectedLabelColor: Mycolors.blacktext2,
              labelColor: Mycolors.green,
              labelPadding: EdgeInsets.all(15),
              tabs: [
                Icon(Icons.home_outlined),
                Icon(Icons.gps_fixed),
                Icon(Icons.search),
                Icon(Icons.shopping_cart_outlined),
                Icon(Icons.menu)
              ]),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _HomeScreen(),
              Shopnearscreen(
                nearybyProducts: homeController.nearby,
              ),
              Searchscreen(),
              Cartscreen(),
              Resultscreen()
            ],
          )),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var vert_block = SizeConfig.safeBlockVertical;
    var horz_block = SizeConfig.safeBlockHorizontal;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: vert_block * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 10,
                          color: Colors.red,
                        ),
                        Text(
                          'Delievry',
                          style: TextStyle(
                              fontSize: vert_block * 1.4,
                              color: Mycolors.graytext),
                        )
                      ],
                    ),
                    SizedBox(
                      height: vert_block * 0.4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Birmingham, AL',
                          style: TextStyle(
                              fontSize: vert_block * 2,
                              fontFamily: 'Gill medium',
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    width: horz_block * 8,
                    child: Image.asset('assets/profile.png'))
              ],
            ),
            SizedBox(
              height: vert_block * 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: vert_block * 2.4,
                    fontFamily: 'SF bold',
                    color: Colors.black,
                    //fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                      fontSize: vert_block * 1.8, color: Mycolors.graytext),
                )
              ],
            ),
            SizedBox(
              height: vert_block * 0.6,
            ),
            Text(
              'Based on the your interests',
              style: TextStyle(
                fontSize: vert_block * 1.4,
                fontFamily: 'Gill medium',
                color: Mycolors.graytext,
              ),
            ),
            SizedBox(
              height: vert_block * 1,
            ),
            homeController.recommendedProducts.length == 0
                ? Container(
                    child: Center(
                      child: Text("No product found"),
                    ),
                  )
                : Container(
                    width: width,
                    height: vert_block * 55,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.network(
                          '${ApiEndPoints.IMAGE_URL}/${homeController.recommendedProducts.first.image}',
                          width: vert_block * 30,
                          height: vert_block * 30,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: horz_block * 4),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${homeController.recommendedProducts[0].name}',
                                    style: TextStyle(
                                        fontSize: vert_block * 2.1,
                                        fontFamily: 'Gill medium',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Container(
                                    width: horz_block * 15,
                                    height: vert_block * 1.2,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (_, i) {
                                          return Icon(
                                            Icons.star,
                                            size: 11,
                                            color: Colors.amber,
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: vert_block * 0.8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: horz_block * 27,
                                        height: vert_block * 4,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horz_block * 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Mycolors.green)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '1/8th OZ',
                                                style: TextStyle(
                                                    fontSize: vert_block * 1.4,
                                                    color: Mycolors.green),
                                              ),
                                              Text(
                                                '\$${homeController.recommendedProducts[0].price}',
                                                style: TextStyle(
                                                    fontSize: vert_block * 1.4,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: horz_block,
                                      ),
                                      Container(
                                        width: horz_block * 27,
                                        height: vert_block * 4,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horz_block * 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Mycolors.graytext)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '1/4th OZ',
                                                style: TextStyle(
                                                    fontSize: vert_block * 1.4,
                                                    color: Mycolors.graytext),
                                              ),
                                              Text(
                                                '\$70',
                                                style: TextStyle(
                                                    fontSize: vert_block * 1.4,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: horz_block,
                                      ),
                                      Container(
                                        width: horz_block * 27,
                                        height: vert_block * 4,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horz_block * 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Mycolors.graytext)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '1/2 OZ',
                                                style: TextStyle(
                                                    fontSize: vert_block * 1.4,
                                                    color: Mycolors.graytext),
                                              ),
                                              Text(
                                                '\$70',
                                                style: TextStyle(
                                                    fontSize: vert_block * 1.4,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: vert_block * 1.3,
                        ),
                        SizedBox(
                          height: vert_block * 1.3,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cartscreen(
                                          product: homeController
                                              .recommendedProducts[0],
                                        )));
                          },
                          child: Container(
                            width: width,
                            margin: EdgeInsets.symmetric(
                                horizontal: horz_block * 4),
                            height: vert_block * 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Mycolors.green),
                            child: Center(
                              child: Text(
                                'Order Ahead',
                                style: TextStyle(
                                    fontSize: vert_block * 1.8,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular in your area',
                  style: TextStyle(
                    fontSize: vert_block * 2.4,
                    fontFamily: 'SF bold',
                    color: Colors.black,
                    //fontWeight: FontWeight.w700
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Popularscreen()));
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: vert_block * 1.8, color: Mycolors.graytext),
                  ),
                )
              ],
            ),
            SizedBox(
              height: vert_block * 0.6,
            ),
            Text(
              'The flavor of the week',
              style: TextStyle(
                fontSize: vert_block * 1.4,
                fontFamily: 'Gill medium',
                color: Mycolors.graytext,
              ),
            ),
            SizedBox(
              height: vert_block * 1,
            ),
            homeController.popularProducts.length == 0
                ? Container(
                    child: Center(
                      child: Text("No product found"),
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: homeController.popularProducts.length,
                    itemBuilder: (context, index) {
                      Product I = homeController.popularProducts[index];
                      return Fooditem(
                        product: I,
                      );
                    }),
            SizedBox(
              height: vert_block * 10,
            )
          ],
        ),
      ),
    );
  }
}
