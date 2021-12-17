import 'package:delivery_app/Screens/help_support.dart';
import 'package:delivery_app/Services/DBoperations.dart';
import 'package:delivery_app/Services/localStorage.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/Screens/my_orders.dart';

// username , email , phone , address
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background_Color,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0,top: 16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       //TODO order history
          //       Icon(Icons.history,size: 40,color: kPrimaryColor.withOpacity(0.5),),
          //     ],
          //   ),
          // ),
          Center(
            child: Container(
              child: Lottie.asset(
                'assets/profile.json',
                height: 150,
              ),
            ),
          ),
          Text(
            username,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontSize: 32),
          ),
          Text(
            userEmail,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor.withOpacity(0.5),
                fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(Icons.phone),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          userPhone,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor.withOpacity(0.4),
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //TODO address overflow condition
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(

               // height: 100,
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.03),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.home),
                    SizedBox(width: 15,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                        child: Text(
                          userAddress.substring(0,(userAddress.length>125)?125:userAddress.length),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          //maxLines: 3,
                        ),
                      ),
                    ),
                    Icon(Icons.change_circle_rounded)
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: Material(
              elevation: 2,
                borderRadius: BorderRadius.all(Radius.circular(20)),
            child: GestureDetector(
                onTap: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>help_and_support())
                );
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Icon(Icons.help_outline_outlined),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Help & Support',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor.withOpacity(0.4),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.navigate_next_rounded),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //TODO my orders
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: GestureDetector(
                onTap: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> order_history())
                );
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Icon(Icons.history),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'My Orders',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor.withOpacity(0.4),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.navigate_next_rounded),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //TODO logout
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: InkWell(
                  onTap: (){
                    logOutCurrentUser();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Icon(Icons.power_settings_new_rounded ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor.withOpacity(0.4),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.navigate_next_rounded),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logOutCurrentUser() async{
    await Storage().deleteData();
    await DbOperations().clearDataBase();
    Navigator.of(context).popUntil((route) => false);
    Phoenix.rebirth(context);
    //Navigator.push(context, route)
  }
}
