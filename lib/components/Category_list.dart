import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:delivery_app/components/Category_Items.dart';
class Category_list extends StatelessWidget {
  const Category_list({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView (
      scrollDirection : Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CategoryItem(
            title: "biryani",
            isActive: true,
            press: () {},
          ),
          CategoryItem(
            title: "chinese",
            isActive: false,
            press: () {},
          ),
          CategoryItem(
            title: "starters",
            isActive: false,
            press: () {},
          ),
          CategoryItem(
            title: "Beaverages",
            isActive: false,
            press: () {},
          ),
          CategoryItem(
            title: "juices",
            isActive: false,
            press: () {},
          ),
        ],
      ),
    );
  }
}
