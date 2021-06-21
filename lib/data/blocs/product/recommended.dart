import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/product/service.dart';
import 'package:vinto/services/profile/service.dart';

final _productRepo = new ProductService();

class RecommendedBloc {
  final _recommended = new BehaviorSubject<ProductState>.seeded(
      new ProductState(status: LoadingState.loading));
  Stream<ProductState> get recommendedStream => _recommended.stream;
  ProductState get recommended => _recommended.value;

  void _setState(ProductState _) {
    _recommended.add(_);
  }

  Future getOrders({bool reload = false}) async {
    if (reload) {
      _setState(recommended.copyWith(status: LoadingState.loading));
      final _data = await _productRepo.getRecommended();
      _setState(recommended.copyWith(status: LoadingState.loaded, data: _data));
    } else {
      if ((recommended.data == null) || recommended.data.isLeft()) {
        _setState(recommended.copyWith(status: LoadingState.loading));
        final _data = await _productRepo.getRecommended();
        _setState(
            recommended.copyWith(status: LoadingState.loaded, data: _data));
      }
    }
  }

  dispose() => _recommended.close();
}

enum LoadingState {
  loading,
  loaded,
}

class ProductState {
  final LoadingState status;
  final Either<BasicFailure, List<Product>> data;
  ProductState({
    this.status = LoadingState.loading,
    this.data,
  });

  ProductState copyWith({
    LoadingState status = LoadingState.loading,
    Either<BasicFailure, List<Product>> data,
  }) {
    return ProductState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
