import 'package:jugadu/models/Product.dart';

class CartItem {
  final Product product;
  final int count;
  final String id;

  CartItem({this.product, this.count, this.id});
}
