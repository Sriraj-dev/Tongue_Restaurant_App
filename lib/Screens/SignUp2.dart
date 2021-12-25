import 'package:delivery_app/Screens/login.dart';
import 'package:delivery_app/Screens/pageManager.dart';
import 'package:delivery_app/Services/authentication.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({Key? key}) : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  TextEditingController usrname = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  bool signingIn = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: size.width * 0.4,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 64),
                      child: Text(
                        "WELCOME TO TONGUE!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8,),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24,),
                                  Container(
                                    child: TextField(
                                      controller: email,
                                      decoration: InputDecoration(
                                        hintText: " Email address ",
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
                                  SizedBox(height: 12,),
                                  Container(
                                    child: TextField(
                                      controller: phone,
                                      decoration: InputDecoration(
                                        hintText: " mobile number ",
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
                                  SizedBox(height: 12,),
                                  Container(
                                    child: TextField(
                                      controller: usrname,

                                      decoration: InputDecoration(
                                        hintText: " Username  ",
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
                                  SizedBox(height: 12,),
                                  Container(
                                    child: TextField(
                                      controller: pwd,
                                      decoration: InputDecoration(
                                        hintText: " Password",
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
                                  SizedBox(height:4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Container(
                                      width: size.width * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(33),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          width: size.width * 0.75,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(29),
                                            child: FlatButton(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15, horizontal: 40),
                                                color: kPrimaryColor,
                                                onPressed: () async {
                                                  setState(() {
                                                    signingIn = true;
                                                  });
                                                  var isSignedIn = await Authentication()
                                                      .signUp(usrname.text, email.text,
                                                      phone.text, pwd.text, false);
                                                  if (isSignedIn == 'true') {
                                                    getUserInfo();
                                                    Navigator.popUntil(
                                                        context, (route) => false);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PageManager()));
                                                  } else {
                                                    showSnackBar(
                                                        isSignedIn, context, Colors.red);
                                                  }
                                                },
                                                child: Text(
                                                  "Signup",
                                                  style: TextStyle(color: Colors.white,fontSize: 20),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an account ? ",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.black),
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => login()),
                                              );
                                            },
                                            child: Text(
                                              "Login ",
                                              style: TextStyle(
                                                  fontSize: 20, color: Colors.blue),
                                            ))
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [Expanded(child: Row())],
            )
          ],
        ),
      ),
    );
  }
}
