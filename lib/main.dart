import 'package:delivery_app/Screens/LoginPage.dart';
import 'package:delivery_app/Screens/homePage.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';

void main() async{
  bool isLogin = false;
  // final details =await Storage().getData();
  // if(details[0]!=null){
  //   isLogin = true;
  // }else{
  //   isLogin = false;
  // }
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
