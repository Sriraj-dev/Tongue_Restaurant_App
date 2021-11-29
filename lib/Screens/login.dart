import 'package:delivery_app/Screens/pageManager.dart';
import 'package:delivery_app/Services/authentication.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
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
                      controller: usr,
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
                            onPressed: () async{
                              var isLogin = await Authentication().login(usr.text,pwd.text , false);
                              if(isLogin == 'true'){
                                getUserInfo();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PageManager()),
                                );
                              }else{
                                showSnackBar(isLogin, context);
                              }

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

  void showSnackBar(String isLogin, BuildContext context) { // isLogin == usernmae is incorrect or password is incorect;
     final snackBar  = SnackBar(
      content: Text(isLogin) ,
      backgroundColor: Colors.red,
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 20),
      behavior: SnackBarBehavior.floating,
    );
    //Scaffold.of(context).showSnackBar(snackBar)
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
