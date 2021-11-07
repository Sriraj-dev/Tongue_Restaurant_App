import 'package:flutter/material.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:delivery_app/Screens/AppBar.dart';
import 'package:delivery_app/Screens/Body.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

//-------------------------------------------------jashwanth-------------------
class _LoginPageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body:Body(),
    );
  }
}

