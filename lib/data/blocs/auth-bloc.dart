import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vinto/data/blocs/location.dart';
import 'package:vinto/model/basic-user.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

FlutterSecureStorage _storage = new FlutterSecureStorage();

final _location = getIt.get<LocationBloc>();
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
    String _data = await _storage.read(key: 'data');
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
    await _storage.write(key: "token", value: cookie);

    _setState(state.copyWith(token: cookie, auth: true));
    _location.initLocation();
  }

  Future saveProfile(Map<String, dynamic> data) async {
    var _data = BasicUser.fromMap(data);
    await _storage.write(key: "data", value: _data.toJson());

    _setState(state.copyWith(profile: _data));
  }

  Future logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'data');
    _setState(state.copyWith(token: null, auth: false, profile: null));
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
}
