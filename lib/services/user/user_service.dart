import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/services/user/types.dart';
import 'package:vinto/utils/data/commons.dart';
import 'package:vinto/utils/data/dio.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

final _appstate = getIt.get<AppState>();

class UserService {
  Future<Either<LoginError, LoginPayload>> login(
      String email, String password) async {
    try {
      var response = await dioclient
          .post("/users/login", data: {"email": email, "password": password});
      return right(LoginPayload(response.data['token'], response.data['user']));
    } on DioError catch (e) {
      if (e.response.statusCode > 400 && e.response.statusCode <= 500) {
        return left(InvalidCredentials("Invalid Email or Password"));
      } else if (e.error is SocketException) {
        return left(LoginNetWorkError("Network Error"));
      } else if (e.error is HttpException) {
        return left(CommonLoginError("Server Error"));
      }

      return left(new CommonLoginError("Something went wrong"));
    }
  }

  Future<Either<RegisterationError, bool>> register(RegisterInput data) async {
    try {
      await dioclient.post("/users/signup", data: data.toJson());

      return right(true);
    } on DioError catch (e) {
      Logger().e(e);
      String err = "Something went wrong";
      if (e.error is SocketException) {
        err = "Network Error";
      } else if (e.error is HttpException) {
        err = "Server Error";
      } else if (e.error is FormatException) {
        err = "Bad Request";
      }
      return left(new RegisterationError(message: err));
    }
  }

  Future<Either<RegisterationError, bool>> updateClient(
      Map<String, dynamic> data) async {
    try {
      final _data = await dioclient.put(
          "/clients/${_appstate.state.profile.client.id}",
          options: Options(headers: DataCommons.authHeader),
          data: data);
      Map<String, dynamic> _map = _data.data['user'];

      _map.addAll({'client': _data.data});
      _appstate.saveProfile(_map);

      return right(true);
    } on DioError catch (e) {
      Logger().e(e.response);
      String err = "Something went wrong";
      if (e.error is SocketException) {
        err = "Network Error";
      } else if (e.error is HttpException) {
        err = "Server Error";
      } else if (e.error is FormatException) {
        err = "Bad Request";
      }
      return left(new RegisterationError(message: err));
    }
  }

  Future<Either<RegisterationError, bool>> updateUser(
      Map<String, dynamic> data) async {
    try {
      final _res = await dioclient.put("/users/${_appstate.state.profile.id}",
          options: Options(headers: DataCommons.authHeader), data: data);
      _appstate.saveProfile(_res.data);
      return right(true);
    } on DioError catch (e) {
      String err = e.message;

      if (e.error is SocketException) {
        err = "Network Error";
      } else if (e.error is HttpException) {
        err = "Server Error";
      } else if (e.error is FormatException) {
        err = "Bad Request";
      }
      return left(new RegisterationError(message: err));
    }
  }
}
