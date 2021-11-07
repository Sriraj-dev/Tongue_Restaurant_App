import 'package:delivery_app/Screens/LoginPage.dart';
import 'package:delivery_app/Screens/homePage.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor ,
          scaffoldBackgroundColor: Colors.white ,
          textTheme: TextTheme(
          bodyText1: TextStyle(color: ksecondaryColor ),
            bodyText2: TextStyle(color: ksecondaryColor ),
          ) ,
        ),
        home: homePage(),
  ));
}
