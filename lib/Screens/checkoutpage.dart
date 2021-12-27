import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_app/Screens/offers.dart';
import 'package:delivery_app/Screens/trackingScreen.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:delivery_app/Services/BillingServices.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:geolocator/geolocator.dart';

class checkout extends StatefulWidget {
  //const checkout({Key? key}) : super(key: key);
  num bill;
  String deliveryAddress;
  double deliveryLatitude;
  double deliveryLongitude;
  checkout(this.bill,this.deliveryAddress,this.deliveryLatitude,this.deliveryLongitude);
  @override
  _checkoutState createState() => _checkoutState(bill,deliveryAddress,deliveryLatitude,deliveryLongitude);
}

class _checkoutState extends State<checkout> {

  num bill;

  _checkoutState(this.bill,this.deliveryAddress,this.deliveryLatitude,this.deliveryLongitude);
  List<String> address = userAddress.split(',');
  //Position deliveryPosition = userLocation;
  String deliveryAddress;
  double deliveryLatitude;
  double deliveryLongitude;
  bool warningShown = false;
  bool placingOrder = false;
  List e = userCart;
  //-------------------------------payment------------------
  late Razorpay razorpay;
  @override
  void initState(){
    super.initState();
    razorpay =new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,handlerExternalWallet);
  }
  @override
  void dispose(){
    super.dispose();
    razorpay.clear;
  }
  void openCheckout(){
    var options={
      "key":"rzp_test_dH8wBxdVVrmtZX",
      "amount":bill*100,
      "name":username,
      "description":"Tongue order",
      "prefill":{
        "contact":userPhone,
        "email":userEmail,
      },
      "external":{
        "wallets":["paytm"],
      }
    };
    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }
  void handlerPaymentSuccess()async{
    //AfterPayment:
    setState(() {
      placingOrder = true;
    });
    Map<String, dynamic> orderDetails = {
      'customerName': username,
      'customerPhone': userPhone,
      'customerAddress': deliveryAddress,
      'latitude': deliveryLatitude.toString(),
      'longitude': deliveryLongitude.toString(),
      'orderItems': billingItems,
      'amountPaid': bill.toString(),
      'branchId': "61a9b1c56a629f43c19616c0",
      'accepted': false
    };
    var res = await ApiServices().placeOrder(orderDetails);
    if (res != 'false') {
      Map<String,dynamic> orderDetails = {
        'orderId': res,
        'branchId':"61a9b1c56a629f43c19616c0"
      };
      Map<String,dynamic> data = {
        'orderDetails': orderDetails
      };
      await ApiServices().addToMyOrders(data ,token);
      showSnackBar('Order placed!', context, Colors.green);
      getMyOrders();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => TrackingPage(res,"61a9b1c56a629f43c19616c0")));
      //TODO: clear User cart from Database;
    } else {
      showSnackBar('Failed to place Order', context, Colors.red);
      Navigator.pop(context);
    }
    print("Payment success");
  }
  void handlerErrorFailure(){
    showSnackBar('Failed to place Order', context, Colors.red);
    print("Payment error");
  }
  void handlerExternalWallet(){
    showSnackBar('external wallet paid', context, Colors.red);

    print("external wallet");

  }

  //--------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    address = deliveryAddress.split(',');

    return Scaffold(
      backgroundColor: Background_Color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48.0, left: 16),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    iconSize: 25,
                    // onPressed: () {
                    //   Navigator.pop(context);
                    // },
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 64, top: 48),
                child: Text(
                  'CHECKOUT',
                  style: TextStyle(
                      fontSize: 24,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Text(
                    'Address details',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                //dialogueBox
                GestureDetector(
                  onTap: () async{
                    await changeDeliveryLocation(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 16),
                    child: Text('change',
                        style: TextStyle(fontSize: 20, color: kPrimaryColor)),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${address[0]}',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Container(
                        height: 1,
                        color: kPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        (address.length>=3)? '${address[1]},${address[2]} ...'
                            :(address.length>=2)?'${address[1]} ...':'...',
                        style: TextStyle(
                            fontSize: 15, color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Container(
                        height: 1,
                        color: kPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        userPhone,
                        style: TextStyle(
                            fontSize: 20, color: Colors.black.withOpacity(0.4)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: total_order(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Offers()));
                    },
                    child: Text('Apply Offer',
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        color: kPrimaryColor
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32),
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Total Bill ',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '₹ ' + bill.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(30),
          child: GestureDetector(
            onTap: () async {
              openCheckout();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 105, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kPrimaryColor,
              ),
              child: (placingOrder)?CircularProgressIndicator():Text(
                'PLACE ORDER ',
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

  Future<void> changeDeliveryLocation(BuildContext context) async {
    AwesomeDialog(
        context: context,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        showCloseIcon: true,
        dialogType: DialogType.INFO_REVERSED,
        padding: EdgeInsets.symmetric(horizontal: 5),
        title: 'Choose your Delivery Location!',
        btnOkText: 'Current location',
        btnCancelText: 'Home Location',
        btnOkOnPress: ()async{
          await getUserLocation();
          if(userAddress !='Not Set'){
            AwesomeDialog(
                context: context,
                showCloseIcon: false,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                dialogType: DialogType.SUCCES,
                title: 'Delivery Location:',
                desc: '$userAddress',
                btnOkOnPress: (){
                  setState(() {
                    deliveryAddress = userAddress;
                    deliveryLatitude = userLocation.latitude;
                    deliveryLongitude = userLocation.longitude;
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
        btnCancelOnPress: (){
          if(homeAddress == ''){
            AwesomeDialog(
              context: context,
              showCloseIcon: false,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              dialogType: DialogType.INFO_REVERSED,
              title: 'Home Location is not set!',
              desc: 'Please set your home location in your profile',
              //btnOkIcon: Icons.cancel,
              btnOkColor: Colors.red,
              btnOkOnPress: (){
              },
            )..show();
          }else{
            AwesomeDialog(
                context: context,
                showCloseIcon: false,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                dialogType: DialogType.SUCCES,
                title: 'Delivery Location:',
                desc: '$homeAddress',
                btnOkOnPress: (){
                  setState(() {
                    deliveryAddress = homeAddress;
                    deliveryLatitude = homeLatitude;
                    deliveryLongitude = homeLongitude;
                  });
                }
            )..show();
          }
        }
    )..show();
  }

  Column total_order() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width:100,child: Text('Dish',style:TextStyle(fontWeight:FontWeight.bold ,color:Colors.black))),
              Container(width:60,child: Text('quantity',style:TextStyle(fontWeight:FontWeight.bold,color:Colors.black))),
              Container(width:50,child: Text('Amount',style:TextStyle(fontWeight:FontWeight.bold,color:Colors.black))),
            ],
          ),
        ),
        Container(
          height: 135,
          child: ListView.builder(
              itemCount: e.length,
              itemBuilder: (context, index) {
                print('e.length is ${e.length}');
                var req = menu.firstWhere((map) {
                  return map['id'] == e[index];
                });
                var item = req['item'];
                if(!item['isAvailable']){
                  //TODO: Remove from user cart.
                  removeFromUserCart(req['id']);
                    bill = Billing().calculateBill(billingItems);
                  if(!warningShown){
                    warningShown = true;
                    Future.delayed(Duration.zero,(){
                      AwesomeDialog(
                        context: context,
                        dismissOnTouchOutside: false,
                        dismissOnBackKeyPress: false,
                        showCloseIcon: false,
                        dialogType: DialogType.WARNING,
                        title: 'Items removed!',
                        desc: 'Some unavailable items are removed from cart!',
                        btnOkOnPress: (){
                          setState(() {

                          });
                        },
                        btnOkColor: Colors.red,
                      )..show();
                    });
                  }
                }
                return (item['isAvailable']==true)?Container(
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width:100,child: Text(item['itemName'],style:TextStyle(color:Colors.black))),
                        Container(width:50,child: Text(getCount(e[index]).toString(),style:TextStyle(color:Colors.black))),
                        Container(width:50,child: Text('₹ '+item['cost'],style:TextStyle(color:Colors.black))),
                      ],
                    ),
                  ),
                ):Container();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width:150,child: Text('Delivery charges',style:TextStyle(fontWeight:FontWeight.bold ,color:Colors.black))),
              Container(width:50,child: Text('₹ 20',style:TextStyle(fontWeight:FontWeight.bold,color:Colors.black))),
            ],
          ),
        ),

      ],
    );
  }
}
//TODO: Add the - (Apply Offer) button.