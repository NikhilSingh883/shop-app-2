import 'package:flutter/material.dart';
import 'package:jugadu/constants.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/size_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.heightMultiplier;
    TextStyle lightTextStyle = TextStyle(color: kTextColor.withOpacity(0.6));
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
      height: defaultSize * 37.5, //375
      width: defaultSize * 15, //150
      // color: Colors.black45,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(product.category.toUpperCase(), style: lightTextStyle),
            SizedBox(height: defaultSize),
            Text(
              product.title,
              style: TextStyle(
                fontSize: defaultSize * 3, //24
                fontWeight: FontWeight.bold,
                letterSpacing: -0.8,
                height: 1.4,
              ),
            ),
            SizedBox(height: defaultSize * 2),
            Text("Form", style: lightTextStyle),
            Text(
              "\$${product.price}",
              style: TextStyle(
                fontSize: defaultSize * 1.6, //16
                fontWeight: FontWeight.bold,
                height: 1.6,
              ),
            ),
            SizedBox(height: defaultSize * 2),
            RatingBarIndicator(
              rating: product.rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber[600],
              ),
              itemCount: 5,
              itemSize: SizeConfig.heightMultiplier * 3,
              direction: Axis.vertical,
              unratedColor: Colors.amber[200],
            ),
          ],
        ),
      ),
    );
  }

//   Container buildColorBox(double defaultSize,
//       {Color color, bool isActive = false}) {
//     return Container(
//       margin: EdgeInsets.only(top: defaultSize, right: defaultSize),
//       // For  fixed value we can use cont for better performance
//       padding: const EdgeInsets.all(5),
//       height: defaultSize * 2.4,
//       width: defaultSize * 2.4,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: isActive ? SvgPicture.asset("assets/icons/check.svg") : SizedBox(),
//     );
//   }
// }
}
