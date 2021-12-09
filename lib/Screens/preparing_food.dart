import 'package:delivery_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/Screens/Maps.dart';
class preparing_food_ extends StatefulWidget {
  const preparing_food_({Key? key}) : super(key: key);

  @override
  _preparing_foodState createState() => _preparing_foodState();
}

class _preparing_foodState extends State<preparing_food_> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height:100),
          Container(
            child:Center(child: Lottie.asset('assets/60056-food.json')),
          ),
          Center(
            child: Text(
              'Food is Being Prepared',
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
              MaterialPageRoute(builder: (context) => map_())
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
