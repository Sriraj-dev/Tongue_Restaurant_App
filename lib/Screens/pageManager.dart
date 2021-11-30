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

  void getUserLocation()async{
    try{
      Position position = await LocationServices().getCurrentPosition();
      userLocation = position;
      userAddress = await LocationServices().getCurrentAddress(position);
      DbOperations().saveHomeAddress(userAddress);
      print(userAddress);
    }catch(e){
      showSnackBar('Unable to access location!', context);
    }
  }
  @override
  void initState() {
    super.initState();

    getUserLocation();
  }

  @override
  void dispose() {
    super.dispose();

    LocalDB.instance.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ConvexAppBar.badge(
        {
          2:userCart.length.toString()=='0'?'':userCart.length.toString(),
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
      ),
    );
  }
}
