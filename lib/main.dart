import 'package:delivery_app/Screens/LoginPage.dart';
import 'package:delivery_app/Screens/homePage.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  bool isLogin = false;
  final value  = await storage.read(key: 'username');
  print('value is - $value');
  if(value!=null){
    isLogin = true;
  }else{
    isLogin = false;
  }
  print('islogin is - $isLogin');
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor ,
          scaffoldBackgroundColor: Colors.white ,
          textTheme: TextTheme(
          bodyText1: TextStyle(color: ksecondaryColor ),
            bodyText2: TextStyle(color: ksecondaryColor ),
          ) ,
        ),
        home: (isLogin)?homePage():LoginPage(),
  ));
}
