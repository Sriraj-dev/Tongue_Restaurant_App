import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/Screens/help_support.dart';


class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/maintainence.json'),
          Center(
            child: Text(
              'The app is currently under maintenance!',
              style: GoogleFonts.lato(
                fontSize: 17
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 30),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>help_and_support())
                );
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.06),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Icon(Icons.help_outline_outlined),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Help & Support',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor.withOpacity(0.4),
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.navigate_next_rounded),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
