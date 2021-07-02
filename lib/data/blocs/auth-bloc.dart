import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/data/blocs/location.dart';
// import 'package:logger/logger.dart';
// import 'package:vinto/data/blocs/cart.dart';
// import 'package:vinto/data/blocs/order-bloc.dart';
// import 'package:vinto/data/blocs/product/nearby-products.dart';
// import 'package:vinto/data/blocs/product/popular.dart';
// import 'package:vinto/data/blocs/search-bloc.dart';
import 'package:vinto/model/basic-user.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

FlutterSecureStorage _storage = new FlutterSecureStorage();

final _location = getIt.get<LocationBloc>();

// final _nearby = getIt.get<NearbyBloc>();
// final _pop = getIt.get<PopularBloc>();
// final _search = getIt.get<SearchBloc>();
// final _cart = getIt.get<CartBloc>();
// final _order = getIt.get<OrderBloc>();

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

  bool isPhone() => false;

  Future initAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String notvirgin;
    String token;
    String _data;

    if (isPhone()) {
      notvirgin = await _storage.read(key: 'fresh');
      token = await _storage.read(key: 'token_key');
      _data = await _storage.read(key: 'data');
    } else {
      notvirgin = prefs.getString('fresh');
      token = prefs.getString('token_key');
      _data = prefs.getString('data');
    }

    if ((notvirgin) == null) {
      isPhone()
          ? await _storage.write(key: 'fresh', value: "rotten")
          : await prefs.setString('fresh', "rotten");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isPhone()
        ? await _storage.write(key: "token_key", value: cookie)
        : await prefs.setString('token_key', cookie);

    _setState(state.copyWith(token: cookie));

    _location.initLocation();
  }

  Future saveProfile(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var _data = BasicUser.fromMap(data);

    isPhone()
        ? await _storage.write(key: "data", value: _data.toJson())
        : await prefs.setString('data', _data.toJson());

    _setState(state.copyWith(profile: _data));
    _setState(state.copyWith(auth: true));
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isPhone()) {
      await _storage.delete(key: 'token_key');
      await _storage.delete(key: 'data');
    } else {
      await prefs.remove("token_key");
      await prefs.remove("data");
    }

    // resetStates();
    _setState(state.copyWith(
      auth: true,
    ));
  }

  // void resetStates() {
  //   _nearby.resetBloc();
  //   _pop.resetBloc();
  //   _search.resetBloc();
  //   _cart.resetBloc();
  //   _order.resetBloc();
  // }

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
