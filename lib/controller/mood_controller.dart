


import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/model/mood.dart';
import 'package:vinto/services/api_url.dart';

class MoodController extends GetxController {
  Dio dio = new Dio();

  var moodList = List<Mood>().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMood();
    super.onInit();
  }

  void fetchMood() async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");

      isLoading(true);
      dio.options.headers["Authorization"] = "Bearer $token";

      var response = await dio.get("${ApiEndPoints.BASE_URL}moods");
      if(response.statusCode == 200){
        var result = (response.data as List).map((e) => Mood.fromJson(e)).toList();
        moodList.assignAll(result);
        print("res: $result");
        // isLoading(false);

      }
      isLoading(false);
    }on DioError catch(e){
      isLoading(false);
      Get.snackbar('Error'.tr, 'Error while fetching Moods!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);

    }

  }

}