import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/constants.dart';
class order_history extends StatefulWidget {
  const order_history({Key? key}) : super(key: key);

  @override
  _order_historyState createState() => _order_historyState();
}

class _order_historyState extends State<order_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(child: Lottie.asset('assets/history.json',repeat: false,height: 200)),
        ],
      ),
    );
  }
}
