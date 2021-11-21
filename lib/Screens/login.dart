import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
import 'package:delivery_app/Screens/homePage.dart ';
import 'package:flutter/rendering.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_top.png',
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: size.width * 0.4,
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 64),
                    child: Text(
                      "WELCOME BACK!",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/6.png',
                          height: size.height * 0.4,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: " Username ",
                        border: InputBorder.none,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(16, 0, 24, 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: " Password ",
                        border: InputBorder.none,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(16, 0, 24, 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          color: kPrimaryColor.withOpacity(0),
                          onPressed: () {
                            //TODO ------------------------forgot password------------------
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => login()),
                            // );
                          },
                          child: Text(
                            "Forgot password",
                            style: TextStyle(color:kPrimaryColor),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            color: kPrimaryColor,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => homePage()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.05,
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}
