import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/Screens/preparing_food.dart';

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
            'assets/waiting.json',
            // 'assets/67225-delivery-food-interaction.json',
          ),
          Center(
            child: Text(
              'Waiting for confirmation',
              // orderId,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => preparing_food_())
          );
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child: Icon(Icons.navigate_next_rounded,color: Colors.white,),

        ),
      ),
    );
  }
}
