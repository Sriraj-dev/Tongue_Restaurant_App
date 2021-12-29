import 'package:delivery_app/Screens/pageManager.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/Services/authentication.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
  String errorText = '';
  bool enableError = false;
  final globalKey = GlobalKey<FormState>();
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
                      child: Form(
                        key: globalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email address'),
                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty)
                                  return "Email can't be empty";
                                if(!value.contains("@"))
                                  return "Enter a valid email";
                                return null;
                              },
                              controller: email,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text('mobile number'),
                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty)
                                  return "PhoneNo. can't be empty";
                                if(value.length!=10){
                                  return "Invalid PhoneNo.";
                                }else{
                                  for(int i=0;i<value.length;i++){
                                    int num = int.parse(value[i]);
                                    if(num.toString() != value[i]){
                                      return "Invalid PhoneNo.";
                                    }
                                  }
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.phone,
                              controller: phone,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text('username'),
                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty)
                                  return "Username can't be empty";
                                return null;
                              },
                              controller: usrname,
                              decoration: InputDecoration(
                                helperText: "You will need to use this everytime you login",
                                errorText: (enableError)?errorText:null,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text('Password'),
                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty)
                                  return "Password can't be empty";
                                if(value.length<6)
                                  return "Password must contain atleast 6 characters";
                                return null;
                              },
                              controller: pwd,
                              obscureText: true,
                              decoration: InputDecoration(
                              ),
                            ),
                            SizedBox(height: 25,),
                            Padding(
                              padding: const EdgeInsets.only(top:16, bottom: 16),
                              child: Container(
                                width: size.width * 0.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: FlatButton(
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                      color: kPrimaryColor,
                                      onPressed: (signingIn)?(){}:() async{
                                        setState(() {
                                          signingIn = true;
                                        });
                                        var usernameValid = true;
                                        if(usrname.text.length!=0){
                                          usernameValid = await ApiServices().checkUser(usrname.text);
                                          if(usernameValid){
                                            setState(() {
                                              errorText = "username already taken!";
                                              enableError = true;
                                            });
                                          }
                                        }
                                        if(globalKey.currentState!.validate() && (!usernameValid)){
                                          var isSignedIn = await Authentication().signUp(usrname.text, email.text, phone.text, pwd.text, false);
                                          if(isSignedIn == 'true'){
                                            getUserInfo();
                                            Navigator.popUntil(context, (route) => false);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PageManager()));
                                          }else{
                                            setState(() {
                                              signingIn = false;
                                            });
                                            showSnackBar(isSignedIn, context,Colors.red);
                                          }
                                        }else{
                                          setState(() {
                                            signingIn = false;
                                          });
                                        }
                                      },
                                      child: (signingIn)?CircularProgressIndicator(
                                        color: Colors.white,
                                      ):Text(
                                        "Signup",
                                        style: GoogleFonts.lato(color: Colors.white,fontSize:18 ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
