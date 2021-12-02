import 'package:delivery_app/Screens/pageManager.dart';
import 'package:delivery_app/Services/authentication.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';


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
                  Material(
                    elevation: 5,
                    shadowColor: kPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        //  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Image.asset('assets/images/title_image.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.1,),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email address'),
                          TextField(
                            controller: email,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text('mobile number'),
                          TextField(
                            controller: phone,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              width: 128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'OTP',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text('username'),
                          TextField(
                            controller: usrname,
                            decoration: InputDecoration(
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text('Password'),
                          TextField(
                            controller: pwd,
                            obscureText: true,
                            decoration: InputDecoration(
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:16, bottom: 16),
                            child: Container(
                              width: size.width * 0.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: FlatButton(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                    color: kPrimaryColor,
                                    onPressed: () async{
                                      setState(() {
                                        signingIn = true;
                                      });
                                      var isSignedIn = await Authentication().signUp(usrname.text, email.text, phone.text, pwd.text, false);
                                      if(isSignedIn == 'true'){
                                        getUserInfo();
                                        Navigator.popUntil(context, (route) => false);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PageManager()));
                                      }else{
                                        showSnackBar(isSignedIn, context,Colors.red);
                                      }
                                    },
                                    child: Text(
                                      "Signup",
                                      style: TextStyle(color: Colors.white),
                                    )
                                ),
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
              children: [
                Expanded(child: Row())
              ],
            )
          ],
        ),
      ),
    );
  }

}
