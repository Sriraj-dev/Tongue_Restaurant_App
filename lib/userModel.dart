import 'package:delivery_app/Services/apiservices.dart';
import 'package:geolocator/geolocator.dart';

String token = '';
String username = '';
String userEmail = '';
String userPhone = '';
String homeAddress = '';
late Position homeLocation ;
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
