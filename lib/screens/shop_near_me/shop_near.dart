import 'package:flutter/material.dart';
import 'package:vinto/data/blocs/product/nearby-products.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/home_screen/widgets/item.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

final _nearby = getIt.get<NearbyBloc>();

class Shopnearscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _nearby.getOrders(reload: true);
    SizeConfig().init(context);

    var vert_block = SizeConfig.safeBlockVertical;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Deals Near Me',
          style: TextStyle(
              fontSize: vert_block * 2.2,
              fontFamily: 'Gill medium',
              color: Mycolors.blacktext,
              fontWeight: FontWeight.w700),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => Dispancryfacing()));
      //   },
      //   backgroundColor: Colors.white,
      //   child: Icon(
      //     Icons.invert_colors_on_sharp,
      //     color: Mycolors.green,
      //   ),
      // ),
      body: StreamBuilder<ProductState>(
        stream: _nearby.nearbyStream,
        builder: (BuildContext context, snapshot) {
          if (_nearby.nearby.status == LoadingState.loading) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                  width: 30,
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('loading products'),
                )
              ]),
            );
          } else {
            return _nearby.nearby.data.fold(
              (l) => Center(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(
                    Icons.error_outlined,
                    color: Colors.amber,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(l.message),
                  ),
                  TextButton(
                      onPressed: () => _nearby.getOrders(reload: true),
                      child: Text('retry'))
                ]),
              ),
              (r) => r.isEmpty
                  ? Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Icon(
                          Icons.gps_fixed,
                          color: Colors.greenAccent,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text("No Product found around your location."),
                        )
                      ]),
                    )
                  : Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.8,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: r.length,
                                itemBuilder: (context, index) {
                                  Product product = r[index];
                                  return Fooditem(
                                    product: product,
                                  );
                                }),
                            SizedBox(
                              height: vert_block,
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          }
        },
      ),
    );
  }
}
