import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/model/interests.dart';
import 'package:vinto/services/api_url.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class InterestController extends GetxController {
  Dio dio = new Dio();

  var interestsList = List<Interests>().obs;
  var isLoading = true.obs;
  SharedPreferences prefs;

  @override
  void onInit() {
    fetchInterests();
    super.onInit();
  }

  void fetchInterests() async {
    try {
      prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      isLoading(true);
      dio.options.headers["Authorization"] = "Bearer $token";

      var response = await dio.get("${ApiEndPoints.BASE_URL}interests");
      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((e) => Interests.fromJson(e)).toList();
        interestsList.addAll(result);
      }
      isLoading(false);
    } on DioError {
      isLoading(false);
      Get.snackbar('Error'.tr, 'Error while fetching Intests!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}
