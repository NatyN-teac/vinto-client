import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/services/cart/service.dart';
import 'package:vinto/model/order.dart' as order;
import 'package:vinto/services/profile/service.dart';

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

  dispose() => _nearby.close();
}

class OrderState {
  final LoadingState status;
  final Either<BasicFailure, List<order.Order>> data;
  OrderState({
    this.status = LoadingState.loading,
    this.data,
  });

  OrderState copyWith({
    LoadingState status = LoadingState.loading,
    Either<BasicFailure, List<order.Order>> data,
  }) {
    return OrderState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
