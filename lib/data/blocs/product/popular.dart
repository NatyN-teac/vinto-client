import 'package:rxdart/rxdart.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/services/product/service.dart';

final _productRepo = new ProductService();

class PopularBloc {
  final _popular = new BehaviorSubject<ProductState>.seeded(
      new ProductState(status: LoadingState.loading));
  Stream<ProductState> get popularStream => _popular.stream;
  ProductState get popular => _popular.value;

  void _setState(ProductState _) {
    _popular.add(_);
  }

  Future getOrders({bool reload = false}) async {
    if (reload) {
      _setState(popular.copyWith(status: LoadingState.loading));
      final _data = await _productRepo.getPopular();
      _setState(popular.copyWith(status: LoadingState.loaded, data: _data));
    } else {
      if ((popular.data == null) || popular.data.isLeft()) {
        _setState(popular.copyWith(status: LoadingState.loading));
        final _data = await _productRepo.getPopular();
        _setState(popular.copyWith(status: LoadingState.loaded, data: _data));
      }
    }
  }

  dispose() => _popular.close();
}
