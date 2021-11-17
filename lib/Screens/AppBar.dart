import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Background_Color,
    elevation: 0,
    //menu
    leading: IconButton(
      icon: Icon(
        Icons.menu_rounded,
        color: kTextColor,
      ),
      onPressed: () => {},
    ),
    // title
    title: new Center(
      child: Text(
        "Tongue",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: kTextColor,
        ),
      ),
    ),
    //notifications
    actions: [
      IconButton(
        icon: Icon(
          Icons.shopping_cart_outlined ,
          color: kTextLightColor,
        ),
        onPressed: () => {},
      ),
    ],
  );
}
