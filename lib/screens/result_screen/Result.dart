import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:vinto/data/blocs/order-bloc.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/screens/cart_screen/main-cart-screen.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use
final _order = getIt.get<OrderBloc>();

class Resultscreen extends StatefulWidget {
  @override
  _ResultscreenState createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  void showQr(BuildContext context, String code) {
    showModalBottomSheet(
        isDismissible: true,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.black.withOpacity(0),
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.75,
            builder: (BuildContext context, ScrollController scrollController) {
              return QRVIEWERR(
                code: code,
                controller: scrollController,
              );
            },
          );
        });
  }

  List<Widget> _resolver(BuildContext context) {
    if (_order.orders.status == LoadingState.loading) {
      return [
        SliverFillRemaining(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Mycolors.green,
                  ),
                ),
                width: 30,
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('loading orders'),
              )
            ]),
          ),
        )
      ];
    } else {
      return _order.orders.data.fold(
          (l) => [
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.error_outlined,
                            color: Mycolors.green,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(l.message),
                          ),
                          TextButton(
                              onPressed: () => _order.getOrders(reload: true),
                              child: Text('retry'))
                        ]),
                  ),
                )
              ], (r) {
        return [
          r.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.list_alt,
                            color: Mycolors.green,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text("No Orders"),
                          )
                        ]),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, index) {
                  var _or = r[index];
                  return ListTile(
                    onTap: () {
                      Logger().d(_or.sId + "." + _or.assignedFor.sId);
                      showQr(context, _or.sId + "." + _or.assignedFor.sId);
                    },
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(ApiEndPoints.IMAGE_URL +
                                  "/" +
                                  _or.product.image))),
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "QTY",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(_or.quantity.toString()),
                      ],
                    ),
                    title: Text(_or.product.name),
                    subtitle: Text(_or.product.description),
                  );
                }, childCount: r.length))
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _order.getOrders();
    // var height = SizeConfig.screenHeight;
    // var width = SizeConfig.screenWidth;
    // var vert_block = SizeConfig.safeBlockVertical;
    // var horz_block = SizeConfig.safeBlockHorizontal;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Orders',
          style: TextStyle(
            fontFamily: 'Gill medium',
            fontWeight: FontWeight.bold,
            color: Mycolors.blacktext,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _order.orderStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RefreshIndicator(
              child: CustomScrollView(
                slivers: [..._resolver(context)],
              ),
              onRefresh: () async => await _order.getOrders(reload: true));
        },
      ),
    );
  }
}

// Container(
//         width: width,
//         height: height,
//         color: Colors.white,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 300,
//             ),

//             Text(
//               'Near to Me Delivery',
//               style: TextStyle(
//                   fontSize: vert_block * 2.5,
//                   fontFamily: 'Gill medium',
//                   color: Mycolors.blacktext,
//                   fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//               height: vert_block,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: horz_block * 8),
//               child: Text(
//                 "Your favourite products from your favourite people",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: vert_block * 1.5,
//                     fontFamily: 'Gill medium',
//                     color: Mycolors.graytext,
//                     fontWeight: FontWeight.w700),
//               ),
//             ),
//             SizedBox(
//               height: vert_block * 2,
//             ),
//             SmoothPageIndicator(
//                 controller: _pageController, // PageController
//                 count: 3,
//                 effect: WormEffect(
//                     activeDotColor: Mycolors.blacktext1,
//                     dotColor: Mycolors.graytext.withOpacity(0.6),
//                     radius: 10,
//                     dotHeight: 8,
//                     dotWidth: 8), // your preferred effect
//                 onDotClicked: (index) {}),
//             SizedBox(
//               height: vert_block * 6,
//             ),
//             // Container(
//             //   width: horz_block * 60,
//             //   height: vert_block * 5.6,
//             //   decoration: BoxDecoration(
//             //       color: Mycolors.green,
//             //       borderRadius: BorderRadius.circular(10)),
//             //   child: Center(
//             //     child: Text(
//             //       'Show me the goods',
//             //       style: TextStyle(
//             //         fontSize: vert_block * 2,
//             //         //fontFamily: 'Gill medium',
//             //         color: Colors.white,
//             //         //fontWeight: FontWeight.w700
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             Expanded(child: SizedBox()),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Feeling different?',
//                   style: TextStyle(
//                     fontSize: vert_block * 1.5,
//                     //fontFamily: 'Gill medium',
//                     color: Mycolors.blacktext,
//                     //fontWeight: FontWeight.w700
//                   ),
//                 ),
//                 Text(
//                   '  Start over',
//                   style: TextStyle(
//                     fontSize: vert_block * 1.5,
//                     //fontFamily: 'Gill medium',
//                     color: Mycolors.green,
//                     //fontWeight: FontWeight.w700
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: vert_block * 3,
//             )
//           ],
//         ),
//       ),
