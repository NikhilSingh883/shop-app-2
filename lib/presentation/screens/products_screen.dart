import 'package:flutter/material.dart';
import 'package:jugadu/bloc/cartBloc.dart';
import 'package:jugadu/bloc/productBloc.dart';
import 'package:jugadu/models/Product.dart';
import 'package:jugadu/models/ProductResponse.dart';
import 'package:jugadu/presentation/screens/components/product_card.dart';
import 'package:jugadu/presentation/screens/loading_screen.dart';
import 'package:jugadu/presentation/widgets/badge.dart';
import 'package:jugadu/size_config.dart';

class ProductsScreen extends StatefulWidget {
  final Function toggle;
  ProductsScreen(this.toggle);
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  bool isOpened = false;
  Animation<double> _animateIcon;
  bool showFabButton = false, card1 = true, card2 = false, card3 = false;

  @override
  void initState() {
    // TODO: implement initState
    productBloc..getProducts();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    showFabButton = !showFabButton;
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xff6c79dc),
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  Widget _hiddenButton({Widget icon, Function onPressed, int ms, String type}) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: ms),
      opacity: showFabButton ? 1 : 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: icon,
            onPressed: () {
              onPressed();
            },
          ),
          Text(type),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
            _hiddenButton(
              icon: Image(
                image: AssetImage('assets/images/money.png'),
                height: SizeConfig.heightMultiplier * 4,
              ),
              onPressed: () {
                productBloc.getProductsByMoney();
              },
              ms: 400,
              type: 'Price',
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 4,
            ),
            _hiddenButton(
              icon: Image(
                image: AssetImage('assets/images/types.png'),
                height: SizeConfig.heightMultiplier * 4,
              ),
              onPressed: () {
                productBloc.getProductsByType();
              },
              ms: 200,
              type: 'Category',
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 4,
            ),
            _floatingActionButton(),
          ],
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Image(
              image: AssetImage('assets/images/menu.png'),
              height: SizeConfig.heightMultiplier * 4,
            ),
            onPressed: widget.toggle,
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
                },
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
          ],
        ),
        body: SafeArea(
          child: StreamBuilder<ProductResponse>(
            stream: productBloc.subject.stream,
            builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return LoadingScreen();
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return ChapterWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
ChapterWidget(ProductResponse response) {
  final List<Product> _products = response.products;
  print(_products.length);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    scrollDirection: Axis.vertical,
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: _products.length,
    itemBuilder: (context, index) {
      return ProductCard(
        product: _products[index],
        id: _products[index].id,
        image: 'assets/images/${_products[index].title}.png',
      );
    },
  );
}

Widget _buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text("loading")],
  ));
}

Widget _buildErrorWidget(String error) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Error occured: $error"),
    ],
  ));
}
