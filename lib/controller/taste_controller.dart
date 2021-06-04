


import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/model/taste.dart';
import 'package:vinto/services/api_url.dart';

class TasteController extends GetxController {
  Dio dio = new Dio();

  var tasteList = List<Taste>().obs;
  var isLoading = true.obs;


  @override
  void onInit() {
    fetchTaste();
    super.onInit();
  }


  void fetchTaste() async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");

      isLoading(true);
      dio.options.headers["Authorization"] = "Bearer $token";

      var response = await dio.get("${ApiEndPoints.BASE_URL}tastes");
      if(response.statusCode == 200){
        var result = (response.data as List).map((e) => Taste.fromJson(e)).toList();
        tasteList.assignAll(result);
        print("res: $result");
        // isLoading(false);

      }
      isLoading(false);
    }on DioError catch(e){
      isLoading(false);
      Get.snackbar('Error'.tr, 'Error while fetching Tastes!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);

    }

  }


}