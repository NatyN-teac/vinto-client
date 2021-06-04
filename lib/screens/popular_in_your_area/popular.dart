import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/screens/Dispancry_front_facing/dispancry.dart';
import 'package:vinto/screens/popular_in_your_area/widget/items.dart';

class Popularscreen extends StatefulWidget {
  @override
  _PopularscreenState createState() => _PopularscreenState();
}

class _PopularscreenState extends State<Popularscreen> {
  @override
  Widget build(BuildContext context) {
        SizeConfig().init(context);
    var height=SizeConfig.screenHeight;
    var width=SizeConfig.screenWidth;
    var vert_block=SizeConfig.safeBlockVertical;
    var horz_block=SizeConfig.safeBlockHorizontal;
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        backgroundColor: Colors.white,
        centerTitle: true,
        title:  Text('Popular in your Area',style: TextStyle(
                                fontSize: vert_block*2.2,
                                fontFamily: 'Gill medium',
                                color: Mycolors.blacktext,
                                fontWeight: FontWeight.w700
                              ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Dispancryfacing()));

        },
        backgroundColor: Colors.white,
        child: Icon(Icons.filter_alt,color: Mycolors.green,),
      ),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
         
        child: Container(
         // margin: EdgeInsets.symmetric(horizontal: horz_block*4),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Popularitems(),
                    Popularitems(),

                  ],
                ),
                SizedBox(height: vert_block,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Popularitems(),
                    Popularitems(),

                  ],
                ),
                SizedBox(height: vert_block,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Popularitems(),
                    Popularitems(),

                  ],
                ),
                SizedBox(height: vert_block,),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Popularitems(),
                  Popularitems(),

                ],
              ),
              SizedBox(height: vert_block,),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}