import 'package:flutter/material.dart';
import 'package:vinto/helper/screensize.dart';
import 'package:vinto/model/order.dart';
import 'package:vinto/screens/timeline_screen/timeline.dart';

class Checkoutscreen extends StatefulWidget {
  final AssignedFor driver;

  const Checkoutscreen({Key key, this.driver}) : super(key: key);
  @override
  _CheckoutscreenState createState() => _CheckoutscreenState();
}

class _CheckoutscreenState extends State<Checkoutscreen> {
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
        padding: EdgeInsets.symmetric(vertical: horz_block*20,horizontal: horz_block*4),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
                child: Icon(Icons.close)),
            SizedBox(height: vert_block*4,),
            Image.asset('assets/del.png'),
            SizedBox(height: vert_block*3,),

            Text('Thank you for \nyour order!',style: TextStyle(
                                  fontSize: vert_block*2.9,
                                  color: Colors.black,
                               //  fontWeight: FontWeight.w700
                                ),),
                                SizedBox(height: vert_block,),
                        Text('Your driver, ${widget.driver.username}, '
                            'will be arriving soon. Keep an \neye out for the door! '
                            'You can track the status \nof your delivery below: ',style: TextStyle(
                                  fontSize: vert_block*1.6,
                                  color: Colors.black,
                                  fontFamily: 'Gill light'
                               //  fontWeight: FontWeight.w700
                                ),),
                                SizedBox(height: vert_block,),
                
              InkWell(
                onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Timelinescreen(driver: widget.driver,)));

                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:Border.all(
                      width: 2,
                      color: Colors.black
                    )
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              )
          ],
        ),
      ),
      
    );
  }
}