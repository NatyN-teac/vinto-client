import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class Dispancryfacing extends StatefulWidget {
  @override
  _DispancryfacingState createState() => _DispancryfacingState();
}

class _DispancryfacingState extends State<Dispancryfacing> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var vert_block = SizeConfig.safeBlockVertical;
    var horz_block = SizeConfig.safeBlockHorizontal;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Mycolors.background,

          //  Stack(
          //   children: [
          //     Container(
          //       width: width,
          //       height: vert_block * 49,
          //       color: Colors.red,
          //       child: Image.asset(
          //         'assets/disp.png',
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Container(
          //         width: width,
          //         height: vert_block * 60,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(25),
          //                 topRight: Radius.circular(25)),
          //             color: Colors.white),
          //         child: Column(
          //           children: [
          //             Container(
          //               width: width,
          //               height: vert_block * 14,
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: horz_block * 4),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(25),
          //                     topRight: Radius.circular(25)),
          //               ),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   SizedBox(
          //                     height: vert_block * 1.5,
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text(
          //                         'Serra Downtown',
          //                         style: TextStyle(
          //                             fontSize: vert_block * 2.4,
          //                             fontFamily: 'Gill regular',
          //                             color: Mycolors.blacktext1,
          //                             fontWeight: FontWeight.w700),
          //                       ),
          //                       Container(
          //                         width: horz_block * 14,
          //                         height: vert_block * 3,
          //                         padding: EdgeInsets.all(4),
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(20),
          //                           color: Colors.green,
          //                         ),
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           crossAxisAlignment: CrossAxisAlignment.end,
          //                           children: [
          //                             Icon(
          //                               Icons.star,
          //                               color: Colors.white,
          //                               size: 15,
          //                             ),
          //                             Text(
          //                               ' 4.2',
          //                               style: TextStyle(
          //                                 fontSize: vert_block * 1.6,
          //                                 fontFamily: 'Gill regular',
          //                                 color: Colors.white,
          //                                 // fontWeight: FontWeight.w700
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: vert_block,
          //                   ),
          //                   Text(
          //                     'Portland   ·  9AM to 9PM',
          //                     style: TextStyle(
          //                       fontSize: vert_block * 1.5,
          //                       fontFamily: 'helv med',
          //                       color: Mycolors.graytext,
          //                     ),
          //                   ),
          //                   Container(
          //                     width: width,
          //                     height: vert_block * 6,
          //                     color: Colors.white,
          //                     child: TabBar(
          //                         indicatorColor: Mycolors.green,
          //                         indicatorSize: TabBarIndicatorSize.label,
          //                         unselectedLabelStyle: TextStyle(
          //                           fontFamily: 'helv med',
          //                           fontSize: vert_block * 1.7,
          //                         ),
          //                         isScrollable: true,
          //                         unselectedLabelColor: Mycolors.blacktext2,
          //                         labelColor: Mycolors.blacktext3,
          //                         labelStyle: TextStyle(
          //                           fontFamily: 'helv med',
          //                           fontSize: vert_block * 1.7,
          //                         ),
          //                         tabs: [
          //                           Text(
          //                             'Flower',
          //                             textAlign: TextAlign.center,
          //                             style: TextStyle(),
          //                           ),
          //                           Text(
          //                             'Edibles',
          //                             textAlign: TextAlign.center,
          //                             style: TextStyle(),
          //                           ),
          //                           Text(
          //                             'Alcohol',
          //                             textAlign: TextAlign.center,
          //                             style: TextStyle(),
          //                           ),
          //                           Text(
          //                             'Misc',
          //                             textAlign: TextAlign.center,
          //                             style: TextStyle(),
          //                           ),
          //                         ]),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Container(
          //               width: width,
          //               height: horz_block * 2,
          //               color: Mycolors.background,
          //             ),
          //             Expanded(
          //               child: Container(
          //                 width: width,
          //                 color: Colors.white,
          //                 child: TabBarView(children: [
          //                   Container(
          //                     child: Column(
          //                       children: [
          //                         Container(
          //                           width: width,
          //                           height: vert_block * 16,
          //                           padding: EdgeInsets.symmetric(
          //                               horizontal: horz_block * 4,
          //                               vertical: horz_block * 4),
          //                           child: Center(
          //                             child: Column(
          //                               children: [
          //                                 Row(
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     Container(
          //                                       width: 12,
          //                                       height: 12,
          //                                       decoration: BoxDecoration(
          //                                           border: Border.all(
          //                                               color: Mycolors
          //                                                   .blacktext2)),
          //                                       child: Center(
          //                                         child: Container(
          //                                           width: 6,
          //                                           height: 6,
          //                                           decoration: BoxDecoration(
          //                                               shape: BoxShape.circle,
          //                                               color: Mycolors
          //                                                   .blacktext3),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                     SizedBox(
          //                                       width: horz_block * 2,
          //                                     ),
          //                                     Text(
          //                                       'Lux Cinnamon Almond Spread \n\$25',
          //                                       style: TextStyle(
          //                                         fontSize: vert_block * 2,
          //                                         fontFamily: 'Gill regular',
          //                                         color: Mycolors.blacktext1,
          //                                         // fontWeight: FontWeight.w700
          //                                       ),
          //                                     ),
          //                                     Expanded(child: SizedBox()),
          //                                     Container(
          //                                       width: horz_block * 17,
          //                                       height: vert_block * 3,
          //                                       padding:
          //                                           EdgeInsets.only(top: 4),
          //                                       decoration: BoxDecoration(
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                   20),
          //                                           border: Border.all(
          //                                               color: Mycolors.green)
          //                                           // color: Colors.green,
          //                                           ),
          //                                       child: Center(
          //                                         child: Text(
          //                                           'ADD',
          //                                           style: TextStyle(
          //                                             fontSize:
          //                                                 vert_block * 1.6,
          //                                             fontFamily:
          //                                                 'Gill regular',
          //                                             color: Mycolors.green,
          //                                             // fontWeight: FontWeight.w700
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     )
          //                                   ],
          //                                 ),
          //                                 SizedBox(
          //                                   height: vert_block,
          //                                 ),
          //                                 Padding(
          //                                   padding: EdgeInsets.symmetric(
          //                                       horizontal: horz_block * 4),
          //                                   child: Text(
          //                                     'Put it on your toast, bagel, iPhone, anything, really. Actually enjoy your fucking morning for once. Wake up not stressed! Wow. ',
          //                                     style: TextStyle(
          //                                       fontSize: vert_block * 1.6,
          //                                       fontFamily: 'Gill regular',
          //                                       color: Mycolors.graytext,
          //                                       // fontWeight: FontWeight.w700
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                         Container(
          //                           width: width,
          //                           height: horz_block * 2,
          //                           color: Mycolors.background,
          //                         ),
          //                         Container(
          //                           width: width,
          //                           height: vert_block * 16,
          //                           padding: EdgeInsets.symmetric(
          //                               horizontal: horz_block * 4,
          //                               vertical: horz_block * 4),
          //                           child: Center(
          //                             child: Column(
          //                               children: [
          //                                 Row(
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     Container(
          //                                       width: 12,
          //                                       height: 12,
          //                                       decoration: BoxDecoration(
          //                                           border: Border.all(
          //                                               color: Mycolors.green)),
          //                                       child: Center(
          //                                         child: Container(
          //                                           width: 6,
          //                                           height: 6,
          //                                           decoration: BoxDecoration(
          //                                               shape: BoxShape.circle,
          //                                               color: Mycolors.green),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                     SizedBox(
          //                                       width: horz_block * 2,
          //                                     ),
          //                                     Text(
          //                                       'Herban Tribe Sour Lemonade \n\$25',
          //                                       style: TextStyle(
          //                                         fontSize: vert_block * 2,
          //                                         fontFamily: 'Gill regular',
          //                                         color: Mycolors.blacktext1,
          //                                         // fontWeight: FontWeight.w700
          //                                       ),
          //                                     ),
          //                                     Expanded(child: SizedBox()),
          //                                     Container(
          //                                       width: horz_block * 17,
          //                                       height: vert_block * 3,
          //                                       // padding: EdgeInsets.only(top: 4),
          //                                       decoration: BoxDecoration(
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                   20),
          //                                           border: Border.all(
          //                                               color: Mycolors.green)
          //                                           // color: Colors.green,
          //                                           ),
          //                                       child: Center(
          //                                         child: Row(
          //                                           children: [
          //                                             Expanded(
          //                                               flex: 1,
          //                                               child: Container(
          //                                                 decoration: BoxDecoration(
          //                                                     borderRadius: BorderRadius.only(
          //                                                         topLeft: Radius
          //                                                             .circular(
          //                                                                 20),
          //                                                         bottomLeft: Radius
          //                                                             .circular(
          //                                                                 20)),
          //                                                     color: Mycolors
          //                                                         .green),
          //                                                 child: Center(
          //                                                   child: Icon(
          //                                                     Icons.remove,
          //                                                     color:
          //                                                         Colors.white,
          //                                                     size: 20,
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                             Expanded(
          //                                               flex: 1,
          //                                               child: Container(
          //                                                 padding:
          //                                                     EdgeInsets.only(
          //                                                         top: 4),
          //                                                 child: Center(
          //                                                   child: Text(
          //                                                     '2',
          //                                                     style: TextStyle(
          //                                                       fontSize:
          //                                                           vert_block *
          //                                                               1.6,
          //                                                       fontFamily:
          //                                                           'Gill regular',
          //                                                       color: Mycolors
          //                                                           .green,
          //                                                       // fontWeight: FontWeight.w700
          //                                                     ),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                             Expanded(
          //                                               flex: 1,
          //                                               child: Container(
          //                                                 decoration: BoxDecoration(
          //                                                     borderRadius: BorderRadius.only(
          //                                                         topRight: Radius
          //                                                             .circular(
          //                                                                 20),
          //                                                         bottomRight: Radius
          //                                                             .circular(
          //                                                                 20)),
          //                                                     color: Mycolors
          //                                                         .green),
          //                                                 child: Center(
          //                                                   child: Icon(
          //                                                     Icons.add,
          //                                                     color:
          //                                                         Colors.white,
          //                                                     size: 20,
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             )
          //                                           ],
          //                                         ),
          //                                       ),
          //                                     )
          //                                   ],
          //                                 ),
          //                                 SizedBox(
          //                                   height: vert_block,
          //                                 ),
          //                                 Padding(
          //                                   padding: EdgeInsets.symmetric(
          //                                       horizontal: horz_block * 4),
          //                                   child: Text(
          //                                     'Put it on your toast, bagel, iPhone, anything, really. Actually enjoy your fucking morning for once. Wake up not stressed! Wow. ',
          //                                     style: TextStyle(
          //                                       fontSize: vert_block * 1.6,
          //                                       fontFamily: 'Gill regular',
          //                                       color: Mycolors.graytext,
          //                                       // fontWeight: FontWeight.w700
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   Container(),
          //                   Container(),
          //                   Container(),
          //                 ]),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
