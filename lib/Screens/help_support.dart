import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/constants.dart';
class help_and_support extends StatefulWidget {
  const help_and_support({Key? key}) : super(key: key);

  @override
  _help_and_supportState createState() => _help_and_supportState();
}

class _help_and_supportState extends State<help_and_support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset('assets/support.json',repeat: false),
          SizedBox(height: 25,),
          Text('Welcome to Support ',style: TextStyle(fontSize: 24),)

        ],
      ),
    );
  }
}
