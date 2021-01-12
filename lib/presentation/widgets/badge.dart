import 'package:flutter/material.dart';
import 'package:jugadu/presentation/screens/cart_screen.dart';
import 'package:jugadu/size_config.dart';

class Badge extends StatefulWidget {
  const Badge({
    Key key,
    @required this.value,
    this.color,
  }) : super(key: key);

  final int value;
  final Color color;

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage(
              'assets/images/cart.png',
            ),
            // color: Colors.black,
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(2.0),
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.heightMultiplier * 2),
                color: widget.color != null
                    ? widget.color
                    : Theme.of(context).accentColor,
              ),
              constraints: BoxConstraints(
                minWidth: SizeConfig.widthMultiplier * 4,
                minHeight: SizeConfig.heightMultiplier * 1.8,
              ),
              child: Text(
                '${widget.value}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 1.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
