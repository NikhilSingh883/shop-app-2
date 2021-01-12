import 'package:flutter/material.dart';
import 'package:jugadu/bloc/cartBloc.dart';
import 'package:jugadu/constants.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.id,
  }) : super(key: key);

  final Product product;
  final String id;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.heightMultiplier;
    return Container(
      height: defaultSize * 45,
      padding: EdgeInsets.only(
        top: defaultSize * 5, //90
        left: defaultSize * 2, //20
        right: defaultSize * 2,
        bottom: defaultSize * 5,
      ),
      // height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 1.2),
          topRight: Radius.circular(defaultSize * 1.2),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.title,
              style: TextStyle(
                fontSize: defaultSize * 1.8,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: defaultSize * 3),
            Text(
              product.desc,
              style: TextStyle(
                color: kTextColor.withOpacity(0.7),
                height: 1.5,
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: FlatButton(
                padding: EdgeInsets.all(defaultSize * 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: kPrimaryColor,
                onPressed: () {
                  cartBloc.addToCart(
                      product: product, productId: id, context: context);
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: defaultSize * 1.6,
                    fontWeight: FontWeight.bold,
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
