import 'package:delivery_app/Screens/SignUp2.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:delivery_app/Screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //size has now given us the screen size
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left:0,
              child: Image.asset('assets/images/main_top.png',width: size.width*0.3,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(),
                Text(
                  "WELCOME TO TONGUE",
                  style: GoogleFonts.baloo(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 25),
                ),
                SizedBox(height: 25,),
                Lottie.asset('assets/userMain.json'),
                SizedBox(height: 35,),
                Container(
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => login()),
                          );
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                              color: Colors.white,
                          ),
                        )),
                  ),
                ),
                Padding(
                  //TODO------------sign up-------------------
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FlatButton(
                          padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          color: kPrimaryLightColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp2()),
                            );
                          },
                          child: Text(
                            "Signup",
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}
