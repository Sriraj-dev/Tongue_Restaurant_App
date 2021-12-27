import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:delivery_app/Screens/ProfileScreen.dart';
import 'package:delivery_app/Screens/cart.dart';
import 'package:delivery_app/Screens/homePage.dart';
import 'package:delivery_app/Screens/wishList.dart';
import 'package:delivery_app/Services/DBoperations.dart';
import 'package:delivery_app/Services/localStorage.dart';
import 'package:delivery_app/Services/locationServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PageManager extends StatefulWidget {
  const PageManager({Key? key}) : super(key: key);

  @override
  _PageManagerState createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  int currentIndex = 0;
  final pages = [homePage(), wish_list(), cart(), ProfileScreen()];

  checkServiceAvailability(){
    checkNearestBranch(userLocation);
    if(nearestBranch>10.0){
      Future.delayed(Duration(seconds: 4),(){
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
      });

    }
  }
  @override
  void initState() {
    super.initState();
    getMyOrders();
    checkServiceAvailability();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: StreamBuilder<int>(
        stream: cartCount.stream,
        builder: (context, snapshot) {
          String count = userCart.length.toString()=='0'?'':userCart.length.toString();
          return ConvexAppBar.badge(
            {
              //2:userCart.length.toString()=='0'?'':userCart.length.toString(),
              2:count
            },
            color: kPrimaryColor,
            backgroundColor: Colors.white,
            activeColor: kPrimaryColor,
            top: -16,
            items: [
              TabItem(icon: Icons.home),
              TabItem(icon: Icons.favorite_border),
              TabItem(icon:Icons.shopping_bag_outlined,

                 ),
              TabItem(icon: Icons.person),
            ],
            initialActiveIndex: 0, //optional, default as 0
            onTap: (int i) {
              //3
              setState(() {
                currentIndex = i;
              });
            },
          );
        }
      ),
    );
  }
}
