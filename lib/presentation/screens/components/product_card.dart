import 'package:flutter/material.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/components/title_text.dart';
import 'package:jugadu/presentation/screens/product_detail.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
    @required this.image,
    @required this.id,
  }) : super(key: key);
  final Product product;
  final String image;
  final String id;
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.heightMultiplier;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetail(
                id: id,
                product: product,
                image: image,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(defaultSize * 2), //20
        child: SizedBox(
          width: defaultSize * 50.5, //205
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              // This is custom Shape thats why we need to use ClipPath
              ClipPath(
                clipper: ProductCustomShape(),
                child: Container(
                  width: SizeConfig.widthMultiplier * 40,
                  child: Container(
                    padding: EdgeInsets.all(defaultSize * 2),
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TitleText(title: product.title),
                        SizedBox(height: defaultSize),
                        Text(
                          "${product.stock} + Products",
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.6),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: SizeConfig.heightMultiplier * 10,
                  child: Hero(
                    tag: id,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/spinner.gif'),
                      image: AssetImage(
                        image,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;
    double cornerSize = 30;

    path.lineTo(0, height - cornerSize);
    path.quadraticBezierTo(0, height, cornerSize, height);
    path.lineTo(width - cornerSize, height);
    path.quadraticBezierTo(width, height, width, height - cornerSize);
    path.lineTo(width, cornerSize);
    path.quadraticBezierTo(width, 0, width - cornerSize, 0);
    path.lineTo(cornerSize, cornerSize * 0.75);
    path.quadraticBezierTo(0, cornerSize, 0, cornerSize * 2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
