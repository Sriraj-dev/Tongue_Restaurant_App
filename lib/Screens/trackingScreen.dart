import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/Screens/preparing_food.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackingPage extends StatefulWidget {
  //const TrackingPage({Key? key}) : super(key: key);
  String orderId;
  TrackingPage(this.orderId);
  @override
  _TrackingPageState createState() => _TrackingPageState(orderId);
}

class _TrackingPageState extends State<TrackingPage> {
  String orderId;
  _TrackingPageState(this.orderId);

  bool accepted = false;
  bool assigned = false;
  bool outForDelivery = false;
  int activeStep = 0;


  generateYourOrder(){
    String yourOrder = '';
    billingItems.forEach((map){
      var req = menu.firstWhere((element) => element['id']==map['id']);
      yourOrder += map['count'].toString()+ ' '+req['item']['itemName']+',';
    });
    yourOrder = yourOrder.substring(0,yourOrder.length-1);
    yourOrder+='.';
    return yourOrder;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Background_Color,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: (){},
          color: kTextColor,
        ),
        title: Text('Order details',
          style: GoogleFonts.lato(
            color: kTextColor
          ),
        ),
      ),

      backgroundColor: Background_Color,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height*0.37,
                  child: IconStepper(
                    alignment: Alignment.topLeft,
                    direction: Axis.vertical,
                    lineLength: size.height*0.06,
                    icons: [
                      !(activeStep==0)?Icon(Icons.verified_rounded):Icon(Icons.alarm_rounded),
                      Icon(Icons.restaurant_menu_rounded),
                      Icon(Icons.delivery_dining_rounded)
                    ],
                    activeStep: activeStep,
                    nextButtonIcon: null,
                    enableNextPreviousButtons: false,
                    enableStepTapping: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Text('Awaiting for Order confirmation',
                        style: GoogleFonts.lato(
                          fontWeight: (activeStep==0)?FontWeight.w600:FontWeight.w400,
                          color: (activeStep==0)?kPrimaryColor:ksecondaryColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: size.height*0.06+34,),
                      Text('Preparing your food',
                        style: GoogleFonts.lato(
                          fontWeight: (activeStep==1)?FontWeight.w600:FontWeight.w400,
                          color: (activeStep==1)?kPrimaryColor:ksecondaryColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: size.height*0.06+34,),
                      Text('Out for delivery',
                        style: GoogleFonts.lato(
                          fontWeight: (activeStep==2)?FontWeight.w600:FontWeight.w400,
                          color: (activeStep==2)?kPrimaryColor:ksecondaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Container(
              height: size.height*0.38,
              child: ListView(
                children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('OrderId:$orderId',
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  color: kTextColor,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('Delivery Address:',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: kTextColor
                          ),
                        ),
                        Text(userAddress+'.',
                          style: GoogleFonts.lato(
                            color: kTextLightColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: 0.5
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text('Your Order:',
                          style: GoogleFonts.lato(
                              fontSize: 16,
                              color: kTextColor
                          ),
                        ),
                        Text(generateYourOrder(),
                          style: GoogleFonts.lato(
                              color: kTextLightColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              letterSpacing: 0.5
                          ),
                        ),
                        SizedBox(height: 20,),
                        Material(
                          elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 10),
                                  child: Text('DeliveryPartner:',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                (assigned)?Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                  child: Text('We will Assign a deliveryPartner soon to you address',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        letterSpacing: 1
                                    ),
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.delivery_dining_rounded,color: Colors.white,),
                                      SizedBox(width: 20,),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Mahender',
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  color: Colors.white
                                              ),
                                            ),
                                            SizedBox(height: 0,),
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('8008053826',
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                        letterSpacing: 1
                                                    )),
                                                //TODO: Call the driver
                                                IconButton(onPressed: (){
                                                  launch("tel://9618111780}");
                                                }, icon: Icon(Icons.call,color: Colors.white,))
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 105, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryColor,
              ),
              child: Text(
                'Track your order',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
