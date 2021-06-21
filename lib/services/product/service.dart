import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/utils/data/commons.dart';
import 'package:vinto/utils/data/dio.dart';

class ProductService {
  Future<Either<BasicFailure, List<Product>>> getRecommended() async {
    try {
      var response = await dioclient.get("${ApiEndPoints.BASE_URL}interests",
          options: Options(headers: DataCommons.authHeader));

      var result =
          (response.data as List).map((e) => Product.fromJson(e)).toList();

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

  Future<Either<BasicFailure, List<Product>>> getPopular() async {
    try {
      var response = await dioclient.get("${ApiEndPoints.BASE_URL}products",
          options: Options(headers: DataCommons.authHeader));

      var result =
          (response.data as List).map((e) => Product.fromJson(e)).toList();

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

  Future<Either<BasicFailure, List<Product>>> getNearby() async {
    try {
      var response = await dioclient.get(
          "${ApiEndPoints.BASE_URL}products_around_me",
          options: Options(headers: DataCommons.authHeader));

      var result =
          (response.data as List).map((e) => Product.fromJson(e)).toList();

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
}
