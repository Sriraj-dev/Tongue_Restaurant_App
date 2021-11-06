import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
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
        "Ambrocia's",
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
          Icons.notifications_none_outlined,
          color: kTextColor,
        ),
        onPressed: () => {},
      ),
    ],
  );
}
