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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48.0, left: 16),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);

                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
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
              ),

            ],
          ),
        ),
      ),
      body:Column(
        children: [
          SizedBox(height: 50,),
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
