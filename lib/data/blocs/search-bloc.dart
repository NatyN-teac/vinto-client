import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vinto/model/product.dart';
import 'package:vinto/services/product/service.dart';
import 'package:vinto/services/profile/service.dart';

class SearchBloc {
  SearchBloc() {
    _results = _searchTerms
        .debounce((_) => TimerStream(true, Duration(milliseconds: 250)))
        .switchMap((query) async* {
      yield await ProductService().searchProduct(query);
    });
  }

  final _searchTerms = BehaviorSubject<String>();
  void searchUser(String query) => _searchTerms.add(query);

  Stream<Either<BasicFailure, List<Product>>> _results;
  Stream<Either<BasicFailure, List<Product>>> get results => _results;

  void reset() {
    _searchTerms.add("");
  }

  void dispose() {
    _searchTerms.close();
  }
}
