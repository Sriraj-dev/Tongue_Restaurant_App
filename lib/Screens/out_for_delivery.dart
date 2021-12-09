import 'package:delivery_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class out_for_delivery_ extends StatefulWidget {
  const out_for_delivery_({Key? key}) : super(key: key);

  @override
  _out_for_delivery_State createState() => _out_for_delivery_State();
}

class _out_for_delivery_State extends State<out_for_delivery_> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset('assets/out_for_delivery.json'),
          ),
          Text(
            'Out for Delivery',
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
