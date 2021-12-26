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
      appBar: AppBar(
        backgroundColor: Background_Color,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Offers',
          style: GoogleFonts.lato(fontSize: 24, color: kPrimaryColor),
        ),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: kPrimaryColor,
        ),
      ),

    );
  }

  Padding offerContainer() {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                color:Color(0xFF322193),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Center(child: Text('OFFER',style: TextStyle(fontSize: 64,fontWeight: FontWeight.bold,color: Colors.white),)),
          ),
        );
  }
}
