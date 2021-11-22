import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:delivery_app/Screens/dish.dart';
import 'package:delivery_app/Screens/wishList.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
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
        initialActiveIndex: 2, //optional, default as 0
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
