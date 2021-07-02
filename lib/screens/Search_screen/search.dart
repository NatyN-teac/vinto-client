import 'package:flutter/material.dart';
import 'package:vinto/data/blocs/search-bloc.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/home_screen/widgets/item.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:vinto/widgets/loader.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

final _searchBloc = getIt.get<SearchBloc>();

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController _query = new TextEditingController(text: "");
  bool isEmpty = true;

  @override
  void initState() {
    _query = new TextEditingController(text: "")..addListener(_querylistener);
    super.initState();
  }

  void _querylistener() {
    if (_query.text.isNotEmpty) {
      _searchBloc.searchUser(_query.text);

      setState(() {
        isEmpty = false;
      });
    } else {
      setState(() {
        isEmpty = true;
      });
    }
  }

  Widget _suffixWidgets() {
    return !isEmpty
        ? IconButton(
            color: Mycolors.green,
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                _query = new TextEditingController(text: "")
                  ..addListener(_querylistener);
              });
            },
          )
        : Container(height: 1, width: 0);
  }

  Widget searchBar(BuildContext context) {
    return Container(
        height: 48,
        child: TextFormField(
          autofocus: true,
          controller: _query,
          onChanged: (str) {},
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5),
              suffix: _suffixWidgets(),
              hintText: 'Search ...',
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: searchBar(context),
        ),
        body: StreamBuilder<dartz.Either<BasicFailure, List<Product>>>(
          stream: _searchBloc.results,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data;
              return result.fold(
                  (l) => Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.green,
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
                                    setState(() {
                                      _query = new TextEditingController(
                                          text: _query.text)
                                        ..addListener(_querylistener);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.black,
                                  ),
                                  label: Text("retry",
                                      style: TextStyle(color: Colors.black)))
                            ]),
                      ), (r) {
                return r.isEmpty
                    ? Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.list_alt_outlined,
                                color: Colors.green,
                                size: 60,
                              ),
                              SizedBox(height: 20),
                              Text("No Products Found"),
                              SizedBox(height: 10),
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

              // (
              //   (users) => GridView.builder(
              //     itemCount: users.length,
              //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //       maxCrossAxisExtent: 200,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10,
              //       childAspectRatio: 0.8,
              //     ),
              //     itemBuilder: (context, index) {
              //       return GitHubUserSearchResultTile(
              //         user: users[index],
              //         onSelected: (value) => close(context, value),
              //       );
              //     },
              //   ),
              //   error: (error) => SearchPlaceholder(title: errorMessages[error]),
              // );
            } else {
              return Center(child: Loader(color: Mycolors.green));
            }
          },
        ));
  }
}

// SizedBox(
//             height: vert_block * 20,
//           ),
//           Container(
//               width: horz_block * 25,
//               child: Image.asset('assets/search.png')),
//           SizedBox(
//             height: vert_block * 2,
//           ),
//           Text(
//             'Search for a brand, product, \nor dispensary',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: vert_block * 1.8,
//               // fontFamily: 'Gill medium',
//               color: Mycolors.graytext,
//               // fontWeight: FontWeight.w700
//             ),
//           ),
