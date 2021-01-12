import 'package:flutter/material.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/components/productDescription.dart';
import 'package:jugadu/presentation/screens/components/productInfo.dart';
import 'package:jugadu/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.product,
    @required this.defaultSize,
    @required this.id,
    @required this.image,
  }) : super(key: key);

  final Product product;
  final double defaultSize;
  final String id;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height:
            SizeConfig.heightMultiplier * 100 - AppBar().preferredSize.height,
        child: Stack(
          children: <Widget>[
            ProductInfo(product: product),
            Align(
              alignment: Alignment.bottomCenter,
              child: ProductDescription(
                product: product,
                id: product.id,
              ),
            ),
            Positioned(
              bottom: SizeConfig.heightMultiplier * 15.5,
              right: SizeConfig.widthMultiplier * 4,
              child: Hero(
                tag: id,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  height: defaultSize * 80,
                  width: SizeConfig.widthMultiplier * 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
