import 'package:delivery_app/Screens/SignUp2.dart';
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
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/chicken-leg.png',
                      height: size.height * 0.4,
                    ),
                  ],
                ),

                Container(
                  width: size.width * 0.8,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(31),
                  ),
                  child: Container(
                    width: size.width * 0.75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          color: kPrimaryColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => login()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white,fontSize: 24),
                          )),
                    ),
                  ),
                ),
                SizedBox(height:16),

                Container(
                  width: size.width * 0.8,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(31),
                  ),
                  child: Container(
                    width: size.width * 0.75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          color: ksecondaryColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp2()),
                            );
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
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
