import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

FlutterSecureStorage _storage = new FlutterSecureStorage();

mixin AuthBloc {
  BehaviorSubject<AuthState> _state = new BehaviorSubject<AuthState>.seeded(
      new AuthState(fresh: null, token: null));
  //Stream
  Stream<AuthState> get authStateStream => _state.stream;
// values
  AuthState get state => _state.value;

  _setState(AuthState _) {
    _state.add(_);
  }

  void shiftAuth(bool val) {
    _setState(state.copyWith(auth: val));
  }

  startFresh(bool v) {
    _setState(state.copyWith(fresh: v, auth: v));
  }

  Future initAuth() async {
    String notvirgin = await _storage.read(key: 'fresh');
    String token = await _storage.read(key: 'token');
    if ((notvirgin) == null) {
      await _storage.write(key: 'fresh', value: "rotten");
      await Future.delayed(Duration(seconds: 2));
      _setState(state.copyWith(
        fresh: true,
      ));
    } else {
      if ((token) == null) {
        await Future.delayed(Duration(seconds: 2));
        _setState(state.copyWith(
          fresh: false,
        ));
      } else {
        await Future.delayed(Duration(seconds: 2));
        _setState(state.copyWith(fresh: false, auth: true, token: token));
      }
    }

    _setState(state.copyWith(state: AuthStateEnum.loaded));
  }

  Future saveToken(String cookie) async {
    await _storage.write(key: "token", value: cookie);
    _setState(state.copyWith(token: cookie, auth: true));
  }

  Future saveUser({bool remember = false, String token}) async {
    if (remember) {
      await this.saveToken(
        token,
      );
    } else {
      await this.saveToken(
        token,
      );
    }
  }

  Future logout() async {
    await _storage.delete(key: 'token');
    _setState(state.copyWith(token: null, auth: false));
  }

  dispose() {
    _state.close();
  }
}

enum AuthStateEnum { loading, loaded }

class AuthState {
  final bool auth;
  final bool fresh;
  final String token;
  final AuthStateEnum state;
  AuthState({
    this.auth = false,
    this.state = AuthStateEnum.loading,
    @required this.fresh,
    @required this.token,
  });

  AuthState copyWith(
      {bool auth, AuthStateEnum state, bool fresh, String token}) {
    return AuthState(
      state: state ?? this.state,
      auth: auth ?? this.auth,
      fresh: fresh ?? this.fresh,
      token: token ?? this.token,
    );
  }
}
