import 'package:rxdart/rxdart.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/services/product/service.dart';

final _productRepo = new ProductService();

class NearbyBloc {
  final _nearby = new BehaviorSubject<ProductState>.seeded(
      new ProductState(status: LoadingState.loading));
  Stream<ProductState> get nearbyStream => _nearby.stream;
  ProductState get nearby => _nearby.value;

  void _setState(ProductState _) {
    _nearby.add(_);
  }

  Future getOrders({bool reload = false}) async {
    if (reload) {
      _setState(nearby.copyWith(status: LoadingState.loading));
      final _data = await _productRepo.getNearby();
      _setState(nearby.copyWith(status: LoadingState.loaded, data: _data));
    } else {
      if ((nearby.data == null) || nearby.data.isLeft()) {
        _setState(nearby.copyWith(status: LoadingState.loading));
        final _data = await _productRepo.getNearby();
        _setState(nearby.copyWith(status: LoadingState.loaded, data: _data));
      }
    }
  }

  dispose() => _nearby.close();
}
