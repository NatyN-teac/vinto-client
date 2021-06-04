import 'package:flutter/material.dart';
import 'package:vinto/helper/colors.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/screens/Dispancry_front_facing/dispancry.dart';
import 'package:vinto/screens/home_screen/widgets/item.dart';
import 'package:vinto/screens/popular_in_your_area/widget/items.dart';
import 'package:vinto/screens/shop_near_me/shoplist.dart';

class Shopnearscreen extends StatefulWidget {
  final List<Product> nearybyProducts;

  const Shopnearscreen({Key key, this.nearybyProducts}) : super(key: key);
  @override
  _ShopnearscreenState createState() => _ShopnearscreenState();
}

class _ShopnearscreenState extends State<Shopnearscreen> {
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
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back,color: Colors.black,)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title:  Text('Shops Near Me',style: TextStyle(
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
        child: Icon(Icons.invert_colors_on_sharp,color: Mycolors.green,),
      ),
      body: widget.nearybyProducts.length == 0 ? Center(
        child: Text("No Product found around your location."),
      ):Container(
        width: width,
        height: height,
        color: Colors.white,
         
        child: Container(
         // margin: EdgeInsets.symmetric(horizontal: horz_block*4),
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: widget.nearybyProducts.length,
                    itemBuilder: (context, index) {
                      Product product = widget.nearybyProducts[index];
                      return Fooditem(product: product,);
                    }),
              SizedBox(height: vert_block,),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}