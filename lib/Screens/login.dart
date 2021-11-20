import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
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
                Text(
                  "WELCOME BACK!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/waiter.png',
                      height: size.height * 0.4,
                    ),
                  ],
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Username ",
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(8, 0, 24, 0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: " Password ",
                        border: InputBorder.none,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(8, 0, 24, 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(30),
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
