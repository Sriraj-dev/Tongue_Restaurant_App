import 'package:delivery_app/Services/DBoperations.dart';
import 'package:delivery_app/Services/apiservices.dart';
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
String msg = '';
List myOrders = [];

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
 if(!userCart.contains(id)){
  userCart.add(id);
 }
}

removeFromUserCart(var id){
 if(userCart.contains(id)){
  userCart.remove(id);
 }
}

addToUserFav(var id){
 if(!userFav.contains(id)){
  userFav.add(id);
 }
}

removeFromUserFav(var id){
 if(userFav.contains(id)){
  userFav.remove(id);
 }
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
 res.forEach((e){
  userFav.add(e['iid']);
 });
 print("User Fav is - $res  , $userFav");
}

getUserCart()async{
 var res = await DbOperations().getData(true);
 res.forEach((e){
  userCart.add(e['iid']);
 });
 print("User cart is - $res  , $userCart");
}

getUserAddress()async{
 var res = await DbOperations().getHomeAddress();
 homeAddress = res;
 print('Home address is - $homeAddress');
}
