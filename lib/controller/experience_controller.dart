



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/helper/loading.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/base_api_service.dart';

class ExperienceController extends GetxController {
  Dio dio = new Dio();

  var experienceList = List<Experience>().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getExperience();
    super.onInit();

  }

  void getExperience() async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");

      isLoading(true);
      dio.options.headers["Authorization"] = "Bearer $token";

      var response = await dio.get("${ApiEndPoints.BASE_URL}experiences");
      if(response.statusCode == 200){
        var result = (response.data as List).map((e) => Experience.fromJson(e)).toList();
        experienceList.assignAll(result);
        print("res: $result");
        // isLoading(false);

      }
      isLoading(false);
    }on DioError catch(e){
     isLoading(false);
     Get.snackbar('Error'.tr, 'Error while fetching experience!'.tr,
         snackPosition: SnackPosition.BOTTOM,
         duration: Duration(seconds: 3),
         backgroundColor: Get.theme.snackBarTheme.backgroundColor,
         colorText: Get.theme.snackBarTheme.actionTextColor);

    }
  }

}