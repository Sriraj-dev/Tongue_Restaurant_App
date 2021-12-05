import 'package:delivery_app/Services/DBoperations.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/Services/locationServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:geolocator/geolocator.dart';

String token = '';
String username = '';
String userEmail = '';
String userPhone = '';
String homeAddress = '';
late Position homeLocation ;
late Position userLocation;
String userAddress = '';
// TODO: Store these lists locally;
List userCart = [];
List userFav = [];
List<Map<String,dynamic>> billingItems = [];// List of Maps where Map = {id:ItemUniqueId  ,count: Count}
String msg = '';
List myOrders = [];

Future<int> getUserLocation()async{
 try{
  Position position = await LocationServices().getCurrentPosition();
  userLocation = position;
  userAddress = await LocationServices().getCurrentAddress(position);
  DbOperations().saveHomeAddress(userAddress);
  print('Current address is - $userAddress');
  return 1;
 }catch(e){
  //showSnackBar('Unable to access location!', context,Colors.red);
  userAddress = 'AccessLocation';
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
  myOrders = userInfo['myOrders'];
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
 saveToUserCartDb(id);
}

removeFromUserCart(var id){
 if(userCart.contains(id)){
  userCart.remove(id);
  billingItems.removeWhere((e) {
   return e['id']==id;
  });
 }
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
 print('no.of time cart loop - $j');
}

getUserAddress()async{
 var res = await DbOperations().getHomeAddress();
 //print('No.of addresses = ${res.length}');
 homeAddress = res;
}
