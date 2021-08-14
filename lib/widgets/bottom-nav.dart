import 'package:flutter/material.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/screens/Search_screen/search.dart';
import 'package:vinto/screens/cart_screen/main-cart-screen.dart';
import 'package:vinto/screens/home_screen/home.dart';
import 'package:vinto/screens/result_screen/Result.dart';
import 'package:vinto/screens/shop_near_me/shop_near.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

final _appstate = getIt.get<AppState>();

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _appstate.state.auth
        ? _AuthenticatedBottomNav()
        : _PublicBottomNav();
  }
}

class _AuthenticatedBottomNav extends StatelessWidget {
  const _AuthenticatedBottomNav({Key key}) : super(key: key);

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
                Icon(Icons.history)
              ]),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              RecomendedScreen(),
              Shopnearscreen(),
              Searchscreen(),
              MainCartScreen(),
              Resultscreen()
            ],
          )),
    );
  }
}

class _PublicBottomNav extends StatelessWidget {
  _PublicBottomNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              ]),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              RecomendedScreen(),
              Shopnearscreen(),
              Searchscreen(),
            ],
          )),
    );
  }
}
