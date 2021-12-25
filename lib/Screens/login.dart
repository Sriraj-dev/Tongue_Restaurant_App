import 'package:delivery_app/Screens/pageManager.dart';
import 'package:delivery_app/Services/authentication.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
import 'package:delivery_app/Screens/SignUp2.dart';
import 'package:delivery_app/Screens/homePage.dart ';
import 'package:flutter/rendering.dart';
import 'package:progress_indicators/progress_indicators.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController usr = new TextEditingController();
  TextEditingController pwd = new TextEditingController();

  bool loggingIn = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 64),
                    child: Text(
                      "WELCOME BACK!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            controller: usr,
                            decoration: InputDecoration(
                              hintText: " Username ",
                              border: InputBorder.none,
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(16, 0, 24, 0),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: ksecondaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          child: TextField(
                            controller: pwd,
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
                        Padding(
                          padding: const EdgeInsets.only(top:12.0),
                          child: Container(
                            decoration:BoxDecoration(

                              color: Colors.black,
                              borderRadius: BorderRadius.circular(33),

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: size.width * 0.6,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: FlatButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 40),
                                      color: kPrimaryColor,
                                      onPressed: () async {
                                        setState(() {
                                          loggingIn = true;
                                        });
                                        var isLogin = await Authentication()
                                            .login(usr.text, pwd.text, false);
                                        if (isLogin == 'true') {
                                          getUserInfo();
                                          Navigator.popUntil(
                                              context, (route) => false);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PageManager()),
                                          );
                                        } else {
                                          showSnackBar(
                                              isLogin, context, Colors.red);
                                          setState(() {
                                            loggingIn = false;
                                          });
                                        }
                                      },
                                      child: (loggingIn)
                                          ? CircularProgressIndicator()
                                          : Text(
                                              "Login",
                                              style: TextStyle(color: Colors.white,fontSize: 24),
                                            )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8, bottom: 16, left: 8),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ? ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUp2()),
                                    );
                                  },
                                    child: Text(
                                  "Signup",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
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
