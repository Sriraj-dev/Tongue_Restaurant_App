import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0,top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //TODO order history
                Icon(Icons.history,size: 40,color: kPrimaryColor.withOpacity(0.5),),
              ],
            ),
          ),
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Container(

              height: 100,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Text(
                          userAddress,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  // Icon(Icons.edit_location_alt )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(Icons.support_agent_rounded),
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
          //TODO refer and earn
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(Icons.support_agent_rounded),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Refer and Earn',
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
          //TODO logout
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Icon(Icons.support_agent_rounded),
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
        ],
      ),
    );
  }
}
//
// (username == '')
// ? Text('Username not found')
// : Text('User found = $username',
// style: GoogleFonts.lato(
// fontSize: 17,
// ),
// ),
