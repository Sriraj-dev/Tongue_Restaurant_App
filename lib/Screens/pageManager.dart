import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:delivery_app/Screens/ProfileScreen.dart';
import 'package:delivery_app/Screens/cart.dart';
import 'package:delivery_app/Screens/homePage.dart';
import 'package:delivery_app/Screens/wishList.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';

class PageManager extends StatefulWidget {
  const PageManager({Key? key}) : super(key: key);

  @override
  _PageManagerState createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  int currentIndex = 0;
  final screens = [
    Center(
      child: Text('home', style: TextStyle(fontSize: 24)),
    ),
    Center(
      child: Text('favorite', style: TextStyle(fontSize: 24)),
    ),
    Center(
      child: Text('cart', style: TextStyle(fontSize: 24)),
    ),
    Center(
      child: Text('profile', style: TextStyle(fontSize: 24)),
    ),
  ];
  final pages = [homePage(), wish_list(), cart(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        color: kPrimaryColor,
        backgroundColor: Colors.white,
        activeColor: kPrimaryColor,
        top: -16,
        items: [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.favorite_border),
          TabItem(icon:Icons.shopping_bag_outlined,

             ),
          TabItem(icon: Icons.person),
        ],
        initialActiveIndex: 0, //optional, default as 0
        onTap: (int i) {
          //3
          setState(() {
            currentIndex = i;
          });
        },
      ),
    );
  }
}
