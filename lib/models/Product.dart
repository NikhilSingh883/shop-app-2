import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Product {
  var uuid = Uuid();

  final String title;
  final String desc;
  final String category;
  final double price;
  final double rating;
  final double stock;
  final String id;

  Product({
    @required this.title,
    @required this.desc,
    @required this.category,
    @required this.price,
    @required this.rating,
    @required this.stock,
    @required this.id,
  });

  Product.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['Description'],
        category = json['Category'],
        price = json['Price'].toDouble(),
        rating = json['Rating'].toDouble(),
        stock = json['Stock'].toDouble(),
        id = DateTime.now().toIso8601String();
}
