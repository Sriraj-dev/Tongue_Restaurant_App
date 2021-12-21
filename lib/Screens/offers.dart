import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/constants.dart';
class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background_Color,
      body:Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:40,left: 12),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor.withOpacity(0.2),
                  ),
                  child: IconButton(
                    iconSize: 25,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 100,),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'Offers',
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color:Color(0xFF322193),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Center(child: Text('OFFER',style: TextStyle(fontSize: 64,fontWeight: FontWeight.bold,color: Colors.white),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(child: Text('OFFER',style: TextStyle(fontSize: 64,fontWeight: FontWeight.bold,color: Colors.white),)),

              height: 150,
              decoration: BoxDecoration(
                  color:Color(0xFFFCD400),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(child: Text('OFFER',style: TextStyle(fontSize: 64,fontWeight: FontWeight.bold,color: Colors.white),)),

              height: 150,
              decoration: BoxDecoration(
                  color:Color(0xFFE33365),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          ),

        ],
      )
    );
  }
}
