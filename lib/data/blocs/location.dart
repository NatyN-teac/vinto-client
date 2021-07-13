import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/model/basic-user.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';

final _appstate = getIt.get<AppState>();

class LocationBloc {
  final _location = new BehaviorSubject<LocationLoadingState>.seeded(
      new LocationLoadingState(status: LoadingState.loading));
  Stream<LocationLoadingState> get locationStateStream => _location.stream;
  LocationLoadingState get location => _location.value;

  Either<Unit, Placemark> _resolver(Placemark mark) {
    if (mark != null) {
      return right(mark);
    }
    return left(unit);
  }

  Future initLocation() async {
    _location.add(location.copyWith(status: LoadingState.loading));
    try {
      if (_appstate.state.profile != null) {
        BasicClient _ = _appstate.state.profile.client;
        List<Placemark> p = await placemarkFromCoordinates(
            _.coordinates.latitude, _.coordinates.longitude);

        Placemark place = p[0];
        _location.add(location.copyWith(
            status: LoadingState.loaded, place: _resolver(place)));
      }
    } catch (e) {
      _location.add(location.copyWith(
          status: LoadingState.loaded, place: _resolver(null)));
    }
  }

  void reset() =>
      _location.add(LocationLoadingState(status: LoadingState.loading));
  dispose() => _location.close();
}

class LocationLoadingState {
  final LoadingState status;
  final Either<Unit, Placemark> place;
  LocationLoadingState({
    this.status = LoadingState.loading,
    this.place,
  });

  LocationLoadingState copyWith(
      {LoadingState status, Either<Unit, Placemark> place}) {
    return LocationLoadingState(
      status: status ?? this.status,
      place: place ?? this.place,
    );
  }
}
