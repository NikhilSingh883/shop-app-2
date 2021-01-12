import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:jugadu/models/Product.dart';
import 'package:jugadu/repository/repository.dart';

class OrdersBloc {
  final _repo = Repository();
  final orderStreamController = StreamController.broadcast();

  Stream get getCartStream => orderStreamController.stream;

  Stream<QuerySnapshot> getOrders() {
    return _repo.orderItemList();
  }

  void addOrder(
      {String orderId, Product product, BuildContext context, int count}) {
    _repo.addIToOrders(
        context: context, product: product, id: orderId, count: count);
  }

  void cancelOrder({String productId, Product product, BuildContext context}) {
    _repo.cancelFromOrders(context: context, product: product, id: productId);
  }

  void dispose() {
    orderStreamController.close();
  }
}

final orderBloc = OrdersBloc();
