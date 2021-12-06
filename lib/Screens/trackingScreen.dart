import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TrackingPage extends StatefulWidget {
  //const TrackingPage({Key? key}) : super(key: key);
  String orderId;
  TrackingPage(this.orderId);
  @override
  _TrackingPageState createState() => _TrackingPageState(orderId);
}

class _TrackingPageState extends State<TrackingPage> {
  String orderId;
  _TrackingPageState(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/67225-delivery-food-interaction.json',
          ),
          Center(
            child: Text(
              orderId,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
