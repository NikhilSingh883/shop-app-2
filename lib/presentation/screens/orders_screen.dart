import 'package:flutter/material.dart';
import 'package:jugadu/bloc/ordersBloc.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/loading_screen.dart';
import 'package:jugadu/presentation/widgets/orderTile.dart';
import 'package:uuid/uuid.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Orders',
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
      body: StreamBuilder(
        stream: orderBloc.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingScreen();
          final dataa = snapshot.hasData ? snapshot.data.documents : null;
          if (snapshot.data.documents.length == 0)
            return Center(
              child: Image(
                image: AssetImage('assets/images/noOrder.png'),
              ),
            );
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: dataa.length,
                  itemBuilder: (context, index) {
                    print(dataa[index]['title']);
                    // print(dataa.values.toList()[index]);
                    return OrderTile(
                      product: Product(
                        category: dataa[index]['category'],
                        title: dataa[index]['title'],
                        desc: dataa[index]['desc'],
                        stock: dataa[index]['stock'],
                        price: dataa[index]['price'],
                        id: dataa[index]['id'],
                        rating: dataa[index]['rating'],
                      ),
                      id: dataa[index]['id'],
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

// OrderTile(
//                       product: Product(
//                         category: dataa[index]['category'],
//                         title: dataa[index]['title'],
//                         desc: dataa[index]['desc'],
//                         stock: dataa[index]['stock'],
//                         price: dataa[index]['price'],
//                         id: dataa[index]['id'],
//                         rating: dataa[index]['rating'],
//                       ),
//                       count: dataa[index]['count'],
//                       image: 'assets/images/${dataa[index]['title']}.png',
//                     );
