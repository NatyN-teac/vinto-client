import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vinto/data/blocs/product/popular.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/popular_in_your_area/widget/items.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

final _homeBloc = getIt.get<PopularBloc>();

class Popularscreen extends StatefulWidget {
  @override
  _PopularscreenState createState() => _PopularscreenState();
}

class _PopularscreenState extends State<Popularscreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    _homeBloc.getPopular();
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var vert_block = SizeConfig.safeBlockVertical;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Popular in your Area',
          style: TextStyle(
              fontSize: vert_block * 2.2,
              fontFamily: 'Gill medium',
              color: Mycolors.blacktext,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: StreamBuilder<ProductState>(
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
                                      _homeBloc.getPopular(reload: true);
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
                                      _homeBloc.getPopular(reload: true);
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                            return Popularitems(
                              product: i,
                            );
                          });
                });
              }
            },
          )),
    );
  }
}
