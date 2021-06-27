import 'package:dartz/dartz.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/profile/service.dart';

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
