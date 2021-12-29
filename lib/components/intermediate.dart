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
import 'package:delivery_app/Screens/trackingScreen.dart';

import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:delivery_app/Services/notification.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:geolocator/geolocator.dart';
class intermediate extends StatefulWidget {
  String orderId;
  String branchId;
  //const intermediate({Key? key}) : super(key: key);
intermediate(this.orderId,this.branchId);
  @override
  _intermediateState createState() => _intermediateState(orderId,branchId);
}

class _intermediateState extends State<intermediate> {
  String orderId;
  String branchId;
  _intermediateState(this.orderId, this.branchId);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Monteserat'),
          home:TrackingPage(orderId,branchId,false),
          debugShowCheckedModeBanner: false,
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationService())
        ]);
  }
}
