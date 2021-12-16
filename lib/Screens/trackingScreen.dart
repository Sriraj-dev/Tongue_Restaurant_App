import 'dart:async';
import 'package:delivery_app/Screens/help_support.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackingPage extends StatefulWidget {
  //const TrackingPage({Key? key}) : super(key: key);
  String orderId;
  String branchId;
  TrackingPage(this.orderId,this.branchId);
  @override
  _TrackingPageState createState() => _TrackingPageState(orderId,branchId);
}

class _TrackingPageState extends State<TrackingPage> {
  String orderId;
  String branchId;
  _TrackingPageState(this.orderId,this.branchId);

  bool accepted = false;
  bool assigned = false;
  bool outForDelivery = false;
  bool delivered = false;
  int activeStep = 0;
  Map<String,dynamic> partnerDetails = {};
  StreamController<bool> isAssigned = new StreamController();
  generateYourOrder(var orderItems){
    String yourOrder = '';
    orderItems.forEach((map){
      var req = menu.firstWhere((element) => element['id']==map['id']);
      yourOrder += map['count'].toString()+ ' '+req['item']['itemName']+',';
    });
    yourOrder = yourOrder.substring(0,yourOrder.length-1);
    yourOrder+='.';
    return yourOrder;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isAssigned.close();
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
          onPressed: (){
            Navigator.of(context).pop();
          },
          color: kTextColor,
        ),
        title: Text('Order details',
          style: GoogleFonts.lato(
            color: kTextColor
          ),
        ),
      ),

      backgroundColor: Background_Color,
      body: StreamBuilder<Map<String,dynamic>>(
        stream: getOrderDetails(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return loadingScreen();
            default:
              if(snapshot.hasError){
                return errorScreen(context,'An error Occurred while fetching OrderDetails');
              }
              else{
                if(snapshot.hasData){
                  Map<String,dynamic> orderDetails = snapshot.data as Map<String,dynamic>;
                  if(orderDetails['customerName'] == ""){
                    return errorScreen(context, orderDetails['msg']);
                  }else{
                    accepted = orderDetails['accepted'];
                    assigned = orderDetails['assigned'];
                    isAssigned.sink.add(assigned);
                    outForDelivery = orderDetails['outForDelivery'];
                    delivered = orderDetails['delivered'];
                    activeStep = 0;
                    activeStep = (accepted)?(outForDelivery)?2:1:0;
                    return Padding(
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
                                    Text(
                                      (orderDetails['delivered'])?'Order Delivered':'Out for delivery',
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
                                        Text(orderDetails['customerAddress']+'.',
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
                                        Text(generateYourOrder(orderDetails['orderItems']),
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
                                                (!orderDetails['assigned'])?Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                                  child: Text('We will Assign a deliveryPartner soon to you address',
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                        letterSpacing: 1
                                                    ),
                                                  ),
                                                ):(partnerDetails=={})?FutureBuilder(
                                                  future: getDeliveryPartner(orderDetails['assignedTo']),
                                                  builder: (context, snapshot) {
                                                    return deliveryPartnerWidget();
                                                  }
                                                ):deliveryPartnerWidget()
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
                    );
                  }
                }

              }
              return Container();
          }

        }
      ),
      floatingActionButton: StreamBuilder<Object>(
        stream: isAssigned.stream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: (assigned)?2:0,
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 105, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (assigned)?kPrimaryColor:ksecondaryColor,
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
          );
        }
      ),
    );
  }

  Padding deliveryPartnerWidget() {
    return (partnerDetails['Name']==''|| partnerDetails['Name']==null)?Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Text('Could not get the deliveryPartner details',
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
                                                              Text(partnerDetails['Name'],
                                                                style: GoogleFonts.lato(
                                                                    fontSize: 16,
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                              SizedBox(height: 0,),
                                                              Row(
                                                                //mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(partnerDetails['phone'],
                                                                      style: GoogleFonts.lato(
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          letterSpacing: 1
                                                                      )),
                                                                  //TODO: Call the driver
                                                                  IconButton(onPressed: (){
                                                                    launch("tel://${partnerDetails['phone']}");
                                                                  }, icon: Icon(Icons.call,color: Colors.white,))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
  }

  Stream<Map<String,dynamic>> getOrderDetails()=>
      Stream.periodic(
      Duration(seconds: 10)
  ).asyncMap((_) => getDetails());

  Future<Map<String,dynamic>> getDetails()async{
    print("orderId is $orderId");
    print("branchId is $branchId");
    Map<String, dynamic> orderData = {
      'orderId': orderId,
      'branchId': branchId
    };
    var result =await ApiServices().getOrderDetails(orderData);
    print("result is - ${result}");
    if(result['status']){
      return result['order'];
    }else{
      Map<String ,dynamic> data = {
        "msg": result['msg'],
        "customerName": ""
      };
      return data;
    }
  }

  getDeliveryPartner(String partnerId)async{
    Map<String,dynamic> data = {
      'partnerId': partnerId,
      'branchId':branchId
    };
    var response = await ApiServices().getDeliveryPartnerDetails(data);

    partnerDetails = response;
  }

  Center loadingScreen() {
    return Center(
              //This is the Loading Screen.
              child: CircularProgressIndicator(),
            );
  }

  Center errorScreen(BuildContext context,String error) {
    return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(),
                    Text(error,
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        color: kPrimaryColor
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('orderId:$orderId',
                      style: GoogleFonts.lato(
                          fontSize: 17,
                          color: ksecondaryColor
                      ),
                    ),
                    SizedBox(height: 15,),
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
                  ],
                ),
              );
  }

}

//TODO: edit loadingScreen,edit ErrorScreen.
