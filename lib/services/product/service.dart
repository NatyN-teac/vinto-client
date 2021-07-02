import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/utils/data/commons.dart';
import 'package:vinto/utils/data/dio.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

class ProductService {
  Future<Either<BasicFailure, List<Product>>> getRecommended() async {
    try {
      Map<String, dynamic> myPostdata = {};
      SharedPreferences pref = await SharedPreferences.getInstance();
      String intersts = pref.getString("interest");
      String moods = pref.getString("mood");
      String experiences = pref.getString("exp");
      String tastes = pref.getString("taste");

      myPostdata["interest"] = intersts == null ? [] : intersts.split(',');
      myPostdata["experience"] =
          experiences == null ? [] : experiences.split(',');
      myPostdata["mood"] = moods == null ? [] : moods.split(',');
      myPostdata["taste"] = tastes == null ? [] : tastes.split(',');

      var response = await dioclient.post(
          "${ApiEndPoints.BASE_URL}products/search",
          data: myPostdata,
          options: Options(headers: DataCommons.authHeader()));
      var result =
          (response.data as List).map((e) => Product.fromJson(e)).toList();

      return right(result);
    } on DioError catch (e) {
      Logger().e(e.response);
      if (e.response.statusCode > 400 && e.response.statusCode <= 500) {
        return left(BasicFailure("Server Error"));
      } else if (e.error is SocketException) {
        return left(BasicFailure("Network Error"));
      } else if (e.error is HttpException) {
        return left(BasicFailure("Server Error"));
      }

      return left(new BasicFailure("Something went wrong"));
    }
  }

  Future<Either<BasicFailure, List<Product>>> getPopular() async {
    try {
      var response = await dioclient.get("${ApiEndPoints.BASE_URL}products",
          options: Options(headers: DataCommons.authHeader()));

      var result =
          (response.data as List).map((e) => Product.fromJson(e)).toList();

      return right(result);
    } on DioError catch (e) {
      Logger().e(e.response.data["error"]["status"]);
      if (e.response.data["error"]["status"] == 400) {
        getIt.get<AppState>().logout();
      }
      if (e.response.statusCode > 400 && e.response.statusCode <= 500) {
        return left(BasicFailure("Invalid Auth"));
      } else if (e.error is SocketException) {
        return left(BasicFailure("Network Error"));
      } else if (e.error is HttpException) {
        return left(BasicFailure("Server Error"));
      }

      return left(new BasicFailure("Something went wrong"));
    }
  }

  Future<Either<BasicFailure, List<Product>>> getNearby() async {
    try {
      var response = await dioclient.get(
          "${ApiEndPoints.BASE_URL}products/products_around_me",
          options: Options(headers: DataCommons.authHeader()));
      var result =
          (response.data as List).map((e) => Product.fromJson(e)).toList();
      Logger().d(result.length);

      return right(result);
    } on DioError catch (e) {
      Logger().e(e.response);
      if (e.response.statusCode > 400 && e.response.statusCode <= 500) {
        return left(BasicFailure("Invalid "));
      } else if (e.error is SocketException) {
        return left(BasicFailure("Network Error"));
      } else if (e.error is HttpException) {
        return left(BasicFailure("Server Error"));
      }

      return left(new BasicFailure("Something went wrong"));
    }
  }

  Future<Either<BasicFailure, List<Product>>> searchProduct(
      String query) async {
    try {
      var response = await dioclient.post(
          "${ApiEndPoints.BASE_URL}products/search_by_name",
          data: {"name": query},
          options: Options(headers: DataCommons.authHeader()));

      var result =
          (response.data as List).map((e) => Product.fromJson(e)).toList();

      return right(result);
    } on DioError catch (e) {
      Logger().e(e.response);
      if (e.response.statusCode > 400 && e.response.statusCode <= 500) {
        return left(BasicFailure("Server Error"));
      } else if (e.error is SocketException) {
        return left(BasicFailure("Network Error"));
      } else if (e.error is HttpException) {
        return left(BasicFailure("Server Error"));
      }

      return left(new BasicFailure("Something went wrong"));
    }
  }
}
