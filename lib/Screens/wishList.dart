import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:delivery_app/Screens/cart.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
class wish_list extends StatefulWidget {
  const wish_list({Key? key}) : super(key: key);

  @override
  _wish_listState createState() => _wish_listState();
}

class _wish_listState extends State<wish_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        color: kPrimaryColor,
        backgroundColor: Colors.white,
        activeColor: kPrimaryColor,
        top: -16,
        items: [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.favorite_border),
          TabItem(
            icon: Icons.shopping_bag_outlined,
          ),
          TabItem(icon: Icons.person),
        ],
        initialActiveIndex: 1, //optional, default as 0
        onTap: (int i) => setState(
              () {
            if (i == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => cart()),
              );
            }
            else if (i == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => wish_list()),
              );
            }
          },
        ),
      ),
    );
  }
}
