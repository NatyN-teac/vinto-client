import 'package:rxdart/rxdart.dart';
import 'package:vinto/data/blocs/order-bloc.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/services/cart/service.dart';

final _cartRepo = new CartServices();

class CartBloc {
  final _nearby = new BehaviorSubject<OrderState>.seeded(
      new OrderState(status: LoadingState.loading));
  Stream<OrderState> get nearbyStream => _nearby.stream;
  OrderState get nearby => _nearby.value;

  void _setState(OrderState _) {
    _nearby.add(_);
  }

  Future getOrders({bool reload = false}) async {
    if (reload) {
      _setState(nearby.copyWith(status: LoadingState.loading));
      final _data = await _cartRepo.getItems();
      _setState(nearby.copyWith(status: LoadingState.loaded, data: _data));
    } else {
      if ((nearby.data == null) || nearby.data.isLeft()) {
        _setState(nearby.copyWith(status: LoadingState.loading));
        final _data = await _cartRepo.getItems();
        _setState(nearby.copyWith(status: LoadingState.loaded, data: _data));
      }
    }
  }

  void resetBloc() {
    _setState(new OrderState(status: LoadingState.loading));
  }

  dispose() => _nearby.close();
}
