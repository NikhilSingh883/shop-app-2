import 'package:flutter/cupertino.dart';
import 'package:jugadu/models/Product.dart';

class ProductResponse {
  final List<Product> products;
  final String error;

  ProductResponse({
    @required this.products,
    @required this.error,
  });

  // ProductResponse.fromJson(Map<String, dynamic> json)
  //     : products = (json["Products"] as List).map((i) {
  //         // String key = i.keys;
  //         return Product.fromJson(i, 'Aloevera Soap');
  //       }).toList(),
  //       error = "";

  ProductResponse.fromJson(Map<String, dynamic> json)
      : products = (json['Products'] as List).map((i) {
          return Product.fromJson(i);
        }).toList(),
        error = "";

  ProductResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}
