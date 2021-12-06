import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// username , email , phone , address
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background_Color,
      body: Column(
        children: [
          SizedBox(height: 40,),
          Center(
            child: Container(
              child :(username == '')
                  ? Text('Username not found')
                  : Text('User found = $username',
              style: GoogleFonts.lato(
                fontSize: 17,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
