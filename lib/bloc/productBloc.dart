import 'package:jugadu/models/ProductResponse.dart';
import 'package:jugadu/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  final ProductRepository _repository = ProductRepository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  getProducts() async {
    ProductResponse response = await _repository.getProduct();
    _subject.sink.add(response);
  }

  getProductsByMoney() async {
    ProductResponse response = await _repository.getProduct();
    response.products.sort((a, b) {
      if (a.price > b.price) return 1;
      return 0;
    });
    _subject.sink.add(response);
  }

  getProductsByType() async {
    ProductResponse response = await _repository.getProduct();
    response.products.sort((a, b) {
      return a.category.compareTo(b.category);
    });
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;
}

final productBloc = ProductBloc();
