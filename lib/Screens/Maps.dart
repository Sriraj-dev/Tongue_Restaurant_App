import 'package:delivery_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/Screens/out_for_delivery.dart';
class map_ extends StatefulWidget {
  const map_({Key? key}) : super(key: key);

  @override
  _map_State createState() => _map_State();
}

class _map_State extends State<map_> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child : Lottie.asset('assets/map.json'),
          ),
          Text(
            'Finding the Best route',
            // orderId,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => out_for_delivery_())
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
