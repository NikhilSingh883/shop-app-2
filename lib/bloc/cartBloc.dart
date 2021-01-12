import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/repository/repository.dart';

class CartBloc {
  final _repo = Repository();
  final cartStreamController = StreamController.broadcast();
  final cartPriceController = StreamController.broadcast();
  final cartItemsCountController = StreamController.broadcast();

  Stream get getCountStream => cartItemsCountController.stream;
  Stream get getPriceStream => cartPriceController.stream;
  Stream get getCartStream => cartStreamController.stream;

  Stream<QuerySnapshot> getCart() {
    return _repo.cartItemList();
  }

  Stream<QuerySnapshot> getCartDetails() {
    return _repo.getCartDetails();
  }

  void addToCart({String productId, Product product, BuildContext context}) {
    _repo.addItemToCart(context: context, product: product, id: productId);
  }

  void removeFromCart(
      {String productId, Product product, BuildContext context}) {
    _repo.removeFromCart(context: context, product: product, id: productId);
  }

  void dispose() {
    cartStreamController.close();
    cartItemsCountController.close();
    cartPriceController.close();
  }
}

final cartBloc = CartBloc();
