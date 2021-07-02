import 'package:flutter/material.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/data/blocs/location.dart';
import 'package:vinto/data/blocs/product/popular.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/Search_screen/search.dart';
import 'package:vinto/screens/cart_screen/cart.dart';
import 'package:vinto/screens/cart_screen/main-cart-screen.dart';
import 'package:vinto/screens/home_screen/widgets/item.dart';
import 'package:vinto/screens/popular_in_your_area/popular.dart';
import 'package:vinto/screens/result_screen/Result.dart';
import 'package:vinto/screens/shop_near_me/shop_near.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

final _homeBloc = getIt.get<PopularBloc>();
final _appstate = getIt.get<AppState>();
final _location = getIt.get<LocationBloc>();

enum ProfileMenu { logout }

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _homeBloc.init();
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
                Icon(Icons.history)
              ]),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _HomeScreen(),
              Shopnearscreen(),
              Searchscreen(),
              MainCartScreen(),
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
    var vert_block = SizeConfig.safeBlockVertical;

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
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 13,
                            color: Mycolors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Delivery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: vert_block * 1.4,
                                color: Mycolors.graytext),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<LocationLoadingState>(
                        stream: _location.locationStateStream,
                        builder: (BuildContext context, snapshot) {
                          var _ = _location.location;

                          if (_.status == LoadingState.loading) {
                            return Container();
                          } else {
                            return _.place.fold(
                                (l) => TextButton.icon(
                                    onPressed: () {
                                      _location.initLocation();
                                    },
                                    icon: Icon(Icons.restart_alt_rounded),
                                    label: Text("retry")),
                                (r) => Row(
                                      children: [
                                        Text(
                                          '${r.street}, ${r.name}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Gill medium',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          size: 12,
                                        ),
                                      ],
                                    ));
                          }
                        },
                      ),
                    ],
                  ),
                  PopupMenuButton<ProfileMenu>(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      radius: 20,
                      child: Icon(Icons.person),
                    ),
                    onSelected: (ProfileMenu result) async {
                      if (result == ProfileMenu.logout) {
                        await _appstate.logout();
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<ProfileMenu>>[
                      const PopupMenuItem<ProfileMenu>(
                        value: ProfileMenu.logout,
                        child: Text('logout'),
                      ),
                    ],
                  ),
                ],
              ),
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
            _RecommendedWidget(),
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
            _PopularWidget()
          ],
        ),
      ),
    );
  }
}

class _PopularWidget extends StatelessWidget {
  const _PopularWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductState>(
      stream: _homeBloc.recommendedStream,
      builder: (BuildContext context, snapshot) {
        if (_homeBloc.recommended.status == LoadingState.loading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        } else {
          return _homeBloc.recommended.data.fold(
              (l) => Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(l.message),
                          ),
                          SizedBox(height: 20),
                          TextButton.icon(
                              onPressed: () {
                                _homeBloc.getOrders(reload: true);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: Text("retry",
                                  style: TextStyle(color: Colors.white)))
                        ]),
                  ), (r) {
            return r.isEmpty
                ? Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.list_alt_outlined,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(height: 20),
                          Text("No Popular Products"),
                          SizedBox(height: 10),
                          TextButton.icon(
                              onPressed: () {
                                _homeBloc.getOrders(reload: true);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: Text("retry",
                                  style: TextStyle(color: Colors.white)))
                        ]),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.74,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: r.length,
                    itemBuilder: (context, index) {
                      Product i = r[index];
                      return Fooditem(
                        product: i,
                      );
                    });
          });
        }
      },
    );
  }
}

class _RecommendedWidget extends StatelessWidget {
  const _RecommendedWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var horz_block = SizeConfig.safeBlockHorizontal;
    var width = SizeConfig.screenWidth;
    var vert_block = SizeConfig.safeBlockVertical;

    return StreamBuilder<ProductState>(
      stream: _homeBloc.recommendedStream,
      builder: (BuildContext context, snapshot) {
        if (_homeBloc.recommended.status == LoadingState.loading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        } else {
          return _homeBloc.recommended.data.fold(
              (l) => Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(l.message),
                          ),
                          SizedBox(height: 20),
                          TextButton.icon(
                              onPressed: () {
                                _homeBloc.getRecommended(reload: true);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: Text("retry",
                                  style: TextStyle(color: Colors.white)))
                        ]),
                  ), (r) {
            return r.isEmpty
                ? Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.list_alt_outlined,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(height: 20),
                          Text("No Recommeded Products"),
                          SizedBox(height: 10),
                          TextButton.icon(
                              onPressed: () {
                                _homeBloc.getRecommended(reload: true);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: Text("retry",
                                  style: TextStyle(color: Colors.white)))
                        ]),
                  )
                : Container(
                    width: width,
                    height: vert_block * 55,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.network(
                          '${ApiEndPoints.IMAGE_URL}/${r.first.image}',
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
                                    '${r[0].name}',
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
                                                '\$${r[0].price}',
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
                                          product: r[0],
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
                  );
          });
        }
      },
    );
  }
}
