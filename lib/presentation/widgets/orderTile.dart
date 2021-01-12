import 'package:flutter/material.dart';
import 'package:jugadu/bloc/ordersBloc.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/product_detail.dart';
import 'package:jugadu/size_config.dart';

class OrderTile extends StatelessWidget {
  final Product product;
  final String image;
  final int count;
  final DateTime date;
  final String id;
  OrderTile({this.product, this.image, this.count, this.date, this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: SizeConfig.heightMultiplier * 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier * 2),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductDetail(
                        id: product.id,
                        product: product,
                        image: image,
                      );
                    },
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  product.title,
                  style: TextStyle(
                    fontSize: SizeConfig.heightMultiplier * 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  product.desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: Hero(
                  tag: product.id,
                  child: Image(
                    image: AssetImage(image),
                  ),
                ),
                trailing: CircleAvatar(
                  backgroundColor: Colors.red[400],
                  child: Text(
                    'X' + ' $count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.heightMultiplier * 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              endIndent: SizeConfig.widthMultiplier * 5,
              indent: SizeConfig.widthMultiplier * 5,
            ),
            Container(
              // color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text('Total cost: \$ ${product.price * count}'),
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      orderBloc.cancelOrder(
                          context: context, productId: id, product: product);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
