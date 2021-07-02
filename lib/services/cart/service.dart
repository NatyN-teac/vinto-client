import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vinto/model/order.dart' as order;
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/utils/data/commons.dart';
import 'package:vinto/utils/data/dio.dart';

class CartServices {
  Future<Either<BasicFailure, List<order.Order>>> getItems() async {
    try {
      var response = await dioclient.get(
          "${ApiEndPoints.BASE_URL}carts/my_cart",
          options: Options(headers: DataCommons.authHeader()));
      // Logger().d(response.data);
      var _resu =
          (response.data as List).map((e) => order.Order.fromJson(e)).toList();

      return right(_resu);
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

  Future<Either<BasicFailure, List<order.Order>>> getHistory() async {
    try {
      var response = await dioclient.get(
          "${ApiEndPoints.BASE_URL}orders/my_paid_orders_client",
          options: Options(headers: DataCommons.authHeader()));
      var _resu =
          (response.data as List).map((e) => order.Order.fromJson(e)).toList();

      return right(_resu);
    } on DioError catch (e) {
      Logger().e(e);
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
          data: data, options: Options(headers: DataCommons.authHeader()));

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

  Future<Either<BasicFailure, bool>> pay(Map<String, dynamic> data) async {
    try {
      var response = await dioclient.post(
          "${ApiEndPoints.BASE_URL}orders/payment",
          data: data,
          options: Options(headers: DataCommons.authHeader()));
      Logger().d(response.data);

      return right(true);
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

  Future<Either<BasicFailure, bool>> clearCart() async {
    try {
      var response = await dioclient.get(
          "${ApiEndPoints.BASE_URL}carts/clear_cart",
          options: Options(headers: DataCommons.authHeader()));

      Logger().d(response.data);
      return right(true);
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
