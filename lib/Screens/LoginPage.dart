import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/Services/securityServices.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:delivery_app/Screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usr = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  TextEditingController phn = new TextEditingController();
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
            Positioned(
              bottom: 0,
              left:0,
              child: Image.asset('assets/images/main_bottom.png',width: size.width*0.2,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                  "WELCOME TO TONGUE",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/1.png',
                      height: size.height * 0.3,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/2.png',
                      height: size.height * 0.2,
                    ),
                  ],
                ),
                Container(
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
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
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  //TODO------------sign up-------------------
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                          padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          color: kPrimaryLightColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => login()),
                            );
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.black),
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
