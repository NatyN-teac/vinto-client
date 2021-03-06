import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/helper/loading.dart';
import 'package:vinto/model/user.dart';
import 'package:vinto/screens/create_Profile/profile_intro.dart';
import 'package:vinto/screens/register/sign_In.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

final _appstate = getIt.get<AppState>();

class AuthController extends GetxController {
  static AuthController to = Get.find();
  Dio dio = new Dio();
  CustomOverlayLoader _overlayLoader = new CustomOverlayLoader();
  SharedPreferences prefs;

  login(BuildContext context, String email, String password) async {
    _overlayLoader.show(context);
    try {
      // prefs = await SharedPreferences.getInstance();

      var data = {"email": "$email", "password": "$password"};
      var result =
          await dio.post("${ApiEndPoints.BASE_URL}users/login", data: data);
      if (result.statusCode == 200) {
        UserModel user = UserModel.fromJson(result.data);

        if (user.user.role == "client") {
          await _appstate.saveToken(result.data['token']);
          await _appstate.saveProfile(result.data['user']);
          Get.off(Profile_Intro());
        } else {
          Get.snackbar('Invalid Role'.tr,
              'a ${user.user.role} can not use this version !!'.tr,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 3),
              backgroundColor: Get.theme.snackBarTheme.backgroundColor,
              colorText: Get.theme.snackBarTheme.actionTextColor);
        }

        _overlayLoader.hide();
      }
    } on DioError catch (e) {
      Logger().e(e);

      _overlayLoader.hide();
      Get.snackbar('Auth Error'.tr, 'Sign in Error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white);
      // hideLoadingIndicator();

    }
  }

  register(BuildContext context, Map<String, dynamic> data) async {
    try {
      _overlayLoader.show(context);
      prefs = await SharedPreferences.getInstance();

      var result =
          await dio.post("${ApiEndPoints.BASE_URL}users/signup", data: data);
      if (result.statusCode == 200 || result.statusCode == 201) {
        // User user = User.fromJson(result.data);
        Get.to(SignIn());
      }

      _overlayLoader.hide();
    } on DioError catch (e) {
      _overlayLoader.hide();
      Get.snackbar('Auth Error'.tr, e.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white);
      // hideLoadingIndicator();

    }
  }
}
