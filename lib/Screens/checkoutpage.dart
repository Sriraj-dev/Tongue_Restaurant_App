import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_app/Screens/offers.dart';
import 'package:delivery_app/Screens/trackingScreen.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:delivery_app/Services/BillingServices.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:delivery_app/components/intermediate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:delivery_app/Services/notification.dart';

import 'package:google_fonts/google_fonts.dart';

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
  bool cashOnDelivery = false;
  bool payNow = true;
  String deliveryAddress;
  double deliveryLatitude;
  double deliveryLongitude;
  bool warningShown = false;
  bool placingOrder = false;
  bool applyingOffer = false;
  bool appliedOffer = false;
  num offerAmount = 0.0;
  List e = userCart;
  List paymentOptions = ['Pay now','Cash On Delivery'];
  //-------------------------------payment------------------
  late Razorpay razorpay;
  @override
  void initState(){
    super.initState();
    getMyOffers();
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
      'branchId': selectedBranch['_id'],
      'accepted': false,
      'cashOnDelivery':cashOnDelivery,
      'amountReceived':!cashOnDelivery
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
          MaterialPageRoute(builder: (context) => intermediate(res,"61a9b1c56a629f43c19616c0")));
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
    return MultiProvider(
      child: Scaffold(
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Branch :',
                      style: GoogleFonts.lato(
                          color: kPrimaryColor,
                          fontSize: 18
                      ),
                    ),
                    SizedBox(width: 10,),
                    DropdownButton<Map>(
                      value: selectedBranch,
                      onChanged: (newValue){
                        setState(() {
                          selectedBranch = newValue??{};
                        });
                      },
                      items: branches.map((e) => DropdownMenuItem<Map>(
                        child: Text(e['branchArea']),
                        value: e,
                      )).toList(),
                    )
                  ],
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

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                  child: GestureDetector(
                    onTap: ()async{
                      var tempCode=await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Offers(true)));
                      if(tempCode!=null){
                        print('im applying offer');
                        String offerCode = tempCode;
                        setState(() {
                          applyingOffer = true;
                          appliedOffer = false;
                          bill = bill+offerAmount;
                        });
                        applyOffer(offerCode);
                        print('Offer code received- $offerCode');
                      }else{
                        print('not received');
                      }
                    },
                    child: Text(
                      (appliedOffer)?'Offer Applied!':'Apply Offer',
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        color: (appliedOffer)?Colors.green:kPrimaryColor
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

                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: (applyingOffer)?JumpingText('₹ ...',
                        style: GoogleFonts.lato(fontSize: 15,color: Colors.black),
                      ):Text(
                        '₹ ' + bill.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              paymentChoosingButton(),
              Expanded(
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(30),
                  child: GestureDetector(
                    onTap: (applyingOffer)?(){}:() async {
                      double distance =calculateDistance(deliveryLatitude,deliveryLongitude,selectedBranch['latitude'],selectedBranch['longitude']);
                      if(distance>10.0){
                        AwesomeDialog(
                            context: context,
                            showCloseIcon: false,
                            dismissOnBackKeyPress: false,
                            dismissOnTouchOutside: false,
                            dialogType: DialogType.WARNING,
                            title: 'Delivery service is not available in your location!',
                            btnOkOnPress: (){},
                            btnOkColor: Colors.red
                        )..show();
                      }else{
                        if(payNow){
                          openCheckout();
                        }else if(cashOnDelivery){
                          handlerPaymentSuccess();
                        }
                        //openCheckout();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kPrimaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (placingOrder)?CircularProgressIndicator():
                          (applyingOffer)?JumpingText('    ...    ',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ):Text(
                            'PLACE ORDER ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      providers: [
        ChangeNotifierProvider(
          create: (_) => NotificationService(),
        ),
      ],
    );




  }

  applyOffer(offerCode)async{
    Map<String,dynamic> data = {
      "branchId": selectedBranch['_id'],
      "offerCode":offerCode,
      "billingItems":billingItems,
      "bill":bill
    };
    var result = await ApiServices().applyCouponCode(data);
    if(result['status']){
      appliedOffer = true;
      applyingOffer = false;
      offerAmount = bill-result['cost'];
      bill = bill - offerAmount;
      AwesomeDialog(
        context: context,
        showCloseIcon: false,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.SUCCES,
        title: result['msg'],
        desc: 'You have saved ₹$offerAmount',
        btnOkOnPress: (){
          setState(() {

          });
        }
      )..show();
    }else{
      appliedOffer = false;
      applyingOffer = false;
      offerAmount = 0;
      AwesomeDialog(
          context: context,
          showCloseIcon: false,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.ERROR,
          title: 'Failed!',
          desc: result['msg'],
          btnOkOnPress: (){
            setState(() {

            });
          }
      )..show();
    }
  }

   paymentChoosingButton() {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 8.0),
       child: DropdownButton(
         value: (payNow)?paymentOptions[0]:paymentOptions[1],
         onChanged: (newValue){
           if(newValue == paymentOptions[0]){
             setState(() {
               payNow = true;
               cashOnDelivery = false;
             });
           }else{
             setState(() {
               cashOnDelivery = true;
               payNow = false;
             });
           }
         },
         items: paymentOptions.map((element) => DropdownMenuItem(
           child: Text(element),
           value: element,
         )).toList(),
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

