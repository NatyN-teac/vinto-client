import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/utils/data/commons.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class HomeController extends GetxController {
  Dio dio = new Dio();
  var isLoading = true.obs;
  List<Product> recommendedProducts = List<Product>().obs;
  List<Product> popularProducts = List<Product>().obs;
  List<Product> nearby = List<Product>().obs;
  Map<String, dynamic> myPostdata = {};
  String token;

  @override
  void onInit() {
    searchProductForRecommendation();
    myPopularProducts();
    nearbyproducts();
    super.onInit();
  }

  String intersts;
  String moods;
  String experiences;
  String tastes;

  searchProductForRecommendation() async {
    isLoading.update((val) {
      val = true;
    });

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString("token");
      intersts = pref.getString("interest");
      moods = pref.getString("mood");
      experiences = pref.getString("exp");
      tastes = pref.getString("taste");

      myPostdata["interest"] = intersts.split(',');
      myPostdata["experience"] = experiences.split(',');
      myPostdata["mood"] = moods.split(',');
      myPostdata["taste"] = tastes.split(',');

      var response = await dio.post("${ApiEndPoints.BASE_URL}products/search",
          options: Options(headers: DataCommons.authHeader()),
          data: myPostdata);
      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((e) => Product.fromJson(e)).toList();
        recommendedProducts.addAll(result);
      }
      isLoading.update((val) {
        val = false;
      });
    } on DioError {
      isLoading.update((val) {
        val = false;
      });

      Get.snackbar('Error'.tr, 'Error while fetching Intests!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  myPopularProducts() async {
    isLoading.update((val) {
      val = true;
    });

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString("token");

      var response = await dio.get(
        "${ApiEndPoints.BASE_URL}products",
        options: Options(headers: DataCommons.authHeader()),
      );
      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((e) => Product.fromJson(e)).toList();

        Logger().d(response.data);
        popularProducts.addAll(result);
        isLoading.update((val) {
          val = false;
        });
      }
    } on DioError {
      isLoading.update((val) {
        val = false;
      });

      Get.snackbar('Error'.tr, 'Error while fetching popular products!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  nearbyproducts() async {
    isLoading.update((val) {
      val = true;
    });

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString("token");

      var response = await dio.get(
        "${ApiEndPoints.BASE_URL}products/products_around_me",
        options: Options(headers: DataCommons.authHeader()),
      );

      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((e) => Product.fromJson(e)).toList();
        nearby.addAll(result);
        update();
      }
      isLoading.update((val) {
        val = false;
      });
      update();
    } on DioError {
      isLoading.update((val) {
        val = true;
      });

      Get.snackbar('Error'.tr, 'Error while fetching popular products!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
