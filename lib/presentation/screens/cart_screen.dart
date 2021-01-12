import 'package:flutter/material.dart';
import 'package:jugadu/bloc/cartBloc.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/components/bottomAppBar.dart';
import 'package:jugadu/presentation/screens/loading_screen.dart';
import 'package:jugadu/presentation/widgets/productTile.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomNavigationBar: BtmAppBar(),
      body: StreamBuilder(
        stream: cartBloc.getCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingScreen();
          final dataa = snapshot.hasData ? snapshot.data.documents : [];
          if (snapshot.data.documents.length == 0)
            return Center(
              child: Image(
                image: AssetImage('assets/images/emptyCart.png'),
              ),
            );
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: dataa.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      product: Product(
                        category: dataa[index]['category'],
                        title: dataa[index]['title'],
                        desc: dataa[index]['desc'],
                        stock: dataa[index]['stock'],
                        price: dataa[index]['price'],
                        id: dataa[index]['id'],
                        rating: dataa[index]['rating'],
                      ),
                      count: dataa[index]['count'],
                      image: 'assets/images/${dataa[index]['title']}.png',
                    );
                  },
                )
              : LoadingScreen();
        },
      ),
    );
  }
}

// ProductTile(
//         product: Product(
//           title: 'Aloevera Soap',
//           desc: 'This is a soap which is very good with aloevera.',
//           category: 'Body Care',
//           price: 100,
//           rating: 5,
//           stock: 300,
//         ),
//         image: 'assets/images/alovera_soap.png',
//         count: 3,
//       ),
