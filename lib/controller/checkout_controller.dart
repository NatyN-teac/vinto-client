


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/helper/loading.dart';
import 'package:vinto/model/order.dart';
import 'package:vinto/screens/checkout_screen/check_out.dart';
import 'package:vinto/services/api_url.dart';

class CheckoutController extends GetxController {
  static CheckoutController to = Get.find();
  Dio dio = new Dio();
  CustomOverlayLoader _overlayLoader = new CustomOverlayLoader();
  SharedPreferences prefs;


  orderProduct(BuildContext context, String productId,String quantity) async {
    _overlayLoader.show(context);
  try{
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    dio.options.headers["Authorization"] = "Bearer $token";
    var orderById = prefs.getString('userId');


    var data = {"order_by":"$orderById","product":"$productId","quantity": int.parse(quantity)};
    var result  = await dio.post("${ApiEndPoints.BASE_URL}orders", data: data);
    print("order data response: ${result.data}");
    if(result.statusCode == 200) {
      Order order = Order.fromJson(result.data);

      // if (user.user.role != "user") {
        Get.to(Checkoutscreen(driver: order.assignedFor,));
      //   Get.to(Profile_Intro(user: user.user,));
      // }
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen()));
      _overlayLoader.hide();
    }

  }on DioError catch(e){
    print("error while oerder: ${e.response}");
    _overlayLoader.hide();
    Get.snackbar('Order Error'.tr, 'Order Failed,Try again!'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor);
    // hideLoadingIndicator();


  }

}

}