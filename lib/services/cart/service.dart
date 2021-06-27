import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/utils/data/commons.dart';
import 'package:vinto/utils/data/dio.dart';

class CartServices {
  Future<Either<BasicFailure, List<Product>>> getItems() async {
    try {
      var response = await dioclient.get(
          "${ApiEndPoints.BASE_URL}carts/my_cart   ",
          options: Options(headers: DataCommons.authHeader));
      Logger().d(response.data);

      return right([]);
    } on DioError catch (e) {
      Logger().e(e.response);
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

  Future<Either<BasicFailure, Unit>> addToCart(
      Map<String, dynamic> data) async {
    try {
      await dioclient.post("${ApiEndPoints.BASE_URL}carts",
          data: data, options: Options(headers: DataCommons.authHeader));

      return right(unit);
    } on DioError catch (e) {
      Logger().e(e.response);
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

  Future<Either<BasicFailure, List<Product>>> pay() async {
    try {
      var response = await dioclient.get(
          "${ApiEndPoints.BASE_URL}products/products_around_me",
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
