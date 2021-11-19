import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/Services/securityServices.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
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
    bool login_or_not = false;
    return Scaffold(
      backgroundColor: Background_Color,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: Text(
                        "TONGUE",
                        style: TextStyle(
                          color: kTextColor,
                          //backgroundColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: kTextColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: Container(
                                    width: 150,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: kTextLightColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Signup',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: kTextColor),
                                ),
                                if (!login_or_not)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                    child: Container(
                                      width: 150,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: kTextLightColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
              ),
            ),
          ),
          Container(
            height: 450,
          ),
        ],
      ),
    );
  }
}

