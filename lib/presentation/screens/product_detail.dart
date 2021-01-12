import 'package:flutter/material.dart';
import 'package:jugadu/bloc/cartBloc.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/presentation/screens/components/body.dart';
import 'package:jugadu/presentation/widgets/badge.dart';
import 'package:jugadu/size_config.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final String image;
  final String id;
  const ProductDetail(
      {Key key, this.product, @required this.image, @required this.id})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.heightMultiplier;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            child: StreamBuilder(
                stream: cartBloc.getCart(),
                builder: (context, snapshot) {
                  return Badge(
                    value:
                        snapshot.hasData ? snapshot.data.documents.length : 0,
                    color: Colors.red,
                  );
                }),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 2,
          ),
        ],
      ),
      body: Body(
        product: widget.product,
        defaultSize: defaultSize,
        id: widget.id,
        image: widget.image,
      ),
    );
  }
}
