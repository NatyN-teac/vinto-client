import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/services/cart/service.dart';
import 'package:vinto/services/profile/service.dart';
import 'package:vinto/model/order.dart' as order;

final _cartRepo = CartServices();

class OrderBloc {
  final _orders = new BehaviorSubject<OrderState>.seeded(
      new OrderState(status: LoadingState.loading));
  Stream<OrderState> get orderStream => _orders.stream;
  OrderState get orders => _orders.value;

  void _setState(OrderState _) {
    _orders.add(_);
  }

  Future getOrders({bool reload = false}) async {
    if (reload) {
      _setState(orders.copyWith(status: LoadingState.loading));
      final _data = await _cartRepo.getHistory();
      _setState(orders.copyWith(status: LoadingState.loaded, data: _data));
    } else {
      if ((orders.data == null) || orders.data.isLeft()) {
        _setState(orders.copyWith(status: LoadingState.loading));
        final _data = await _cartRepo.getHistory();
        _setState(orders.copyWith(status: LoadingState.loaded, data: _data));
      }
    }
  }

  dispose() => _orders.close();
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
