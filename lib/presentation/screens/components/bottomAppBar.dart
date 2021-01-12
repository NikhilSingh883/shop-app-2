import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jugadu/bloc/cartBloc.dart';
import 'package:jugadu/bloc/ordersBloc.dart';
import 'package:jugadu/helper/constants.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/welcome_screen.dart';
import 'package:jugadu/size_config.dart';

class BtmAppBar extends StatelessWidget {
  const BtmAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mp = [];
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 5,
          vertical: SizeConfig.heightMultiplier * 1.5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: StreamBuilder(
                stream: cartBloc.getCartDetails(),
                builder: (context, snapshot) {
                  double amount = 0;

                  if (snapshot.hasData && snapshot.data.documents.length > 0) {
                    print(snapshot.data.documents[0]['title']);
                    for (var i = 0; i < snapshot.data.documents.length; i++) {
                      amount += snapshot.data.documents[i]['count'] *
                          snapshot.data.documents[i]['price'];
                      mp.add({
                        'title': snapshot.data.documents[i]['title'],
                        'desc': snapshot.data.documents[i]['desc'],
                        'category': snapshot.data.documents[i]['category'],
                        'price': snapshot.data.documents[i]['price'],
                        'rating': snapshot.data.documents[i]['rating'],
                        'stock': snapshot.data.documents[i]['stock'],
                        'id': snapshot.data.documents[i]['id'],
                        'count': snapshot.data.documents[i]['count'],
                      });
                    }
                  }
                  return Text(
                    '\$ $amount',
                    style:
                        TextStyle(fontSize: SizeConfig.heightMultiplier * 2.5),
                  );
                },
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                print(Constants.userId);

                for (int i = 0; i < mp.length; i++) {
                  orderBloc.addOrder(
                    context: context,
                    product: Product(
                      category: mp[i]['category'],
                      title: mp[i]['title'],
                      rating: mp[i]['rating'],
                      stock: mp[i]['stock'],
                      price: mp[i]['price'],
                      id: mp[i]['id'],
                      desc: mp[i]['desc'],
                    ),
                    orderId: mp[i]['id'],
                    count: mp[i]['count'],
                  );
                }

                String msg = 'Successfully Ordered';
                Scaffold.of(context).showSnackBar(showSB(msg));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2,
                  horizontal: SizeConfig.widthMultiplier * 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.pink[400],
                  borderRadius: BorderRadius.circular(
                    SizeConfig.heightMultiplier,
                  ),
                ),
                child: Text(
                  'Place Order'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.heightMultiplier * 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
