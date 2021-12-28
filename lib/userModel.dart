import 'dart:async';

import 'package:delivery_app/Services/DBoperations.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/Services/locationServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

String token = '';
String username = '';
String userEmail = '';
String userPhone = '';
String homeAddress = '';
late Position homeLocation;
late Position userLocation;
late double homeLatitude;
late double homeLongitude;
String userAddress = '';
List userCart = [];
List userFav = [];
List<Map<String,dynamic>> billingItems = [];// List of Maps where Map = {id:ItemUniqueId  ,count: Count}
List myOrders = [];
List offers = [];
bool gotOffers = false;
StreamController<bool> initialisedOffers = StreamController<bool>.broadcast();
StreamController<int> cartCount = StreamController<int>.broadcast();
StreamController<bool> initialisedOrders = StreamController<bool>.broadcast();
bool gotOrders = false;

List branches = [];
Map selectedBranch = {};
double nearestBranch = 0.0;
Future<int> getUserLocation()async{
 try{
  print('trying to get the current location');
  Position position = await LocationServices().getCurrentPosition();
  userLocation = position;
  userAddress = await LocationServices().getCurrentAddress(position);
  print('Current address is - $userAddress');
  return 1;
 }catch(e){
 // showSnackBar('Unable to access location!', context,Colors.red);
  userAddress = 'Not Set';
  print('userAddress is - $userAddress');
  return 0;
 }
}

getUserInfo() async {
 print('getting User info');
 Map<String,dynamic> userInfo = await ApiServices().getUserInfo(token);
 print('gotUser info');
 if(userInfo['username'] != ''){
  username = userInfo['username'];
  userEmail = userInfo['email'];
  userPhone = userInfo['phone'];
 // myOrders = userInfo['myOrders'];
 }
}

addToUserCart(var id){
 Map<String,dynamic> cartItem = {
  'id': id,
  'count': 1
 };
 if(!userCart.contains(id)){
  userCart.add(id);
  billingItems.add(cartItem);
 }
 cartCount.sink.add(userCart.length);
 saveToUserCartDb(id);
}

removeFromUserCart(var id){
 if(userCart.contains(id)){
  userCart.remove(id);
  billingItems.removeWhere((e) {
   return e['id']==id;
  });
 }
 cartCount.sink.add(userCart.length);
 deleteFromUserCartDb(id);
}

changeCount(var id ,bool isIncreased){
 if(userCart.contains(id)){
  final index = billingItems.indexWhere((e){
   return e['id'] == id;
  });
  billingItems[index]['count'] += (isIncreased)?1:-1;
  if(billingItems[index]['count'] ==0){
   removeFromUserCart(id);
  }
 }else{
  if(isIncreased){
   addToUserCart(id);
  }
 }
}
getCount(var id)
{
 if(userCart.contains(id)){
  final index = billingItems.indexWhere((e){
   return e['id'] == id;
  });
  return billingItems[index]['count'] ;
 }
}

addToUserFav(var id){
 if(!userFav.contains(id)){
  userFav.add(id);
 }
 saveToUserFavDb(id);
}

removeFromUserFav(var id){
 if(userFav.contains(id)){
  userFav.remove(id);
 }
 deleteFromUserFavDb(id);
}

saveToUserFavDb(var id)async{
  DbOperations().save(false, id);
}

saveToUserCartDb(var id)async{
 DbOperations().save(true, id);
}

deleteFromUserFavDb(var id)async{
 DbOperations().delete(false, id);
}

deleteFromUserCartDb(var id)async{
 DbOperations().delete(true, id);
}

getUserFav()async{
 var res = await DbOperations().getData(false);
 var i =0;
 res.forEach((e){
  //userFav.add(e['iid']);
  i++;
  if(!userFav.contains(e['iid'])){
   userFav.add(e['iid']);
  }
 });
 print('No.of times loop - $i');
}

getUserCart()async{
 var res = await DbOperations().getData(true);
 int j=0;
 res.forEach((e){
  Map<String,dynamic> cartItem = {
   'id': e['iid'],
   'count': 1
  };
  if(!userCart.contains(e['iid'])){
   userCart.add(e['iid']);
   billingItems.add(cartItem);
  }
 });
 cartCount.sink.add(userCart.length);
 print('no.of time cart loop - $j');
}


getMyOrders() async{
 myOrders = [];
 initialisedOrders.sink.add(false);
 gotOrders = false;
 var result = await ApiServices().getMyOrders(token);
 print('myOrderDetails are - $result');
 if(result['status']){
  List<dynamic> myOrderDetails = result['myOrders'];
  for(int i=0;i<myOrderDetails.length;i++){
   var e = myOrderDetails[i];
   Map<String,dynamic> orderData = {
    'branchId': e['branchId'],
    'orderId': e['orderId']
   };
   var response = await ApiServices().getOrderDetails(orderData);
   if(response['status']){
    var order = response['order'];
    //if order['delivered'] == true then it is pastOrder else it is Current(Ongoing) Order.
    //remember that you can access the time of Orderplacemnet by order['createdAt']

    myOrders.add(order);
   }else{
    var order = {
     'orderId': e['orderId'],
     'branchId':e['branchId'],
     'msg': response['msg']
    };
    //TODO: remove from MyOrders
    myOrders.add(order);
   }
  }
  initialisedOrders.sink.add(true);
  print('got my Orders');
  gotOrders = true;
  return;
 }else{
  myOrders = [];
  initialisedOrders.sink.add(true);
  print('error in getting Orders');
  gotOrders = true;
  //showSnackBar('An Error Occurred!!', context, Colors.red);
 }
}

getMyOffers()async{
 gotOffers = false;
 initialisedOffers.sink.add(false);
 offers = [];
 //TODO:Get offers from the backend.
 Map<String,dynamic> data = {
  "branchId": selectedBranch['_id']
 };
 offers = await ApiServices().getOffers(data);
 gotOffers = true;
 initialisedOffers.sink.add(true);
}

getHomeAddress()async{
 var res = await DbOperations().getHomeAddress();
 //print('No.of addresses = ${res.length}');
 homeAddress = res;
}

setHomeLocation(String tempAddress)async{
 Location tempLocation = await LocationServices().getPositionFromAddress(tempAddress);

 homeLatitude = tempLocation.latitude;
 homeLongitude = tempLocation.longitude;
}

getAllBranches()async{
 branches = await ApiServices().getBranches();
 if(branches.length !=0){
  selectedBranch = branches[0];
 }
}

checkNearestBranch(Position sourcePosition){
 double minDist = (Geolocator.distanceBetween(sourcePosition.latitude,sourcePosition.longitude,
     double.parse(selectedBranch['latitude']),double.parse(selectedBranch['longitude'])))/1000;
 nearestBranch = minDist;
 branches.forEach((element) {
   double x = calculateDistance(sourcePosition.latitude,sourcePosition.longitude, element['latitude'],element['longitude']);
   if(x<minDist){
    selectedBranch = element;
    nearestBranch = x;
    minDist =x;
   }
 });
 print('The nearest Branch - $selectedBranch , distance - $nearestBranch');
}
calculateDistance(double startLatitude,double startLongitude,String endLatitude,String endLongitude){
 return (Geolocator.distanceBetween(startLatitude,startLongitude,
     double.parse(endLatitude),double.parse(endLongitude)))/1000;
}
