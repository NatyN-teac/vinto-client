import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  @override
  Widget build(BuildContext context) {
            SizeConfig().init(context);
    var height=SizeConfig.screenHeight;
    var width=SizeConfig.screenWidth;
    var vert_block=SizeConfig.safeBlockVertical;
    var horz_block=SizeConfig.safeBlockHorizontal;
    return Scaffold(

      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: 
        Column(
          children: [
            SizedBox(height: vert_block*4,),
            Theme(
              data: Theme.of(context)
                                  .copyWith(primaryColor: Mycolors.green,),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Search...',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(Icons.search,size: 20,),
                  )
                ),
              ),
            ),

            SizedBox(height: vert_block*20,),
            Container(
              width: horz_block*25,
              child: Image.asset('assets/search.png')),
            SizedBox(height: vert_block*2,),

               Text('Search for a brand, product, \nor dispensary',textAlign: TextAlign.center,style: TextStyle(
                                fontSize: vert_block*1.8,
                               // fontFamily: 'Gill medium',
                                color: Mycolors.graytext,
                               // fontWeight: FontWeight.w700
                              ),),
          ],
        ),
      ),
      
    );
  }
}