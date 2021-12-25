import 'package:awesome_dialog/awesome_dialog.dart';
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

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  // child:Image.asset('assets/images/man (1).png',height: 150,)
                  // child:Image.asset('assets/images/man.png',height: 150,)
                   child:Image.asset('assets/images/eating-disorder.png',height: 150,)
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
                  decoration: BoxDecoration(
                    color:kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24),),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                          color: Colors.white70,
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
                                      color: Colors.black,
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
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                            child: (homeAddress=='')?
                                Text('Home location is not set!',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                                :Text(
                              homeAddress.substring(0,(homeAddress.length>125)?125:homeAddress.length),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              //maxLines: 3,
                            ),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: (){
                        //       TextEditingController address = new TextEditingController();
                        //       String hintText = 'Type your address';
                        //       AwesomeDialog(
                        //         context: context,
                        //         animType: AnimType.BOTTOMSLIDE,
                        //         showCloseIcon: true,
                        //         dismissOnTouchOutside: false,
                        //         dismissOnBackKeyPress: false,
                        //         btnCancelText: 'Set current location',
                        //         dialogType: DialogType.INFO_REVERSED,
                        //         btnOkOnPress:(address.text=='')?()async{
                        //           print('address is not empty - ${address.text}');
                        //            homeAddress = address.text;
                        //            print('the home address is set temporarly to: $homeAddress');
                        //            try{
                        //              await setHomeLocation();
                        //              if(homeLatitude == 0.0 || homeLongitude == 0.0){
                        //                AwesomeDialog(
                        //                    context: context,
                        //                    showCloseIcon: false,
                        //                    dismissOnBackKeyPress: false,
                        //                    dismissOnTouchOutside: false,
                        //                    dialogType: DialogType.ERROR,
                        //                    title: 'Invalid Address',
                        //                    // btnOkIcon: Icons.cancel,
                        //                    btnOkColor: Colors.red,
                        //                    btnOkOnPress: (){}
                        //                )..show();
                        //              }else{
                        //                DbOperations().clearHomeAddress();
                        //                DbOperations().saveHomeAddress(homeAddress);
                        //                AwesomeDialog(
                        //                    context: context,
                        //                    showCloseIcon: false,
                        //                    dismissOnBackKeyPress: false,
                        //                    dismissOnTouchOutside: false,
                        //                    dialogType: DialogType.SUCCES,
                        //                    title: 'Home Address:',
                        //                    desc: '$homeAddress',
                        //                    btnOkOnPress: (){
                        //                    }
                        //                )..show();
                        //              }
                        //            }catch(e){
                        //              homeAddress = '';
                        //              AwesomeDialog(
                        //                  context: context,
                        //                  showCloseIcon: false,
                        //                  dismissOnBackKeyPress: false,
                        //                  dismissOnTouchOutside: false,
                        //                  dialogType: DialogType.ERROR,
                        //                  title: 'Invalid Address',
                        //                  // btnOkIcon: Icons.cancel,
                        //                  btnOkColor: Colors.red,
                        //                  btnOkOnPress: (){}
                        //              )..show();
                        //            }
                        //
                        //         }:(){
                        //           print('The entered text is - ${address.text}');
                        //           AwesomeDialog(
                        //               context: context,
                        //               showCloseIcon: false,
                        //               dismissOnBackKeyPress: false,
                        //               dismissOnTouchOutside: false,
                        //               dialogType: DialogType.ERROR,
                        //               title: 'Address cannot be empty',
                        //              // btnOkIcon: Icons.cancel,
                        //               btnOkColor: Colors.red,
                        //             btnOkOnPress: (){}
                        //           )..show();
                        //         },
                        //         btnCancelOnPress: ()async{
                        //           await getUserLocation();
                        //           if(userAddress!= "Not Set"){
                        //             await DbOperations().clearHomeAddress();
                        //             DbOperations().saveHomeAddress(userAddress);
                        //             homeAddress = userAddress;
                        //             homeLocation = userLocation;
                        //             homeLatitude = userLocation.latitude;
                        //             homeLongitude = userLocation.longitude;
                        //           }else{
                        //             AwesomeDialog(
                        //               context: context,
                        //               showCloseIcon: false,
                        //               dismissOnBackKeyPress: false,
                        //               dismissOnTouchOutside: false,
                        //               dialogType: DialogType.ERROR,
                        //               title: 'Location Permissions are required!',
                        //               //btnOkIcon: Icons.cancel,
                        //               btnOkColor: Colors.red,
                        //               btnOkOnPress: (){},
                        //             )..show();
                        //           }
                        //         },
                        //         body: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Text('Add your Home Address',
                        //               style: GoogleFonts.lato(
                        //                 fontSize: 17,
                        //               ),
                        //             ),
                        //             SizedBox(height: 10,),
                        //             Padding(
                        //               padding: const EdgeInsets.symmetric(horizontal: 10),
                        //               child: TextField(
                        //                 controller: address,
                        //                 decoration: InputDecoration(
                        //                   hintText: hintText,
                        //                   helperText: 'Set current location instead',
                        //                   //errorText: 'Address cannot be empty',
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ) ..show();
                        //     },
                        //     icon: Icon(Icons.edit_rounded)
                        // ),
                        InkWell(
                            onTap: ()async{
                              await editHomeAddress(context);
                            },
                            child: Icon(Icons.edit_rounded)
                        ),
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
        ),
      ),
    );
  }

  Future<void> editHomeAddress(BuildContext context) async {
    TextEditingController address = new TextEditingController();
    String hintText = 'Type your address';
    AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      showCloseIcon: true,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnCancelText: 'Set current location',
      dialogType: DialogType.INFO_REVERSED,
      btnOkOnPress:()async{
        print('address is not empty - ${address.text}');
        var tempAddress = address.text;
        print('the home address is set temporarly to: $tempAddress');
        try{
          await setHomeLocation(tempAddress);
          if(homeLatitude == 0.0 || homeLongitude == 0.0){
            AwesomeDialog(
                context: context,
                showCloseIcon: false,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                dialogType: DialogType.ERROR,
                title: 'Invalid Address',
                // btnOkIcon: Icons.cancel,
                btnOkColor: Colors.red,
                btnOkOnPress: (){}
            )..show();
          }else{
            DbOperations().clearHomeAddress();
            DbOperations().saveHomeAddress(tempAddress);
            homeAddress = tempAddress;
            AwesomeDialog(
                context: context,
                showCloseIcon: false,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                dialogType: DialogType.SUCCES,
                title: 'Home Address:',
                desc: '$homeAddress',
                btnOkOnPress: (){
                  setState(() {

                  });
                }
            )..show();
          }
        }catch(e){
          homeAddress = '';
          AwesomeDialog(
              context: context,
              showCloseIcon: false,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              dialogType: DialogType.ERROR,
              title: 'Invalid Address',
              // btnOkIcon: Icons.cancel,
              btnOkColor: Colors.red,
              btnOkOnPress: (){}
          )..show();
        }
      },
      btnCancelOnPress: ()async{
        await getUserLocation();
        if(userAddress!= "Not Set"){
          await DbOperations().clearHomeAddress();
          DbOperations().saveHomeAddress(userAddress);
          homeAddress = userAddress;
          homeLocation = userLocation;
          homeLatitude = userLocation.latitude;
          homeLongitude = userLocation.longitude;
          AwesomeDialog(
              context: context,
              showCloseIcon: false,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              dialogType: DialogType.SUCCES,
              title: 'Home Address:',
              desc: '$homeAddress',
              btnOkOnPress: (){
                setState(() {

                });
              }
          )..show();
        }else{
          AwesomeDialog(
            context: context,
            showCloseIcon: false,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.ERROR,
            title: 'Location Permissions are required!',
            //btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
            btnOkOnPress: (){},
          )..show();
        }
      },
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Add your Home Address',
            style: GoogleFonts.lato(
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: address,
              decoration: InputDecoration(
                hintText: hintText,
                helperText: 'Set current location instead',
                //errorText: 'Address cannot be empty',
              ),
            ),
          ),
        ],
      ),
    ) ..show();
  }

  void logOutCurrentUser() async{
    await Storage().deleteData();
    await DbOperations().clearDataBase();
    Navigator.of(context).popUntil((route) => false);
    Phoenix.rebirth(context);
    //Navigator.push(context, route)
  }
}
