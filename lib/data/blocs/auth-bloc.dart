import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_core/get_core.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vinto/data/blocs/location.dart';
import 'package:vinto/model/basic-user.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

final _location = getIt.get<LocationBloc>();

mixin AuthBloc {
  BehaviorSubject<AuthState> _state = new BehaviorSubject<AuthState>.seeded(
      new AuthState(fresh: null, token: null));
  //Stream
  Stream<AuthState> get authStateStream => _state.stream;
// values
  AuthState get state => _state.value;

  _setState(AuthState _) {
    Logger().d(_.toMap());
    _state.add(_);
  }

  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  void shiftAuth(bool val) {
    _setState(state.copyWith(auth: val));
  }

  startFresh(bool v) {
    _setState(state.copyWith(fresh: v, auth: v));
  }

  bool isPhone() => true;

  Future initAuth() async {
    var prefs = await _prefs();

    String notvirgin = prefs.getString('fresh');
    String token = prefs.getString('token_key');
    String _data = prefs.getString('data');

    if ((notvirgin) == null) {
      // isPhone()
      //     ?
      await prefs.setString('fresh', "rotten");
      // : await prefs.setString('fresh', "rotten");
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
        var _decoded = json.decode(_data);

        await Future.delayed(Duration(seconds: 2));
        _setState(state.copyWith(
            fresh: false,
            auth: true,
            profile: BasicUser.fromStorage(_decoded),
            token: token));

        _location.initLocation();
      }
    }

    _setState(state.copyWith(state: AuthStateEnum.loaded));
  }

  Future saveToken(
    String cookie,
  ) async {
    var prefs = await _prefs();

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // isPhone()
    //     ?
    await prefs.setString("token_key", cookie);
    // : await prefs.setString('token_key', cookie);

    _setState(state.copyWith(token: cookie));

    _location.initLocation();
  }

  Future saveProfile(Map<String, dynamic> data) async {
    var prefs = await _prefs();

    var _data = BasicUser.fromMap(data);

    await prefs.setString("data", _data.toJson());

    _setState(state.copyWith(profile: _data));
    _setState(state.copyWith(auth: true));
  }

  Future logout() async {
    var prefs = await _prefs();

    await prefs.remove('token_key');
    await prefs.remove('data');

    _setState(AuthState.reset());

    resetSingletons();
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
  final BasicUser profile;
  AuthState({
    this.auth = false,
    this.state = AuthStateEnum.loading,
    this.profile,
    @required this.fresh,
    @required this.token,
  });

  factory AuthState.reset() {
    return AuthState(
        auth: false,
        state: AuthStateEnum.loaded,
        profile: null,
        fresh: null,
        token: '');
  }

  AuthState copyWith(
      {bool auth,
      AuthStateEnum state,
      bool fresh,
      String token,
      BasicUser profile}) {
    return AuthState(
      state: state ?? this.state,
      auth: auth ?? this.auth,
      fresh: fresh ?? this.fresh,
      token: token ?? this.token,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'auth': auth,
      'fresh': fresh,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());
}
