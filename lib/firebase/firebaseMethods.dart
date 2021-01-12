import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugadu/helper/constants.dart';
import 'package:jugadu/helper/helper_functions.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/components/customDrawer.dart';
import 'package:jugadu/presentation/screens/welcome_screen.dart';

class FirebaseMethods {
  Future signOut(FirebaseAuth auth, BuildContext context) async {
    try {
      await auth.signOut();
      Scaffold.of(context).showSnackBar(
        showSB('Sign in to continue'),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn({
    @required String email,
    @required String password,
    @required BuildContext context,
    @required FirebaseAuth auth,
  }) async {
    String msg = '';
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (!user.emailVerified) {
        signOut(auth, context);
        msg =
            'Please verify your email address by clicking on the link sent on your registered email id.😅';
        Scaffold.of(context).showSnackBar(
          showSB(msg),
        );
      } else {
        Navigator.of(context).pushReplacementNamed(CustomDrawer.routeName);

        HelperFunctions.saveUserEmailSharedPreference(user.email);
        HelperFunctions.saveUserIdSharedPreference(user.uid);
      }
    } catch (e) {
      msg = e.message.toString() + '😅';
      if (msg != null) {
        Scaffold.of(context).showSnackBar(showSB(msg));
      }
    }
  }

  Future<void> resetPassword({
    @required String email,
    @required FirebaseAuth auth,
    @required BuildContext context,
  }) async {
    String msg = '';

    try {
      await auth.sendPasswordResetEmail(email: email);
      msg = 'Check your email for resetting your password';
      Scaffold.of(context).showSnackBar(showSB(msg));
    } catch (e) {
      msg = e.message.toString() + '😅';
      if (msg != null) {
        Scaffold.of(context).showSnackBar(showSB(msg));
      }
    }
  }

  Future<void> signUp({
    @required String email,
    @required String password,
    @required FirebaseAuth auth,
    @required BuildContext context,
  }) async {
    String msg = '';
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      user.sendEmailVerification();
      msg =
          'Please verify your email address by clicking on the link sent on your registered email id and then try to sign in. 😅';
      signOut(auth, context);
      Scaffold.of(context).showSnackBar(showSB(msg));
      HelperFunctions.saveUserEmailSharedPreference(user.email);
      HelperFunctions.saveUserIdSharedPreference(user.uid);
      // user.displayName = name;
    } catch (e) {
      msg = e.message.toString() + '😅';
      if (msg != null) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
        throw Exception();
      }
    }
  }

  Future<void> addToCart(
      {Product product, String id, BuildContext context}) async {
    String msg = '';
    try {
      final itemRef = FirebaseFirestore.instance
          .collection('UserBasket')
          .doc(Constants.userId)
          .collection('items')
          .doc(id);

      final doc = await itemRef.get();

      if (!doc.exists) {
        itemRef.set({
          'title': product.title,
          'desc': product.desc,
          'category': product.category,
          'price': product.price.toDouble(),
          'rating': product.rating.toDouble(),
          'stock': product.stock.toDouble(),
          'id': product.id,
          'count': 1,
        });
      } else {
        itemRef.update({
          'title': product.title,
          'desc': product.desc,
          'category': product.category,
          'price': product.price.toDouble(),
          'rating': product.rating.toDouble(),
          'stock': product.stock.toDouble(),
          'id': product.id,
          'count': doc.data()['count'] + 1,
        });
      }

      msg = 'Successfully added to cart ,please head out to cart to checkout';
      Scaffold.of(context).showSnackBar(showSB(msg));
    } catch (err) {
      msg = 'Something went wrong !';
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
      throw Exception();
    }
  }

  Future<void> removeFromCart(
      {Product product, String id, BuildContext context}) async {
    String msg = '';
    try {
      final itemRef = FirebaseFirestore.instance
          .collection('UserBasket')
          .doc(Constants.userId)
          .collection('items')
          .doc(id);
      print(id);
      final doc = await itemRef.get();
      if (!doc.exists) {
        msg = 'Item doesnt exist !';
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
      } else {
        if (doc.data()['count'] == 1) {
          itemRef.delete();
          msg = 'Successfully removed';
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
        } else {
          itemRef.update({
            'title': product.title,
            'desc': product.desc,
            'category': product.category,
            'price': product.price.toDouble(),
            'rating': product.rating.toDouble(),
            'stock': product.stock.toDouble(),
            'id': product.id,
            'count': doc.data()['count'] - 1,
          });
          msg = 'Quantity reduced';
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
        }
      }
    } catch (err) {
      msg = 'Something went wrong !';
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
      throw Exception();
    }
  }

  Stream<QuerySnapshot> getCart() {
    Stream<QuerySnapshot> c;
    if (Constants.userId != '')
      return FirebaseFirestore.instance
          .collection('UserBasket')
          .doc(Constants.userId)
          .collection('items')
          .snapshots();

    return c;
  }

  Stream<QuerySnapshot> getOrders() {
    return FirebaseFirestore.instance
        .collection('UserOrders')
        .doc(Constants.userId)
        .collection('orders')
        .snapshots();
  }

  Stream<void> getCartDetails() {
    return FirebaseFirestore.instance
        .collection('UserBasket')
        .doc(Constants.userId)
        .collection('items')
        .snapshots();
  }

  Future<void> addOrder(
      {Product product,
      String orderId,
      BuildContext context,
      int count}) async {
    String msg = '';
    try {
      final itemRef = FirebaseFirestore.instance
          .collection('UserOrders')
          .doc(Constants.userId)
          .collection('orders')
          .doc(orderId);
      await FirebaseFirestore.instance
          .collection('UserBasket')
          .doc(Constants.userId)
          .collection('items')
          .doc(orderId)
          .delete();
      itemRef.set(
        {
          'title': product.title,
          'desc': product.desc,
          'category': product.category,
          'price': product.price.toDouble(),
          'rating': product.rating.toDouble(),
          'stock': product.stock.toDouble(),
          'id': product.id,
          'count': count,
          'orderDate': DateTime.now()
        },
      );

      // msg = 'Successfully Ordered';
      // Scaffold.of(context).showSnackBar(showSB(msg));
    } catch (err) {
      msg = 'Something went wrong !';
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
      throw Exception();
    }
  }

  Future<void> cancelOrder(
      {Product product, String id, BuildContext context}) async {
    String msg = '';
    try {
      final itemRef = FirebaseFirestore.instance
          .collection('UserOrders')
          .doc(Constants.userId)
          .collection('orders')
          .doc(id);

      final doc = await itemRef.get();
      if (!doc.exists) {
        msg = 'Order doesnt exist !';
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
      } else {
        itemRef.delete();
        msg = 'Order Cancelled';
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (err) {
      msg = 'Something went wrong !';
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
      throw Exception();
    }
  }
}
