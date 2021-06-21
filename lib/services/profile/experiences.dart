import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vinto/model/experience.dart';
import 'package:vinto/services/api_url.dart';
import 'package:vinto/services/profile/interests.dart';
import 'package:vinto/utils/data/commons.dart';
import 'package:vinto/utils/data/dio.dart';

class ExperienceService {
  Future<Either<BasicFailure, List<Experience>>> getExperiences() async {
    try {
      var response = await dioclient.get("${ApiEndPoints.BASE_URL}experiences",
          options: Options(headers: DataCommons.authHeader));

      var result =
          (response.data as List).map((e) => Experience.fromJson(e)).toList();

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
