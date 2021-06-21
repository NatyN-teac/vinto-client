import 'package:flutter/foundation.dart';

abstract class LoginError {
  List<Object> get props => [];
}

class InvalidCredentials extends LoginError {
  final String message;

  InvalidCredentials(this.message);

  @override
  String toString() => 'InvalidCredentials(message: $message)';
  @override
  List<Object> get props => [message];
}

class LoginNetWorkError extends LoginError {
  final String message;

  LoginNetWorkError(this.message);

  @override
  String toString() => 'LoginNetWorkError(message: $message)';
  @override
  List<Object> get props => [message];
}

class CommonLoginError extends LoginError {
  final String message;

  CommonLoginError(this.message);

  @override
  String toString() => 'CommonLoginError(message: $message)';
  @override
  List<Object> get props => [message];
}

class LoginPayload {
  final String token;
  final Map<String, dynamic> data;

  LoginPayload(this.token, this.data);
}

class RegisterInput {
  final String username;
  final String password;
  final String place;
  final String email;
  final List<double> points;
  RegisterInput({
    @required this.username,
    @required this.password,
    @required this.place,
    @required this.email,
    @required this.points,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": this.username,
      "password": this.password,
      "place": this.place,
      "email": this.email,
      "user_type": "driver",
      "location": {"types": "Point", "coordinates": this.points}
    };
  }
}

class RegisterationError {
  final String message;
  RegisterationError({
    @required this.message,
  });
}
