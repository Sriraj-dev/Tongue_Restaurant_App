import 'package:delivery_app/Screens/pageManager.dart';
import 'package:delivery_app/Services/authentication.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/painting.dart';
import 'package:delivery_app/Screens/homePage.dart ';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
                      style: GoogleFonts.baloo(
                        color: kPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 30
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Lottie.asset('assets/userLogin.json',width: size.width*0.9)
                      ],
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: usr,
                      decoration: InputDecoration(
                        hintText: " Username ",
                        prefixIcon: Icon(Icons.person_rounded),
                        border: InputBorder.none,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(16, 0, 24, 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  Container(
                    child: TextField(
                      controller: pwd,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_rounded),
                        hintText: " Password ",
                        border: InputBorder.none,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(16, 0, 24, 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15,bottom: 20,top: 8),
                        child: GestureDetector(
                          onTap: (){
                            //TODO ------------------------forgot password------------------
                          },
                          child: Text('Forgot Password?',
                            style: GoogleFonts.lato(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            color: kPrimaryColor,
                            onPressed: () async{
                              setState(() {
                                loggingIn = true;
                              });
                              var isLogin = await Authentication().login(usr.text,pwd.text , false);
                              if(isLogin == 'true'){
                                getUserInfo();
                                Navigator.popUntil(context, (route) => false);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PageManager()),
                                );
                              }else{
                                showSnackBar(isLogin, context,Colors.red);
                                setState(() {
                                  loggingIn = false;
                                });
                              }

                            },
                            child: (loggingIn)?CircularProgressIndicator():Text(
                              "Login",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.white,
                              ),
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
