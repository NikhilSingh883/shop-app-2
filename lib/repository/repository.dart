import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jugadu/firebase/firebaseMethods.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/models/ProductResponse.dart';

class ProductRepository {
  final String productUrl = "https://wathare.herokuapp.com/";

  Future<ProductResponse> getProduct() async {
    try {
      final response = await http.get(productUrl);
      final jsonresponse = json.decode(response.body)[0];

      return ProductResponse.fromJson(jsonresponse);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }
}

class Repository {
  final _firestoreProvider = FirebaseMethods();

  Stream<QuerySnapshot> cartItemList() => _firestoreProvider.getCart();
  addItemToCart({Product product, String id, BuildContext context}) =>
      _firestoreProvider.addToCart(context: context, product: product, id: id);
  removeFromCart({Product product, String id, BuildContext context}) =>
      _firestoreProvider.removeFromCart(
          context: context, id: id, product: product);

  Stream<QuerySnapshot> getCartDetails() => _firestoreProvider.getCartDetails();

  Stream<QuerySnapshot> orderItemList() => _firestoreProvider.getOrders();

  addIToOrders({Product product, String id, BuildContext context, int count}) =>
      _firestoreProvider.addOrder(
          context: context, product: product, orderId: id, count: count);
  cancelFromOrders({Product product, String id, BuildContext context}) =>
      _firestoreProvider.cancelOrder(
          context: context, id: id, product: product);
}
